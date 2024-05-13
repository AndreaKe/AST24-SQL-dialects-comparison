import os
import sys, logging
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import duckdb
# import pymysql
from enum import Enum
import itertools
import re

logging.basicConfig(stream=sys.stderr, level=logging.WARNING) # change level to INFO or DEBUG to see more output



PG_ABS_SRCDIR = os.environ.get('PG_ABS_SRCDIR')
PG_LIBDIR = "'" + os.environ.get('PG_LIBDIR') + "'"
PG_DLSUFFIX = "'" + os.environ.get('PG_DLSUFFIX', '.so') + "'"
PG_ABS_BUILDDIR = os.environ.get('PG_ABS_BUILDDIR')

logging.debug("PG_ABS_SRCDIR={}".format(PG_ABS_SRCDIR))
logging.debug("PG_LIBDIR={}".format(PG_LIBDIR))
logging.debug("PG_DLSUFFIX={}".format(PG_DLSUFFIX))
logging.debug("PG_ABS_BUILDDIR={}".format(PG_ABS_BUILDDIR))

EXCLUDED_TESTS = ['generated', 'collate.windows.win1252', 'data', 'typed_table', 'with']

TEST_PATH = PG_ABS_SRCDIR
RESULT_PATH = PG_ABS_BUILDDIR 
COMPARE_TO_EXPECTED_RESULT = False
GENERATE_EXPECTED = False
PURGE_TESTS = False

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


class TestResult(object):
    dbms = ""
    compatibility = None
    test = ""

    def __init__(self, dbms, compatibility, test_name):
        self.dbms = dbms
        self.compatibility = compatibility
        self.test = test_name


    def __str__(self):
        return f"{self.test} on {self.dbms} resulted in {self.compatibility.name}"


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

    def is_result_identical(self, other):
        # TODO: ignore minor accuracy difference, check ordering for order by queries, handle dict comparison correctly
        logging.debug("is_result_identical")
        if self.result == None or other.result == None:
            return self.result == None and other.result == None
        if len(self.result) > 0:
            logging.debug(self.result)
            if isinstance(self.result[0], dict): # TODO: does not work yet
                logging.debug("comparing dictionaries")
                self_list = [[(key, value) for key, value in row.items()]for row in self.result]
                other_list = [[(key, value) for key, value in row.items()]for row in other.result]
            else:
                self_list = self.result
                other_list = other.result
            return sorted(self_list, key=lambda x: [(val is None, val) for val in x]) == sorted(other_list, key=lambda x: [(val is None, val) for val in x])
        else:
            return len(other.result) == 0
    
    def __str__(self):
        if self.status == QueryStatus.PASS:
            return f"{self.dbms}: {self.result}"
        else:
            return f"{self.dbms}: ERROR - {self.error}"


class CompatibilityCaseWrapper(object):
    dbms = ""
    result = 0

    def __init__(self, dbms, result):
        self.dbms = dbms
        self.result = result

    def __str__(self):
        return f"{self.dbms}: {self.result.name}"


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

    def exec_query(self, query):
        pass

    def create_query_result(self, status, result, error):
        return QueryResult(self.name, status, result, error)
    
    def create_empty_query_result(self):
        return self.create_query_result(QueryStatus.PASS, None, None)
    
    def create_error_query_result(self, e):
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

    def exec_query(self, query):
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

    def exec_query(self, query):
        try:
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
    name = "mySQL"
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
        con = pymysql.connect(user=self.DATABASE_USER, password="", host=self.HOST, port=self.PORT, client_flag=pymysql.constants.CLIENT.MULTI_STATEMENTS)
        # con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cur = con.cursor()
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
        con = pymysql.connect(user=self.DATABASE_USER, password="", host=self.HOST, port=self.PORT, database=self.DATABASE_NAME)
        #con.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cur = con.cursor()
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

    def exec_query(self, query):
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

def get_guest_dbms(file_path):
    return file_path.split("/")[-3].replace("_tests", "")

def is_guest_dbms(dbms: SQLDialectWrapper, guest_dbms):
    return dbms.name == guest_dbms


def compare_single_result(guest_result: QueryResult, host_result: QueryResult):
    try:
        if guest_result.status !=  host_result.status:
            return CompatibilityCase.ERROR
        elif guest_result.status == CompatibilityCase.ERROR:
            return CompatibilityCase.SAME
        elif guest_result.is_result_identical(host_result): # TODO: what if the order matters?
            return CompatibilityCase.SAME
        else:
            return CompatibilityCase.DIFFERENT
    except Exception as e:
        logging.error(f"Could not compare results. {e}")
        return CompatibilityCase.ERROR


def compare_results(results, guest_dbms):
    guest_results = [r for r in results if r.dbms == guest_dbms]
    hosts_results = [r for r in results if r.dbms != guest_dbms]

    if len(guest_results) != 1:
        logging.error("Could not identify guest dbms result")
        raise Exception("Could not identify guest dbms result")
    
    guest_result = guest_results[0]

    comp_cases = []

    for h in hosts_results:
        cc = compare_single_result(guest_result, h)
        comp_cases.append(CompatibilityCaseWrapper(h.dbms, cc))
    return comp_cases


def compute_summary(all_results, dialects, summary_file, test_name, guest_dbms):
    logging.debug("Computing summary...")
    logging.debug("all_results {}".format([str(cc) for row in all_results for cc in row]))

    overall_compatibility = []

    write_to_summary_file(summary_file, "=========================================\n")
    write_to_summary_file(summary_file, "Summary for test case {} of {}\n".format(test_name, guest_dbms))
    write_to_summary_file(summary_file, "=========================================\n")  

    print("=========================================")
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
        for cc in [CompatibilityCase.SAME, CompatibilityCase.DIFFERENT, CompatibilityCase.ERROR]:
            num = len([r for r in d_results if r.result == cc])
            if num > 0:
                curr_comp_case = cc
            percentage = num/num_results * 100
            print("{}: {} queries, which is {:.2f}%\n".format(cc.name, num, percentage))
            write_to_summary_file(summary_file, "{}: {} queries, which is {:.2f}%\n".format(cc.name, num, percentage))
    
        overall_compatibility.append(TestResult(d.name, curr_comp_case, test_name))
    return overall_compatibility


def execute_setup_sql(sql_dialects, sql_file, result_folder, writeToFile=True):
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
                    result = dialect.exec_query(query)
                    curr_results.append(result)
                    logging.debug(f"RESULT: {result}")

                compare_results(curr_results, guest_dbms)

        except StopIteration:
            break

    if writeToFile:
        for dialect in sql_dialects:
            dialect.close_result_file()


def execute_test_sql(sql_dialects, sql_file, result_folder, printErrors=True):
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
                    result = dialect.exec_query(query)
                    result_string = f"RESULT:\n\t{result}\n"
                    logging.debug(result_string)
                    dialect.write_to_result_file(result_string)
                    curr_results.append(result)

                comp_cases = compare_results(curr_results, guest_dbms)
                all_results.append(comp_cases)
                logging.info("COMPATIBILITY: {}\n".format([str(cc) for cc in comp_cases]))
                write_to_summary_file(summary_file, "RESULT: {}\n".format([str(cc) for cc in comp_cases]))
        except StopIteration:
            break

    for dialect in sql_dialects:
        dialect.close_result_file()

    sql_file_parts = sql_file.split("/")

    overall_compatibility = compute_summary(all_results, sql_dialects, summary_file, "/".join(sql_file_parts[-2:]), guest_dbms)
    if COMPARE_TO_EXPECTED_RESULT:
        guest_result_file = [d.result_file_name for d in sql_dialects if d.name == guest_dbms][0]
        compare_to_expected_result(os.path.join(result_folder, guest_result_file), sql_file, summary_file)

    if not summary_file is None:
        summary_file.close() 
    return overall_compatibility
 

def compare_to_expected_result(guest_result_file_name, expected_result_file_name, summary_file):
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
        

def get_query_string(query_iter):
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
        
    if 'PG_ABS_SRCDIR' in query or 'PG_LIBDIR' in query or 'PG_DLSUFFIX' in query or 'PG_ABS_BUILDDIR' in query:
                query = query.replace('PG_ABS_SRCDIR', PG_ABS_SRCDIR)
                query = query.replace('PG_LIBDIR', PG_LIBDIR)
                query = query.replace('PG_DLSUFFIX', PG_DLSUFFIX)
                query = query.replace('PG_ABS_BUILDDIR', PG_ABS_BUILDDIR)

    try:
        peek = next(query_iter)
        query_iter = itertools.chain([peek], query_iter)
        return f"{query};", query_iter
    except StopIteration:
        return f"{query}", query_iter # no semicolon here


def execute_single_test(test_folder, result_folder):
    if not os.path.exists(result_folder):
        os.makedirs(result_folder)

    print("==============================================\n")
    print(f"execute single test {test_folder} and storing results in {result_folder}\n")
    # we always want to drop and recreate the database because some tests might modify the data

    dialects = init_dialects(get_guest_dbms(test_folder + "/test.sql"))
    logging.debug(f"Dialects: {dialects}\n")

    execute_setup_sql(dialects, test_folder + "/setup.sql", result_folder, False) 

    for dialect in dialects:
        if dialect.name == "postgres":
            dialect.db_cursor.execute("SELECT pg_catalog.set_config('search_path', 'public', false);")
        # TODO check if we have to do something for other dialects

    test_result = execute_test_sql(dialects, test_folder + "/test.sql", result_folder)

    for dialect in dialects:
        dialect.teardown_connection()

    return test_result


def is_readonly_query(query: str):
    for line in query.splitlines():
        line = line.strip()
        if line == '' or line.startswith('--'):
            continue
        line = line.lower()
        if (line.startswith("select") or line.startswith("explain")) and not "pg_catalog.set_config" in line:
            return True
        else:
            return False


def extract_unused_names(setup_file, test_file):
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
    return unused_names


def is_create_unused_name(query, unused_names):
    for name in unused_names:
        pattern = re.compile(r'CREATE\s+(?:TABLE|ROLE|FUNCTION|TYPE)\s+{}[\s\(;\[]'.format(re.escape(name)), re.IGNORECASE)
        test = re.search(pattern, query)
        if test:
            return True
    return False


def purge_setup_sql(dialect, setup_file, setup_tmp_file, names_to_remove):
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
                result = dialect.exec_query(query)
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


def purge_test_sql(dialect, sql_file, expected_file):
    logging.info(f"Purge test {sql_file}")
    
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

                result = dialect.exec_query(query)

                result_string = f"RESULT:\n\t{result}\n"

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
 

def purge_single_test(test_folder):
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

    # in the first pass we remove readonly and errenous queries
    # in the subsequent passes we try to remove created tables but only apply the changes if the results are as expected
    while True:
        logging.info("Purging setup file")
        logging.info(f"Removing tables: {names_to_remove}")
        dialects = init_dialects(guest_dbms)
        dialects1 = [d for d in dialects if d.name == guest_dbms]
        dialect = dialects1[0]
        dialect.result_file_name = "tmp_result.txt"
        logging.debug(f"Dialect: {dialect}\n")

        has_changed = purge_setup_sql(dialect, setup_file, setup_tmp_file, names_to_remove) 

        execute_test_sql(dialects1, test_file, test_folder)

        check_expected = compare_to_expected_result(os.path.join(test_folder, dialect.result_file_name), test_folder + "/expected.txt", None)

        if has_changed and check_expected: # identical to expected result file
            logging.info("Result was identical to expected. Apply changes.")
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
                break # reducing setup failed
            names_to_remove.pop(-1)
        else:
            logging.info("Nothing changed")
            # revert changes
            if os.path.exists(setup_tmp_file):
                os.remove(setup_tmp_file)
            has_changed = False

        for dialect in dialects:
            if os.path.exists(os.path.join(test_folder, dialect.result_file_name)):
                os.remove(os.path.join(test_folder, dialect.result_file_name))
            dialect.teardown_connection()

        if unused_names_idx < len(unused_names):
            names_to_remove.append(unused_names[unused_names_idx])
            unused_names_idx = unused_names_idx + 1
        elif unused_names_idx >= len(unused_names) and not has_changed:
            break

    print("Removed names (not required by test): ", names_to_remove)


def execute_tests_in_folder_rec(test_folder, result_folder):
    logging.info(f"Execute ALL tests in {test_folder} (and all subfolders) and storing results in {result_folder}")
    all_results = []
    for fname in os.listdir(test_folder):

        single_test_path = os.path.join(test_folder, fname)
        logging.debug(f"single test path = {single_test_path}")
        
        if os.path.isdir(single_test_path) and fname != "data" and fname not in EXCLUDED_TESTS: # data is a special case because it does not contain tests but the tests data
            # when we found a folder, we recurse into it
            logging.debug(f"Found folder {fname}")
            rec_results = execute_tests_in_folder_rec(single_test_path, os.path.join(result_folder, fname))
            all_results = all_results + rec_results
        
        if os.path.isfile(single_test_path) and fname == "test.sql": # once we found a test.sql file, we can execute the test
            logging.debug(f"Found file {single_test_path}")
            test_result = execute_single_test(test_folder, result_folder)
            all_results.append(test_result)
            if PURGE_TESTS:
                purge_single_test(test_folder)
            return all_results # we assume there are no subfolders with tests
    return all_results


def init_dialects(guest_dbms):
    if GENERATE_EXPECTED:
        all_dbms = [PostgreSQL('regression', None, 'expected.txt'), DuckDB()] # TODO other SQL dialects here
        return [d for d in all_dbms if d.name == guest_dbms]
    return [PostgreSQL('regression', None, None), DuckDB()] 


def compute_overall_summary(all_results, result_folder):
    summary_file = open(os.path.join(result_folder, "summary_overall.txt"),  'w')
    if len(all_results) == 0:
        logging.error("No results found")
        return
    logging.debug("Computing overall summary...")
    logging.debug("all_results {}".format([str(cc) for row in all_results for cc in row]))
    logging.debug(f"all_results[0] {str(all_results[0])}")

    dialects = [r.dbms for r in all_results[0]]

    for d in dialects:
        d_results = [cc for row in all_results for cc in row if cc.dbms == d]
        logging.debug("dialect {}, d_results: {}".format(d, [str(res) for res in d_results]))
        num_results = len(d_results)
        
        print(f"\n=================\nOverall results for {d}\n")
        summary_file.write(f"\n=================\nOverall results for {d}\n")
        for cc in [CompatibilityCase.SAME, CompatibilityCase.DIFFERENT, CompatibilityCase.ERROR]:
            num = len([r for r in d_results if r.compatibility == cc])
            
            percentage = num/num_results * 100
            print("{}: {} test cases, which is {:.2f}%\n".format(cc.name, num, percentage))
            summary_file.write("{}: {} test cases, which is {:.2f}%\n".format(cc.name, num, percentage))
    
    summary_file.close()


def write_to_summary_file(summary_file, text):
    if not GENERATE_EXPECTED and not summary_file is None:
        summary_file.write(text)


all_results = execute_tests_in_folder_rec(TEST_PATH, RESULT_PATH)
compute_overall_summary(all_results, RESULT_PATH)