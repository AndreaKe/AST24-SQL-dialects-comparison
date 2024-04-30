import os
import sys, logging
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import duckdb
import pymysql
from enum import Enum

logging.basicConfig(stream=sys.stderr, level=logging.DEBUG) # change level to INFO or DEBUG to see more output

PG_ABS_SRCDIR = os.environ.get('PG_ABS_SRCDIR')
PG_LIBDIR = "'" + os.environ.get('PG_LIBDIR') + "'"
PG_DLSUFFIX = "'" + os.environ.get('PG_DLSUFFIX', '.so') + "'"
PG_ABS_BUILDDIR = os.environ.get('PG_ABS_BUILDDIR')

logging.debug("PG_ABS_SRCDIR={}".format(PG_ABS_SRCDIR))
logging.debug("PG_LIBDIR={}".format(PG_LIBDIR))
logging.debug("PG_DLSUFFIX={}".format(PG_DLSUFFIX))
logging.debug("PG_ABS_BUILDDIR={}".format(PG_ABS_BUILDDIR))


class QueryStatus(Enum):
    PASS = 1
    ERROR = -1

class CompatibilityCase(Enum):
    SAME = 1
    DIFFERENT = 0
    ERROR = -1


TEST_PATH = PG_ABS_SRCDIR
RESULT_PATH = PG_ABS_BUILDDIR  
if(len(sys.argv) > 1):
    TEST_PATH = str(sys.argv[1]) # 1. command line argument = TEST_PATH
if(len(sys.argv) > 2):
    RESULT_PATH = str(sys.argv[2]) # 2. command line argument = RESULT_PATH


class QueryResult(object):
    dbms = ""
    status = ""
    result = None

    def __init__(self, dbms, status, result):
        self.dbms = dbms
        self.status = status
        self.result = result

    def is_result_identical(self, other):
        if self.result == None or other.result == None:
            return self.result == None and other.result == None
        return sorted(self.result, key=lambda x: (x is None, x)) == sorted(other.result, key=lambda x: (x is None, x))
    
    def __str__(self):
        return f"{self.dbms}: {self.status} with {self.result}"


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

    def exec_command(self, printErrors, command):
        pass

    def create_query_result(self, status, result):
        return QueryResult(self.name, status, result)
    
    def create_empty_query_result(self):
        return self.create_query_result(QueryStatus.PASS, None)
    
    def create_error_query_result(self):
        return self.create_query_result(QueryStatus.ERROR, None)


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

    def exec_command(self, printErrors, command):
        try:
            result = self.db_conn.sql(command)
            if result == None:
                return self.create_empty_query_result()
            result = result.fetchall()
            result_string = "RESULT: \n\t{}\n".format(result)
            logging.info(result_string)
            self.result_file.write(result_string)
            return self.create_query_result(QueryStatus.PASS, result)
        except Exception as e:
            self.result_file.write("ERROR: {}\n{}\n".format(command, e))
            if printErrors:
                logging.warning("ERROR: {}\n{}\n".format(command, e))
            return self.create_error_query_result()


class PostgreSQL(SQLDialectWrapper):
    name = "postgres"
    db_conn = None
    db_cursor = None
    result_file = None

    RESULT_FILE_NAME = "postgres_result.txt"

    DATABASE_NAME = "regression"
    DATABASE_USER = "postgres"
    HOST = "localhost"
    PORT = 5432

    DROP_DB_STMT = "DROP DATABASE IF EXISTS {}".format(DATABASE_NAME)

    CREATE_DB_STMT = """CREATE DATABASE {} WITH 
        OWNER = {} 
        ENCODING = 'UTF8' 
        TABLESPACE = pg_default 
        LC_COLLATE = 'C' 
        LC_CTYPE = 'en_US.UTF-8' 
        TEMPLATE = template0 """.format(DATABASE_NAME, DATABASE_USER)

    def setup_clean_db(self):
        logging.debug("POSTGRESQL: Setup clean database {} with user {} at {}:{}".format(self.DATABASE_NAME, self.DATABASE_USER, self.HOST, self.PORT))
        tmp_db_conn = psycopg2.connect(user=self.DATABASE_USER, password="*****", host=self.HOST, port=self.PORT)
        tmp_db_conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        tmp_db_cursor = tmp_db_conn.cursor()
        logging.debug(self.DROP_DB_STMT)
        tmp_db_cursor.execute(self.DROP_DB_STMT)
        tmp_db_conn.commit()
        logging.debug(self.CREATE_DB_STMT)
        tmp_db_cursor.execute(self.CREATE_DB_STMT)
        tmp_db_conn.commit()
        tmp_db_cursor.close()
        tmp_db_conn.close()

    def setup_connection(self):
        logging.info("POSTGRESQL: Connecting to database {} at {}:{}".format(self.DATABASE_NAME, self.HOST, self.PORT))
        self.db_conn = psycopg2.connect(user=self.DATABASE_USER, password="*****", host=self.HOST, port=self.PORT, database=self.DATABASE_NAME)
        self.db_conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        self.db_cursor = self.db_conn.cursor()

    def teardown_connection(self):
        logging.info("POSTGRESQL: Close connection to database")
        self.db_cursor.close()
        self.db_conn.close()

    def open_result_file(self, result_folder):
        self.result_file = open(os.path.join(result_folder, self.RESULT_FILE_NAME), 'w') 

    def write_to_result_file(self, content):
        self.result_file.write(content)

    def close_result_file(self):
        self.result_file.close()

    def exec_command(self, printErrors, command):
        try:
            self.db_cursor.execute(command)
            result = self.db_cursor.fetchall()
            result_string = "RESULT: \n\t{}\n".format(result)
            logging.info(result_string)
            self.result_file.write(result_string)
            return self.create_query_result(QueryStatus.PASS, result)
        except psycopg2.ProgrammingError as e:
            if str(e) == "no results to fetch": 
                return self.create_empty_query_result()
            else:
                self.result_file.write("ProgrammingError: {}\n{}\n".format(command, e))
                if printErrors:
                    logging.warning("ProgrammingError: {}\n{}\n".format(command, e))
                return self.create_error_query_result()
                
        except psycopg2.Error as e:
            self.result_file.write("ERROR: {}\n{}\n".format(command, e))
            if printErrors:
                logging.warning("ERROR: {}\n{}\n".format(command, e))
            return self.create_error_query_result()
        except Exception as e:
            self.result_file.write("ERROR: {}\n{}\n".format(command, e))
            if printErrors:
                logging.warning("ERROR: {}\n{}\n".format(command, e))
            return self.create_error_query_result()
        

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

    def exec_command(self, printErrors, command):
        try:
            self.db_cursor.execute(command)
            result = self.db_cursor.fetchall()
            result_string = "RESULT: \n\t{}\n".format(result)
            logging.info(result_string)
            self.result_file.write(result_string)
        except pymysql.ProgrammingError as e:
            if str(e) != "no results to fetch": 
                logging.warning("ProgrammingError: {}\n".format(e))
                self.result_file.write("ProgrammingError: {}\n".format(e))
                #if "You have an error in your SQL syntax" in str(e):
                #    print(e)
                #    print(command)
                #    print(file)
                #    exit()
        except pymysql.Error as e:
            logging.warning("ERROR: {}\n".format(e))
            self.result_file.write("ERROR: {}\n".format(e))       

def get_guest_dbms(file_path):
    return file_path.split("/")[-3].replace("_tests", "")

def is_guest_dbms(dbms: SQLDialectWrapper, guest_dbms):
    return dbms.name == guest_dbms


def compare_single_result(guest_result: QueryResult, host_result: QueryResult):
    if guest_result.status !=  host_result.status:
        return CompatibilityCase.ERROR
    elif guest_result.status == CompatibilityCase.ERROR:
        return CompatibilityCase.SAME
    elif guest_result.is_result_identical(host_result): # TODO: what if the order matters?
        return CompatibilityCase.SAME
    else:
        return CompatibilityCase.DIFFERENT


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


def compute_summary(all_results, dialects, summary_file):
    logging.debug("Computing summary...")
    logging.debug("all_results {}".format([str(cc) for row in all_results for cc in row]))

    for d in dialects:
        d_results = [cc for row in all_results for cc in row if cc.dbms == d.name]
        logging.debug("dialect {}, d_results: {}".format(d.name, d_results))
        num_results = len(d_results)
        
        if num_results == 0:
            continue
        
        print("\n=================\nResults for {}\n".format(d.name))
        summary_file.write("\n=================\nResults for {}\n".format(d.name))
        for cc in CompatibilityCase:
            num = len([r for r in d_results if r.result == cc])
            percentage = num/num_results * 100
            print("{}: {} tests, which is {:.2f}%\n".format(cc.name, num, percentage))
            summary_file.write("{}: {} tests, which is {:.2f}%\n".format(cc.name, num, percentage))
        
        


def execute_sql_file(sql_dialects, sql_file, result_folder, printErrors=True):
    logging.debug("Executing test case {}".format(sql_file))
    # We write the results to a file such that results can be compare without needing to rerun the tests all the time
    for dialect in sql_dialects:
        dialect.open_result_file(result_folder)

    summary_file = open(os.path.join(result_folder, "summary.txt"), 'w') 

    test_file_stream = open(sql_file, 'r')
    test_file = test_file_stream.read()
    test_file_stream.close()

    guest_dbms = get_guest_dbms(sql_file)

    logging.info("Guest DBMS identified: {}".format(guest_dbms))
    summary_file.write("Guest DBMS identified: {}".format(guest_dbms))

    sql_commands = test_file.split(';') # here we get the individual sql commands!
    command_iter = iter(sql_commands)

    all_results = []
    
    while True:
        try:
            command = get_command(command_iter)

            for dialect in sql_dialects:
                dialect.write_to_result_file(command)
            if command.strip() != '':
                logging.info("\nExecuting command:  {}".format(command))
                summary_file.write("\nQUERY:  {}".format(command))
                curr_results = []
                for dialect in sql_dialects:
                    result = dialect.exec_command(printErrors, command)
                    curr_results.append(result)
                    logging.debug("RESULT: {}".format(result))

                comp_cases = compare_results(curr_results, guest_dbms)
                all_results.append(comp_cases)
                logging.info("COMPATIBILITY: {}\n".format([str(cc) for cc in comp_cases]))
                summary_file.write("RESULT: {}\n".format([str(cc) for cc in comp_cases]))

        except StopIteration:
            break

    for dialect in sql_dialects:
        dialect.close_result_file()

    compute_summary(all_results, sql_dialects, summary_file)  
    summary_file.close() 
 

def get_command(command_iter):
    command = next(command_iter)
    dollar_count = command.count('$$')
    double_quotes_count = command.count('"')
    single_quotes_count = command.count("'")

    while dollar_count % 2 != 0 or  double_quotes_count % 2 != 0 or single_quotes_count % 2 != 0:
        try:
            command = command + ";" + next(command_iter)
            dollar_count = command.count('$$')
            double_quotes_count = command.count('"')
            single_quotes_count = command.count("'")
        except StopIteration as e:
            logging.error("Index out of bounds. Command: {}".format(command))
            raise e
        
    if 'PG_ABS_SRCDIR' in command or 'PG_LIBDIR' in command or 'PG_DLSUFFIX' in command or 'PG_ABS_BUILDDIR' in command:
                command = command.replace('PG_ABS_SRCDIR', PG_ABS_SRCDIR)
                command = command.replace('PG_LIBDIR', PG_LIBDIR)
                command = command.replace('PG_DLSUFFIX', PG_DLSUFFIX)
                command = command.replace('PG_ABS_BUILDDIR', PG_ABS_BUILDDIR)

    return "{}\n".format(command)


def execute_single_test(test_folder, result_folder):
    if not os.path.exists(result_folder):
        os.makedirs(result_folder)

    print("==============================================\n")
    print("execute single test {} and storing results in {}\n".format(test_folder, result_folder))
    # we always want to drop and recreate the database because some tests might modify the data

    dialects = init_dialects()

    execute_sql_file(dialects, test_folder + "/setup.sql", result_folder, False) 

    for dialect in dialects:
        if dialect.name == "postgres":
            dialect.db_cursor.execute("SELECT pg_catalog.set_config('search_path', 'public', false);")
        # TODO check if we have to do something for other dialects

    execute_sql_file(dialects, test_folder + "/test.sql", result_folder)

    for dialect in dialects:
        dialect.teardown_connection()


def execute_tests_in_folder_rec(test_folder, result_folder):
    logging.info("Execute ALL tests in {} (and all subfolders) and storing results in {}".format(test_folder, result_folder))
    for fname in os.listdir(test_folder):

        single_test_path = os.path.join(test_folder, fname)
        logging.debug("single test path = {}".format(single_test_path))
        
        if os.path.isdir(single_test_path) and fname != "data": # data is a special case because it does not contain tests but the tests data
            # when we found a folder, we recurse into it
            logging.debug("Found folder {}".format(fname))
            execute_tests_in_folder_rec(single_test_path, os.path.join(result_folder, fname))
        
        if os.path.isfile(single_test_path) and fname == "test.sql": # once we found a test.sql file, we can execute the test
            logging.debug("Found file {}".format(single_test_path))
            execute_single_test(test_folder, result_folder)
            return # we assume there are no subfolders with tests


def init_dialects():
    return [PostgreSQL(), DuckDB()] # TODO other SQL dialects here

execute_tests_in_folder_rec(TEST_PATH, RESULT_PATH)
