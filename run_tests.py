import os
import sys, logging
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import duckdb
import pymysql
from enum import Enum
import itertools
import re
import math

logging.basicConfig(stream=sys.stderr, level=logging.WARNING) # change level to INFO or DEBUG to see more output

PG_ABS_SRCDIR = os.environ.get('PG_ABS_SRCDIR')
PG_LIBDIR = os.environ.get('PG_LIBDIR')
PG_DLSUFFIX = os.environ.get('PG_DLSUFFIX', '.so')
PG_ABS_BUILDDIR = os.environ.get('PG_ABS_BUILDDIR')

logging.debug("PG_ABS_SRCDIR={}".format(PG_ABS_SRCDIR))
logging.debug("PG_LIBDIR={}".format(PG_LIBDIR))
logging.debug("PG_DLSUFFIX={}".format(PG_DLSUFFIX))
logging.debug("PG_ABS_BUILDDIR={}".format(PG_ABS_BUILDDIR))

EXCLUDED_TESTS = ['mysql_tests/big_packets_boundary', 'postgres_tests/generated', 'postgres_tests/collate.windows.win1252', 'postgres_tests/data', 'postgres_tests/typed_table', 'postgres_tests/with', 'postgres_tests/psql']

TEST_PATH = PG_ABS_SRCDIR
RESULT_PATH = PG_ABS_BUILDDIR 
COMPARE_TO_EXPECTED_RESULT = False
GENERATE_EXPECTED = False
PURGE_TESTS = False
FLOAT_TOLERANCE=0.001
MySQL_PW = ""

arguments = sys.argv[1:]
arg_idx = 0
result_path_set = False

while arg_idx < len(arguments):
    if arguments[arg_idx] in ("--test", "-t") and arg_idx < len(arguments)-1:
        TEST_PATH = str(arguments[arg_idx+1])
        RESULT_PATH= RESULT_PATH if result_path_set else TEST_PATH.replace("_tests/", "_results/")
        arg_idx = arg_idx+1
    elif arguments[arg_idx] in ("--result", "-r") and arg_idx < len(arguments)-1:
        RESULT_PATH = str(arguments[arg_idx+1])
        result_path_set = True
        arg_idx = arg_idx+1
    elif arguments[arg_idx] in ("--tol") and arg_idx < len(arguments)-1:
        FLOAT_TOLERANCE = float(arguments[arg_idx+1])
        arg_idx = arg_idx+1
    elif arguments[arg_idx] in ("--mysql_password", "--mysql_pw") and arg_idx < len(arguments)-1:
        MySQL_PW = str(arguments[arg_idx+1])
        arg_idx = arg_idx+1
    elif arguments[arg_idx] in ("--purge", "-p"):
        PURGE_TESTS = True
        GENERATE_EXPECTED = True
    elif arguments[arg_idx] in ("--gen_expected", "-g"):
        GENERATE_EXPECTED = True
    elif arguments[arg_idx] in ("--compare_expected", "-e"):
        COMPARE_TO_EXPECTED_RESULT = True
    arg_idx = arg_idx+1
    
TEST_PATH = TEST_PATH[:-1] if TEST_PATH[-1] == '/' else TEST_PATH
RESULT_PATH = RESULT_PATH[:-1] if RESULT_PATH[-1] == '/' else RESULT_PATH

if GENERATE_EXPECTED:
    RESULT_PATH = TEST_PATH

logging.debug(f"Test path {TEST_PATH}")
logging.debug(f"Result path {RESULT_PATH}")
logging.debug(f"Purge {PURGE_TESTS}")
logging.debug(f"Generate expected {GENERATE_EXPECTED}")
logging.debug(f"Comparte to expected result {COMPARE_TO_EXPECTED_RESULT}")

class QueryStatus(Enum):
    PASS = 1
    ERROR = -1

class CompatibilityCase(Enum):
    SAME = 1
    DIFFERENT = 0
    ERROR = -1

# represent the compatibility result of a test executed on a dbms compared to the guest dbms
# results include the 
#   - overall compatibility 
#   - for each compatibility case, the percentage of individual queries labelled as such
class TestResult(object):
    dbms = ""
    compatibility = None
    test = ""
    percentages = []

    def __init__(self, dbms, compatibility: CompatibilityCase, test_name, percentages):
        self.dbms = dbms
        self.compatibility = compatibility
        self.test = test_name
        self.percentages = percentages

    def get_summary_string(self)->str:
        return f"{self.dbms}: {self.compatibility.name} ({self.get_percentage_string()})"

    def get_percentage_string(self)->str:
        return ", ".join([f"{p:.2f}% {cc.name}" for (cc, p) in self.percentages])

    def __str__(self):
        return f"{self.test} on {self.dbms} resulted in {self.compatibility.name}"
    
    def __repr__(self) -> str:
        return self.__str__()

# standardized representation of the result of a query
class QueryResult(object):
    dbms = ""
    status = ""
    result = None 
    error = ""

    def __init__(self, dbms, status, result, error):
        self.dbms = dbms
        self.status = status
        self.result = result
        self.error = error   

    def short_str(self):
        if self.status == QueryStatus.PASS:
            return f"{self.result}"
        else:
            return f"ERROR - {self.error}"     
    
    def __str__(self):
        if self.status == QueryStatus.PASS:
            return f"{self.dbms}: {self.result}"
        else:
            return f"{self.dbms}: ERROR - {self.error}"
    

    def __repr__(self) -> str:
        return self.__str__()


class CompatibilityCaseWrapper(object):
    dbms = ""
    result = 0

    def __init__(self, dbms, result):
        self.dbms = dbms
        self.result = result

    def __str__(self):
        return f"{self.dbms}: {self.result.name}"

    def __repr__(self) -> str:
        return f"{self.dbms}: {self.result.name}"

# abstract class that wraps all functionality that is specific to a DBMS
# such as setting up the connection to the database, executing a query and filling the result into a standardized format
class SQLDialectWrapper(object):
    name = ""
    db_conn = None
    db_cursor = None
    result_file = None

    def __init__(self) -> None:
        self.setup_clean_db()
        self.setup_connection()

    def setup_clean_db(self):
        pass

    def setup_connection(self):
        pass

    def teardown_connection(self):
        pass

    def open_result_file(self, result_folder):
        pass

    def write_to_result_file(self, content):
        pass

    def close_result_file(self):
        pass

    def exec_query(self, query: str) -> QueryResult:
        pass

    def create_query_result(self, status, result, error) -> QueryResult:
        return QueryResult(self.name, status, result, error)
    
    def create_empty_query_result(self) -> QueryResult:
        return self.create_query_result(QueryStatus.PASS, [], None)
    
    def create_error_query_result(self, e) -> QueryResult:
        return self.create_query_result(QueryStatus.ERROR, None, e)


class DuckDB(SQLDialectWrapper):
    name = "duckdb"
    db_conn = None
    db_cursor = None
    result_file = None

    RESULT_FILE_NAME = "duckdb_result.txt"

    def setup_clean_db(self):
        # nothing to do here because we work with in-memory database
        pass

    def setup_connection(self):
        self.db_conn = duckdb.connect()
        # check if we can / need to change the settings (see PostgreSQL)

    def teardown_connection(self):
        pass

    def open_result_file(self, result_folder):
        self.result_file = open(os.path.join(result_folder, self.RESULT_FILE_NAME), 'w') 

    def write_to_result_file(self, content):
        self.result_file.write(content)

    def close_result_file(self):
        self.result_file.close()

    def exec_query(self, query: str) -> QueryResult:
        try:
            result = self.db_conn.sql(query)
            if result == None:
                return self.create_empty_query_result()
            result = result.fetchall()
            return self.create_query_result(QueryStatus.PASS, result, None)
        except Exception as e:
            return self.create_error_query_result(e)


class PostgreSQL(SQLDialectWrapper):
    name = "postgres"
    db_conn = None
    db_cursor = None
    result_file = None

    result_file_name = "postgres_result.txt"

    database_name = "regression"
    database_user = "postgres"
    host = "localhost"
    port = 5432

    def __init__(self, database_name, dbms, result_file_name):
        self.database_name = database_name if database_name != None else self.database_name
        self.name = dbms if dbms != None else self.name
        self.result_file_name = result_file_name if result_file_name != None else self.result_file_name
        self.setup_clean_db()
        self.setup_connection()

    def setup_clean_db(self):
        logging.debug("POSTGRESQL: Setup clean database {} with user {} at {}:{}".format(self.database_name, self.database_user, self.host, self.port))
        tmp_db_conn = psycopg2.connect(user=self.database_user, password="*****", host=self.host, port=self.port)
        tmp_db_conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        tmp_db_cursor = tmp_db_conn.cursor()
        drop_stmt = f"DROP DATABASE IF EXISTS {self.database_name}"
        create_stmt = """CREATE DATABASE {} WITH 
        OWNER = {} 
        ENCODING = 'UTF8' 
        TABLESPACE = pg_default 
        LC_COLLATE = 'C' 
        LC_CTYPE = 'en_US.UTF-8' 
        TEMPLATE = template0 """.format(self.database_name, self.database_user)
        logging.debug(drop_stmt)
        tmp_db_cursor.execute(drop_stmt)
        tmp_db_conn.commit()
        logging.debug(create_stmt)
        tmp_db_cursor.execute(create_stmt)
        tmp_db_conn.commit()
        tmp_db_cursor.close()
        tmp_db_conn.close()

    def setup_connection(self):
        logging.info("POSTGRESQL: Connecting to database {} at {}:{}".format(self.database_name, self.host, self.port))
        self.db_conn = psycopg2.connect(user=self.database_user, password="*****", host=self.host, port=self.port, database=self.database_name)
        self.db_conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        self.db_cursor = self.db_conn.cursor()

    def teardown_connection(self):
        logging.info("POSTGRESQL: Close connection to database")
        self.db_cursor.close()
        self.db_conn.close()

    def open_result_file(self, result_folder):
        self.result_file = open(os.path.join(result_folder, self.result_file_name), 'w') 

    def write_to_result_file(self, content):
        self.result_file.write(content)

    def close_result_file(self):
        self.result_file.close()

    def exec_query(self, query: str) -> QueryResult:
        try:
            if re.search(r"copy\s+[^\s]*\s+from\s+", query, re.IGNORECASE) != None:
                self.db_cursor.copy_from(query)
            self.db_cursor.execute(query)
            result = self.db_cursor.fetchall()
            return self.create_query_result(QueryStatus.PASS, result, None)
        except psycopg2.ProgrammingError as e:
            if str(e) == "no results to fetch": 
                return self.create_empty_query_result()
            else:
                return self.create_error_query_result(e)    
        except psycopg2.Error as e:
            return self.create_error_query_result(e)
        except Exception as e:
            return self.create_error_query_result(e)
        

class MySQL(SQLDialectWrapper):
    name = "mysql"
    db_conn = None
    db_cursor = None
    result_file = None

    RESULT_FILE_NAME = "mysql_result.txt"
    
    DATABASE_NAME = "test"
    DATABASE_USER = "root"
    HOST = "localhost"
    PORT = 3306
    CREATE_DB_STMT = f"CREATE DATABASE {DATABASE_NAME};"
    DROP_DB_STMT = "DROP DATABASE {};"

    def setup_clean_db(self):
        logging.debug("MYSQL: Setup clean database {} with user {} at {}:{}".format(self.DATABASE_NAME, self.DATABASE_USER, self.HOST, self.PORT))
        con = pymysql.connect(user=self.DATABASE_USER, password=MySQL_PW, host=self.HOST, port=self.PORT, client_flag=pymysql.constants.CLIENT.MULTI_STATEMENTS)
        # con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        self.db_conn = con
        cur = con.cursor()
        self.db_cursor = cur
        cur.execute("SHOW DATABASES;")
        db_names = [db[0] for db in cur.fetchall() if db[0] not in ['sys', 'mysql', 'information_schema', 'performance_schema']];
        for db in db_names:
            logging.debug(self.DROP_DB_STMT.format(db))
            cur.execute(self.DROP_DB_STMT.format(db))
        logging.debug(self.CREATE_DB_STMT)
        cur.execute(self.CREATE_DB_STMT)
        cur.close()
        con.close()

    def setup_connection(self):
        logging.info("MYSQL: Connecting to database {} at {}:{}".format(self.DATABASE_NAME, self.HOST, self.PORT))
        con = pymysql.connect(user=self.DATABASE_USER, password=MySQL_PW, host=self.HOST, port=self.PORT, database=self.DATABASE_NAME)
        #con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        self.db_conn = con
        cur = con.cursor()
        self.db_cursor = cur
        cur.execute(f"use {self.DATABASE_NAME};")
        return con

    def teardown_connection(self):
        logging.info("MYSQL: Close connection to database")
        self.db_cursor.close()
        self.db_conn.close()

    def open_result_file(self, result_folder):
        self.result_file = open(os.path.join(result_folder, self.RESULT_FILE_NAME), 'w') 

    def write_to_result_file(self, content):
        self.result_file.write(content)

    def close_result_file(self):
        self.result_file.close()

    def exec_query(self, query: str) -> QueryResult:
        try:
            self.db_cursor.execute(query)
            result = self.db_cursor.fetchall()
            return self.create_query_result(QueryStatus.PASS, result, None)
        except pymysql.ProgrammingError as e:
            if str(e) != "no results to fetch": 
                return self.create_error_query_result(e)
                #if "You have an error in your SQL syntax" in str(e):
                #    print(e)
                #    print(command)
                #    print(file)
                #    exit()
            else: 
                return self.create_empty_query_result()
        except pymysql.Error as e:
            return self.create_error_query_result(e)      


def init_dialects(guest_dbms: str) -> list[SQLDialectWrapper]:
    if GENERATE_EXPECTED:
        all_dbms = [PostgreSQL('regression', None, 'expected.txt'), DuckDB(), MySQL()]
        return [d for d in all_dbms if d.name == guest_dbms]
    return [PostgreSQL('regression', None, None), DuckDB(), MySQL()] 

# determines and returns the guest dbms based on the file path
def get_guest_dbms(file_path: str) -> str:
    return file_path.split("/")[-3].replace("_tests", "")


def is_guest_dbms(dbms: SQLDialectWrapper, guest_dbms: str) -> bool:
    return dbms.name == guest_dbms


def compare_elements(elem1, elem2, tolerance=FLOAT_TOLERANCE) -> bool:
    if isinstance(elem1, (int, float)) and isinstance(elem2, (int, float)):
        if math.isnan(elem1) and math.isnan(elem2):
            return True
        return math.isclose(elem1, elem2, abs_tol=tolerance)
    elif isinstance(elem1, (list, tuple)) and isinstance(elem2, (list, tuple)):
        if len(elem1) != len(elem2):
            return False
        return all(compare_elements(a, b, tolerance) for a, b in zip(elem1, elem2))
    elif isinstance(elem1, dict) and isinstance(elem2, dict):
        if elem1.keys() != elem2.keys():
            return False
        return all(compare_elements(elem1[key], elem2[key], tolerance) for key in elem1)
    else:
        return elem1 == elem2

# compares two query results
# returns True iff the results are identical
def is_result_identical(guest_result, host_result, is_ordered: bool)-> bool:
    logging.debug("is_result_identical")
    if guest_result == None or host_result == None:
        return guest_result == None and host_result == None
    elif len(guest_result) == 0 or len(host_result) == 0:
        return len(guest_result) == 0 and len(host_result) == 0
    elif is_ordered:
        return compare_elements(guest_result, host_result)
    else:
        logging.debug(guest_result)
        if isinstance(guest_result[0], dict):
            logging.debug("comparing dictionaries")
            self_list = [[(key, value) for key, value in row.items()]for row in guest_result]
            other_list = [[(key, value) for key, value in row.items()]for row in host_result]
        else:
            self_list = guest_result
            other_list = host_result
        return compare_elements(sorted(self_list, key=lambda x: [(val is None, val) for val in x]), sorted(other_list, key=lambda x: [(val is None, val) for val in x]))

# returns True iff the query contains an order by clause
def is_ordered(query: str)-> bool:
    pattern = re.compile(r'[\s\(;\[\)\]]{}[\s\(;\[\)\]]'.format(re.escape("order by"), re.IGNORECASE))
    return re.search(pattern, query) is not None

# compares two query results and returns the compatibility case
def compare_single_result(guest_result: QueryResult, host_result: QueryResult, is_ordered=False) -> CompatibilityCase:
    try:
        if guest_result.status !=  host_result.status:
            return CompatibilityCase.ERROR
        elif guest_result.status == CompatibilityCase.ERROR:
            return CompatibilityCase.SAME
        elif is_result_identical(guest_result.result, host_result.result, is_ordered):
            return CompatibilityCase.SAME
        else:
            return CompatibilityCase.DIFFERENT
    except Exception as e:
        logging.error(f"Could not compare results. {e}")
        return CompatibilityCase.ERROR

# compares results of a single query executed on many DBMSs to the guest DBMS result
# returns a list of compatibility cases
def compare_results(results: list[QueryResult], guest_dbms: str, is_ordered: bool) -> list[CompatibilityCaseWrapper]:
    guest_results = [r for r in results if r.dbms == guest_dbms]
    hosts_results = [r for r in results if r.dbms != guest_dbms]

    if len(guest_results) != 1:
        logging.error("Could not identify guest dbms result")
        raise Exception("Could not identify guest dbms result")
    
    guest_result = guest_results[0]

    comp_cases = []

    for h in hosts_results:
        cc = compare_single_result(guest_result, h, is_ordered)
        comp_cases.append(CompatibilityCaseWrapper(h.dbms, cc))
    return comp_cases

# compares the guest result file to the expected.txt (both files need to exist already!)
# returns True iff the files are identical
def compare_to_expected_result(guest_result_file_name: str, expected_result_file_name: str, summary_file) -> bool:
    try:
        guest_result_file = open(guest_result_file_name, 'r')
        expected_result_file_name = expected_result_file_name.replace('test.sql', 'expected.txt')
        expected_result_file = open(expected_result_file_name, 'r')
        logging.debug(f"Comparing {guest_result_file_name} to {expected_result_file_name}")
        guest_results = guest_result_file.readlines() 
        expected_results = expected_result_file.readlines()
        guest_result_file.close()
        expected_result_file.close()

        if len(guest_results) != len(expected_results):
            logging.error(f"Different to expected results: {guest_result_file_name}")
            write_to_summary_file(summary_file, "Different to expected results")
            return False

        for i in range(len(guest_results)):
            if guest_results[i] != expected_results[i]:
                logging.error(f"Guest results are different to expected results at line {i}")
                write_to_summary_file(summary_file, "Guest results are different to expected results")
                return False
        logging.info("Guest results are identical to expected results")
        write_to_summary_file(summary_file, "Guest results are identical to expected results")
        return True
    except Exception as e:
        logging.error(f"Failed to compare to expected file. {e}")
        write_to_summary_file(summary_file, f"Failed to compare to expected file. {e}")
        return False
        

# returns the next query
def get_query_string(query_iter) -> str:
    query = next(query_iter)
    dollar_count = query.count('$$')
    double_quotes_count = query.count('"') - query.count("\"")
    single_quotes_count = query.count("'") - query.count("\'")

    while dollar_count % 2 != 0 or  double_quotes_count % 2 != 0 or single_quotes_count % 2 != 0:
        try:
            query = query + ";" + next(query_iter)
            dollar_count = query.count('$$')
            double_quotes_count = query.count('"') - query.count("\"")
            single_quotes_count = query.count("'") - query.count("\'")
        except StopIteration as e:
            logging.error(f"Index out of bounds. Query: {query}")
            raise e

    try:
        peek = next(query_iter)
        query_iter = itertools.chain([peek], query_iter)
        return f"{query};", query_iter
    except StopIteration:
        return f"{query}", query_iter # no semicolon here

# transforms a query string read from setup.sql or test.sql to an executable query by
# replacing some variables by the correct values (e.g. paths that we do not want to hard-code)
def transform_to_executable_query(query: str) -> str:
    if 'PG_ABS_SRCDIR' in query or 'PG_LIBDIR' in query or 'PG_DLSUFFIX' in query or 'PG_ABS_BUILDDIR' in query:
                vars = ['PG_ABS_SRCDIR', 'PG_LIBDIR', 'PG_DLSUFFIX', 'PG_ABS_BUILDDIR']
                for v in vars:
                    query = re.sub(r'\'\s+{}'.format(re.escape(v)), f'\' || {v}', query)
                    query = re.sub(r'{}\s+\''.format(re.escape(v)), f'{v} || \'', query)
                query = query.replace('PG_ABS_SRCDIR', " '" + PG_ABS_SRCDIR + "'")
                query = query.replace('PG_LIBDIR', " '" + PG_LIBDIR + "'")
                query = query.replace('PG_DLSUFFIX', " '" + PG_DLSUFFIX + "'")
                query = query.replace('PG_ABS_BUILDDIR', " '" + PG_ABS_BUILDDIR + "'")
                query = re.sub(r'\'\s+{}\s+\''.format(re.escape('||')), '', query)
    return query


def execute_setup_sql(sql_dialects: list[SQLDialectWrapper], sql_file: str, result_folder: str, writeToFile=True):
    logging.debug(f"Executing setup {sql_file}")
    if writeToFile:
        # We write the results to a file such that results can be compare without needing to rerun the tests all the time
        for dialect in sql_dialects:
            dialect.open_result_file(result_folder)

    test_file_stream = open(sql_file, 'r')
    test_file = test_file_stream.read()
    test_file_stream.close()

    guest_dbms = get_guest_dbms(sql_file)

    logging.debug(f"Guest DBMS identified: {guest_dbms}")

    sql_queries = test_file.split(';') # here we get the individual sql queries!
    query_iter = iter(sql_queries)
    
    while True:
        try:
            query, query_iter = get_query_string(query_iter)
            query = query.strip()

            if writeToFile:
                for dialect in sql_dialects:
                    dialect.write_to_result_file(query)
            if query != '':
                logging.debug(f"\nExecuting query:  {query}")
                curr_results = []
                for dialect in sql_dialects:
                    result = dialect.exec_query(transform_to_executable_query(query))
                    curr_results.append(result)
                    logging.debug(f"RESULT: {result}")

                compare_results(curr_results, guest_dbms, is_ordered(query))

        except StopIteration:
            break

    if writeToFile:
        for dialect in sql_dialects:
            dialect.close_result_file()

def execute_test_sql(sql_dialects: list[SQLDialectWrapper], sql_file: str, result_folder: str, compute_summary_enabled=True) -> list[TestResult]:
    logging.debug(f"Executing setup {sql_file}")
    # We write the results to a file such that results can be compare without needing to rerun the tests all the time
    for dialect in sql_dialects:
        dialect.open_result_file(result_folder)

    summary_file = open(os.path.join(result_folder, "summary.txt"), 'w') if not GENERATE_EXPECTED else None

    test_file_stream = open(sql_file, 'r')
    test_file = test_file_stream.read()
    test_file_stream.close()

    guest_dbms = get_guest_dbms(sql_file)

    logging.info(f"Guest DBMS identified: {guest_dbms}")
    write_to_summary_file(summary_file, f"Guest DBMS identified: {guest_dbms}")

    sql_queries = test_file.split(';') # here we get the individual sql queries!
    query_iter = iter(sql_queries)

    all_results = []
    
    while True:
        try:
            query, query_iter = get_query_string(query_iter)
            if query.strip() != '':
                query_string = f"\n-----------\nQUERY:\n{query}\n"
                logging.info(query_string)
                write_to_summary_file(summary_file, query_string)
                curr_results = []
                for dialect in sql_dialects:
                    dialect.write_to_result_file(query_string)
                    result = dialect.exec_query(transform_to_executable_query(query))
                    logging.debug(f"RESULT:\n\t{result}\n")
                    dialect.write_to_result_file(f"RESULT:\n\t{result.short_str()}\n")
                    curr_results.append(result)
                # print(f"curr result: {pprint.pformat(curr_results)}")
                comp_cases = compare_results(curr_results, guest_dbms, is_ordered(query))
                all_results.append(comp_cases)
                logging.info("COMPATIBILITY: {}\n".format(comp_cases))
                write_to_summary_file(summary_file, "RESULT: {}\n".format(comp_cases))
        except StopIteration:
            break

    for dialect in sql_dialects:
        dialect.close_result_file()

    sql_file_parts = sql_file.split("/")

    overall_compatibility = []
    if compute_summary_enabled:
        overall_compatibility = compute_summary(all_results, sql_dialects, summary_file, "/".join(sql_file_parts[-2:]), guest_dbms)
    if COMPARE_TO_EXPECTED_RESULT:
        guest_result_file = [d.result_file_name for d in sql_dialects if d.name == guest_dbms][0]
        compare_to_expected_result(os.path.join(result_folder, guest_result_file), sql_file, summary_file)

    if not summary_file is None:
        summary_file.close() 
    return overall_compatibility
 
# executes a single tests by setting up the databases, calling the execute setup and test methods and cleanin up afterwards
def execute_single_test(test_folder: str, result_folder: str):
    if not os.path.exists(result_folder):
        os.makedirs(result_folder)

    print("==============================================\n")
    print(f"execute single test {test_folder} and storing results in {result_folder}\n")
    # we always want to drop and recreate the database because some tests might modify the data

    dialects = init_dialects(get_guest_dbms(test_folder + "/test.sql"))
    logging.debug(f"Dialects: {dialects}\n")

    execute_setup_sql(dialects, test_folder + "/setup.sql", result_folder, False) 

    test_result = execute_test_sql(dialects, test_folder + "/test.sql", result_folder)

    for dialect in dialects:
        dialect.teardown_connection()

    return test_result

# computes the summary of a single test
# The summary contains the percentage of each compatibility case of each host DBMS
# The summary is written to stdout and the test's summary file
# returns a list of TestResults that contains, for each host DBMS, the overall test compatibility and the percentages
def compute_summary(all_results: list[list[CompatibilityCaseWrapper]], dialects: list[SQLDialectWrapper], summary_file, test_name: str, guest_dbms: str) -> list[TestResult]:
    logging.debug("Computing summary...")
    logging.debug("all_results {}".format([str(cc) for row in all_results for cc in row]))

    overall_compatibility = []

    write_to_summary_file(summary_file, "\n\n=========================================\n")
    write_to_summary_file(summary_file, "Summary for test case {} of {}\n".format(test_name, guest_dbms))
    write_to_summary_file(summary_file, "=========================================\n")  

    print("\n=========================================")
    print("Summary for test case {} of {}".format(test_name, guest_dbms))
    print("=========================================")  

    for d in dialects:
        d_results = [cc for row in all_results for cc in row if cc.dbms == d.name]
        logging.debug("dialect {}, d_results: {}".format(d.name, [str(r_) for r_ in d_results]))
        num_results = len(d_results)
        
        if num_results == 0:
            continue
        
        print("\n=================\nResults for {}\n".format(d.name))
        write_to_summary_file(summary_file, "\n=================\nResults for {}\n".format(d.name))
        curr_comp_case = CompatibilityCase.SAME
        percentages = []
        for cc in [CompatibilityCase.SAME, CompatibilityCase.DIFFERENT, CompatibilityCase.ERROR]:
            num = len([r for r in d_results if r.result == cc])
            if num > 0:
                curr_comp_case = cc
            percentage = num/num_results * 100
            percentages.append((cc, percentage))
            print("{}: {} queries, which is {:.2f}%\n".format(cc.name, num, percentage))
            write_to_summary_file(summary_file, "{}: {} queries, which is {:.2f}%\n".format(cc.name, num, percentage))
    
        overall_compatibility.append(TestResult(d.name, curr_comp_case, test_name, percentages))
    return overall_compatibility

# functions related to purging
def is_readonly_query(query: str) -> bool:
    for line in query.splitlines():
        line = line.strip()
        if line == '' or line.startswith('--'):
            continue
        line = line.lower()
        if (line.startswith("select") or line.startswith("explain")) and not "pg_catalog.set_config" in line:
            return True
        else:
            return False

# determines and returns tables, functions, types,... that are created in setup.sql but do not appear in test.sql
def extract_unused_names(setup_file: str, test_file: str) -> list[str]:
    setup_file_stream = open(setup_file, 'r')
    setup_string = setup_file_stream.read()
    setup_file_stream.close()

    # extract all tables, functions, ... that are created by the setup file
    create_names = re.findall(re.compile(r'CREATE\s+(?:TABLE|ROLE|FUNCTION|TYPE)\s+([^\s;\(]+)', re.IGNORECASE), setup_string)

    test_file_stream = open(test_file, 'r')
    test_string = test_file_stream.read()
    test_file_stream.close()

    unused_names = []

    for name in create_names:
        # check whether table, function, ... appears in test file
        pattern = re.compile(r'[\s\(;\[\)\]]{}[\s\(;\[\)\]]'.format(re.escape(name), re.IGNORECASE))
        if not re.search(pattern, test_string):
            unused_names.append(name)
    return list(set(unused_names))


def is_create_unused_name(query: str, unused_names: list[str]) -> bool:
    for name in unused_names:
        pattern = re.compile(r'CREATE\s+(?:TABLE|ROLE|FUNCTION|TYPE)\s+{}[\s\(;\[]'.format(re.escape(name)), re.IGNORECASE)
        test = re.search(pattern, query)
        if test:
            return True
    return False


# Purges the setup.sql by 
#   - removing read-only queries
#   - removing all create table/function/... statements of names_to_remove
#   - removing all errornous statements
# returns True iff the setup.sql has changed.
def purge_setup_sql(dialect: SQLDialectWrapper, setup_file: str, setup_tmp_file: str, names_to_remove: list[str]) -> bool:
    logging.debug(f"Purge setup {setup_file}")

    test_file_stream = open(setup_file, 'r')
    test_file = test_file_stream.read()
    test_file_stream.close()

    sql_queries = test_file.split(';') # here we get the individual sql queries!
    query_iter = iter(sql_queries)
    test_file_stream = open(setup_tmp_file, 'w')

    has_changed = False

    while True:
        try:
            query, query_iter = get_query_string(query_iter)

            if is_readonly_query(query):
                logging.debug(f"Ignoring query {query} (readonly)")
                has_changed = True
                continue
            
            if is_create_unused_name(query, names_to_remove):
                logging.debug(f"Ignoring query {query} (create unused table)")
                has_changed = True
                continue

            if query.strip() != '':
                result = dialect.exec_query(transform_to_executable_query(query))
                logging.debug(f"Query: {query}\n Result: {result}")
                if result.status != QueryStatus.ERROR:
                    test_file_stream.write(query)
                else:
                    has_changed = True
                    logging.info(f"Ignoring query {query} (ERROR)")

        except StopIteration:
            break

    test_file_stream.write("\n")
    test_file_stream.close()
    return has_changed


# purges the test.sql by removing all non-deterministic queries
# returns True iff the test.sql has changed.
def purge_test_sql(dialect: SQLDialectWrapper, sql_file: str, expected_file: str) -> bool:
    logging.warning(f"Purge test {sql_file}")
    
    test_file_stream = open(sql_file, 'r')
    test_data = test_file_stream.read()
    test_file_stream.close()

    expected_file_stream = open(expected_file, 'r')
    expected_data = expected_file_stream.readlines()
    expected_file_stream.close()

    sql_queries = test_data.split(';') # here we get the individual sql queries!
    query_iter = iter(sql_queries)

    test_file_stream = open(sql_file, 'w')
    expected_file_stream = open(expected_file, 'w')
    e_line_idx = 0

    has_changed = False

    while True:
        try:
            query, query_iter = get_query_string(query_iter)

            if query.strip() != '':
                query_string = f"\n-----------\nQUERY:\n{query}"
                logging.debug(query_string)
                for line in query_string.splitlines():
                    while expected_data[e_line_idx] != line + "\n":
                        logging.debug(f"Skipping line {expected_data[e_line_idx]}")
                        e_line_idx = e_line_idx + 1
                    e_line_idx = e_line_idx + 1

                result = dialect.exec_query(transform_to_executable_query(query))

                result_string = f"RESULT:\n\t{result.short_str()}\n"

                is_result_different = False
                for line in result_string.splitlines():
                    e_line = expected_data[e_line_idx]
                    e_line_idx = e_line_idx + 1
                    if e_line != line + "\n":
                        is_result_different = True
                        logging.warning(f"Lines {line} different from expected {e_line}. Skipping query {query_string}")
                        break
                if not is_result_different:
                    expected_file_stream.write(query_string + "\n")
                    expected_file_stream.write(result_string)
                    test_file_stream.write(query)
                else:
                    logging.warning(f"Ignoring query {query_string} due to non-deterministic result")
                    has_changed = True

        except StopIteration:
            break

    test_file_stream.write("\n")

    test_file_stream.close()
    expected_file_stream.close()
    return has_changed
 

# Purges test.sql and
# minimizes the setup.sql by 
#   - removing read-only queries
#   - removing all create table/function/... statements of unused names
#   - removing all errornous statements
#   This is done step-by-step and changes are only applied when the test.sql returns the expected results.
def purge_single_test(test_folder: str):
    print("==============================================\n")
    print(f"purge single test {test_folder}\n")
    setup_file = test_folder + "/setup.sql"
    test_file = test_folder + "/test.sql"
    setup_tmp_file = test_folder + "/setup_tmp.sql"

    guest_dbms = get_guest_dbms(test_folder + "/test.sql")

    has_changed = True

    # remove non-deterministic queries from test file
    while has_changed:
        logging.info("Purging test file")
        dialects = init_dialects(guest_dbms)
        dialects1 = [d for d in dialects if d.name == guest_dbms]
        dialect = dialects1[0]
        logging.debug(f"Dialect: {dialect}\n")

        execute_setup_sql(dialects1, setup_file, test_file, False) 

        has_changed = purge_test_sql(dialect, test_file, test_folder + "/expected.txt")

        for dialect in dialects:
            dialect.teardown_connection()

    has_changed = False
    unused_names = extract_unused_names(setup_file, test_file)
    unused_names_idx = 0
    names_to_remove = []
    remove_all = True
    print(f"unused names: {unused_names}")

    # in the first pass we remove readonly and errenous queries
    # in the second pass we try to remove all unused names + all errenous queries
    # if this fails, in the subsequent passes we try to remove unused names one by one and only apply changes if test succeeds
    while True:
        logging.info("Purging setup file")
        logging.info(f"Removing tables: {names_to_remove}")
        dialects = init_dialects(guest_dbms)
        dialects1 = [d for d in dialects if d.name == guest_dbms]
        dialect = dialects1[0]
        dialect.result_file_name = "tmp_result.txt"
        logging.debug(f"Dialect: {dialect}\n")

        has_changed = purge_setup_sql(dialect, setup_file, setup_tmp_file, names_to_remove) 

        execute_test_sql(dialects1, test_file, test_folder, compute_summary_enabled=False)

        check_expected = compare_to_expected_result(os.path.join(test_folder, dialect.result_file_name), test_folder + "/expected.txt", None)

        if has_changed and check_expected: # identical to expected result file
            logging.debug("Result was identical to expected. Apply changes.")
            if os.path.exists(setup_file):
                os.remove(setup_file)
            os.rename(setup_tmp_file, setup_file) # save new setup file
            has_changed = True
        elif not check_expected:
            logging.warning(f"Result was different from expected after removing tables {names_to_remove}. Revert changes.")
            has_changed = False
            # revert changes
            if os.path.exists(setup_tmp_file):
                os.remove(setup_tmp_file)

            if len(names_to_remove) == 0:
                break # base case failed, stop
            elif remove_all: # removing all unused names failed. So, we proceed one by one
                logging.warning("Removing all names failed. Proceed one by one.")
                names_to_remove = []
                unused_names_idx = 0
                remove_all = False
            else:
                names_to_remove.pop(-1) # removing last name failed, so we do not remove it from now on and continue
        else:
            logging.debug("Nothing changed")
            # revert changes
            if os.path.exists(setup_tmp_file):
                os.remove(setup_tmp_file)
            has_changed = False

        for dialect in dialects:
            if os.path.exists(os.path.join(test_folder, dialect.result_file_name)):
                os.remove(os.path.join(test_folder, dialect.result_file_name))
            dialect.teardown_connection()

        if len(names_to_remove) == 0 and remove_all: # first try to remove all unused names, if it fails then remove one by one
            if len(unused_names) == 0:
                break
            logging.info(f"Try to remove all unused names in {setup_file}")
            names_to_remove = [n for n in unused_names]
            unused_names_idx = len(unused_names)
        elif unused_names_idx < len(unused_names):
            names_to_remove.append(unused_names[unused_names_idx]) # add next name to removed names
            unused_names_idx = unused_names_idx + 1
        elif unused_names_idx >= len(unused_names) and not has_changed: # all names have been removed and nothing changes anymore. Done
            break

    print("Removed names (not required by test): ", names_to_remove)


def write_to_summary_file(summary_file, text: str):
    if not GENERATE_EXPECTED and not summary_file is None:
        summary_file.write(text)

# computes the overall summary (e.g. percentage for each compatibility case for each DBMS)
# summary as printed to std and writen to the overall_summary.txt
def compute_overall_summary(all_results: list[list[TestResult]], result_folder: str):
    summary_file = open(os.path.join(result_folder, "summary_overall.txt"),  'w')
    if len(all_results) == 0:
        logging.error("No results found")
        return
    logging.debug("Computing overall summary...")
    logging.debug("all_results {}".format([str(cc) for row in all_results for cc in row]))
    logging.debug(f"all_results[0] {str(all_results[0])}")

    dialects = [r.dbms for r in all_results[0]]
    
    for row in all_results:
        summary_file.write(f"\n=====\n{row[0].test}\n")
        for tr in row:
            summary_file.write(tr.get_summary_string()+"\n")

    for d in dialects:
        d_results = [cc for row in all_results for cc in row if cc.dbms == d]
        logging.debug("dialect {}, d_results: {}".format(d, [str(res) for res in d_results]))
        num_results = len(d_results)
        
        print(f"\n\n========================\nOverall results for {d}\n")
        summary_file.write(f"\n\n\n=======================\nOverall results for {d}\n")
        for cc in [CompatibilityCase.SAME, CompatibilityCase.DIFFERENT, CompatibilityCase.ERROR]:
            num = len([r for r in d_results if r.compatibility == cc])
            
            percentage = num/num_results * 100
            print("{}: {} test cases, which is {:.2f}%\n".format(cc.name, num, percentage))
            summary_file.write("{}: {} test cases, which is {:.2f}%\n".format(cc.name, num, percentage))
    
    summary_file.close()

# iterates through the test folder and executes/purges all tests
def execute_tests_in_folder_rec(test_folder: str, result_folder: str)-> list[list[TestResult]]:
    logging.info(f"Execute ALL tests in {test_folder} (and all subfolders) and storing results in {result_folder}")
    all_results = []
    items = os.listdir(test_folder)
    items.sort()
    for fname in items:

        single_test_path = os.path.join(test_folder, fname)
        logging.debug(f"single test path = {single_test_path}")
        test = any([substring in single_test_path and fname in single_test_path.split("/") for substring in EXCLUDED_TESTS])

        logging.debug(f"any {test}")
        
        if os.path.isdir(single_test_path) and not any([substring in single_test_path and fname in single_test_path.split("/") for substring in EXCLUDED_TESTS]):
            # when we found a folder, we recurse into it
            logging.debug(f"Found folder {fname}")
            rec_results = execute_tests_in_folder_rec(single_test_path, os.path.join(result_folder, fname))
            all_results = all_results + rec_results
        
        if os.path.isfile(single_test_path) and fname == "test.sql": # once we found a test.sql file, we can execute the test
            logging.debug(f"Found file {single_test_path}")
            test_result = execute_single_test(test_folder, result_folder)
            all_results.append(test_result)
            if PURGE_TESTS:
                print("purge tests: ", test_folder)
                purge_single_test(test_folder)
            return all_results # we assume there are no subfolders with tests
    return all_results


all_results = execute_tests_in_folder_rec(TEST_PATH, RESULT_PATH)
compute_overall_summary(all_results, RESULT_PATH)