import os
import sys, logging
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import duckdb


TEST_PATH = "postgres_tests"
RESULT_PATH = "postgres_results"  
if(len(sys.argv) > 1):
    TEST_PATH = str(sys.argv[1]) # 1. command line argument = TEST_PATH
if(len(sys.argv) > 2):
    RESULT_PATH = str(sys.argv[2]) # 2. command line argument = RESULT_PATH

logging.basicConfig(stream=sys.stderr, level=logging.ERROR) # change level to INFO or DEBUG to see more output


class SQLDialectWrapper(object):
    name = ""
    db_conn = None
    db_cursor = None
    result_file = None

    PASS = 1
    ERROR = -1

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

    def create_result_dict(self, status, result):
        return {'status': status, 'result': result}
    
    def create_no_result_dict(self):
        return self.create_result_dict(self.PASS, None)
    
    def create_error_dict(self):
        return self.create_result_dict(self.ERROR, None)


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
                return self.create_no_result_dict()
            result = result.fetchall()
            result_string = "RESULT: \n\t{}\n".format(result)
            logging.info(result_string)
            self.result_file.write(result_string)
            return self.create_result_dict(self.PASS, result)
        except Exception as e:
            self.result_file.write("ERROR: {}\n{}\n".format(command, e))
            if printErrors:
                logging.warning("ERROR: {}\n{}\n".format(command, e))
            return self.create_error_dict()


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
            return self.create_result_dict(self.PASS, result)
        except psycopg2.ProgrammingError as e:
            if str(e) == "no results to fetch": 
                return self.create_no_result_dict()
            else:
                self.result_file.write("ProgrammingError: {}\n{}\n".format(command, e))
                if printErrors:
                    logging.warning("ProgrammingError: {}\n{}\n".format(command, e))
                return self.create_error_dict()
                
        except psycopg2.Error as e:
            self.result_file.write("ERROR: {}\n{}\n".format(command, e))
            if printErrors:
                logging.warning("ERROR: {}\n{}\n".format(command, e))
            return self.create_error_dict()
        except Exception as e:
            self.result_file.write("ERROR: {}\n{}\n".format(command, e))
            if printErrors:
                logging.warning("ERROR: {}\n{}\n".format(command, e))
            return self.create_error_dict()


def execute_sql_file(sql_dialects, sql_file, result_folder, printErrors=True):
    logging.debug("Executing test case {}".format(sql_file))
    # We write the results to a file such that results can be compare without needing to rerun the tests all the time
    for dialect in sql_dialects:
        dialect.open_result_file(result_folder)

    test_file_stream = open(sql_file, 'r')
    test_file = test_file_stream.read()
    test_file_stream.close()

    sql_commands = test_file.split(';') # here we get the individual sql commands!
    command_iter = iter(sql_commands)
    
    while True:
        try:
            command = get_command(command_iter)

            for dialect in sql_dialects:
                dialect.write_to_result_file(command)
            if command.strip() != '':
                logging.info("\nExecuting command:  {}".format(command))
                results = []
                for dialect in sql_dialects:
                    results.append(dialect.exec_command(printErrors, command))
                # TODO compare results & store them to some output file
        except StopIteration:
            break

    for dialect in sql_dialects:
        dialect.close_result_file()

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
            logging.error("Index out of bounds. Command: ".format(command))
            raise e

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
