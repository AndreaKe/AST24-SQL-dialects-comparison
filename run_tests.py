import os
import sys, logging
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import re

logging.basicConfig(stream=sys.stderr, level=logging.WARNING) # change level to INFO or DEBUG to see more output

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

TEST_PATH = "postgres_tests"
RESULT_PATH = "postgres_results"  
if(len(sys.argv) > 1):
    TEST_PATH = str(sys.argv[1]) # 1. command line argument = TEST_PATH
if(len(sys.argv) > 2):
    RESULT_PATH = str(sys.argv[2]) # 2. command line argument = RESULT_PATH


def setup_clean_psql_db():
    logging.debug("POSTGRESQL: Setup clean database {} with user {} at {}:{}".format(DATABASE_NAME, DATABASE_USER, HOST, PORT))
    postgres_conn = psycopg2.connect(user=DATABASE_USER, password="*****", host=HOST, port=PORT)
    postgres_conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    postgres_cursor = postgres_conn.cursor()
    logging.debug(DROP_DB_STMT)
    postgres_cursor.execute(DROP_DB_STMT)
    logging.debug(CREATE_DB_STMT)
    postgres_cursor.execute(CREATE_DB_STMT)
    postgres_cursor.close()
    postgres_conn.close()


def setup_postgres_connection():
    logging.info("POSTGRESQL: Connecting to database {} at {}:{}".format(DATABASE_NAME, HOST, PORT))
    postgres_conn = psycopg2.connect(user=DATABASE_USER, password="*****", host=HOST, port=PORT, database=DATABASE_NAME)
    postgres_conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    return postgres_conn


def get_postgres_cursor(postgres_conn):
    return postgres_conn.cursor()


def teardown_postgres_connection(postgres_cursor, postgres_conn):
    # postgres_cursor.execute(DROP_DB_STMT) -> need to close connection first
    logging.info("POSTGRESQL: Close connection to database")
    postgres_cursor.close()
    postgres_conn.close()


def execute_sql_file_postgres(postgres_cursor, sql_file, result_file, expected_results_file, printErrors=True):
    logging.debug("POSTGRESQL: Executing {}".format(sql_file))
    # We write the results to a file such that results can be compare without needing to rerun the tests all the time
    result_file = open(result_file, 'w') 

    test_file_stream = open(sql_file, 'r')
    test_file = test_file_stream.read()
    test_file_stream.close()

    expected_results_stream = open(expected_results_file, 'r')
    expected_results = expected_results_stream.read()
    expected_results_stream.close()

    sql_commands = re.sub(r'(--[^\n]*\n)', '', test_file) # remove comments
    sql_commands = sql_commands.split(';') # here we get the individual sql commands!
    
    i = 0
    while i < len(sql_commands):
        command = sql_commands[i]
        dollar_count = command.count('$$')
        double_quotes_count = command.count('"')
        single_quotes_count = command.count("'")

        while dollar_count % 2 != 0 or  double_quotes_count % 2 != 0 or single_quotes_count % 2 != 0:
            i = i + 1
            command = command + ";" + sql_commands[i]
            dollar_count = command.count('$$')
            double_quotes_count = command.count('"')
            single_quotes_count = command.count("'")

        command_string = "{}\n".format(command)


        logging.info("\n\tInfo: i={}, command={}".format(i, command_string))
        result_file.write(command_string)
        if command.strip() != '':
            try:
                postgres_cursor.execute(command)
                result = postgres_cursor.fetchall() # TODO: here we can compare results to other DBMS results
                result_string = "RESULT: \n\t{}\n".format(result)
                logging.info(result_string)
                result_file.write(result_string)
            except psycopg2.ProgrammingError as e:
                if str(e) != "no results to fetch": 
                    pattern = r'.*{};[^\n]*\s*(ERROR)?:?\s*{}.*'.format(re.escape(command.strip()), re.escape(str(e)))
                    if printErrors and not re.search(pattern, expected_results):
                        logging.warning("ProgrammingError: {}\n{}\n".format(command, e))
                        result_file.write("ProgrammingError: {}\n{}\n".format(command, e))
            except psycopg2.Error as e:
                pattern = r'.*{};?[^\n]*\s*(ERROR)?:?\s*{}.*'.format(re.escape(command).strip(), re.escape(str(e)))
                if printErrors and not re.search(pattern, expected_results):
                    logging.warning("ERROR: {}\n{}\n".format(command, e))
                    result_file.write("ERROR: {}\n{}\n".format(command, e))
        i = i + 1
    result_file.close()

def execute_single_test_postgres(test_folder, result_folder):
    # we always want to drop and recreate the database because some tests might modify the data
    logging.debug("POSTGRESQL: execute single test {} and storing results in {}\n".format(test_folder, result_folder))
    setup_clean_psql_db()

    postgres_conn = setup_postgres_connection()
    postgres_cursor = get_postgres_cursor(postgres_conn)

    execute_sql_file_postgres(postgres_cursor, test_folder + "/setup.sql", os.path.join(result_folder, "postgres_setup.txt"), os.path.join(test_folder, 'result.txt'), False) 
    execute_sql_file_postgres(postgres_cursor, test_folder + "/test.sql", os.path.join(result_folder, "postgres_results.txt"), os.path.join(test_folder, 'result.txt'))

    teardown_postgres_connection(postgres_cursor, postgres_conn)


def execute_single_test(test_folder, result_folder):
    print("==============================================\n")
    print("execute single test {} and storing results in {}\n".format(test_folder, result_folder))
    execute_single_test_postgres(test_folder, result_folder)
    # TODO: execute tests on DuckDB and MySQL, compare and report the results
    # Note: probably we want to setup 3 databases first (for Postgres, DuckDB, MySQL), 
    # then execute setup for all of them
    # then execute test.sql one statement after the other for all of them.
    # With this structure we can compare the results of each statement directly.



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



execute_tests_in_folder_rec(TEST_PATH, RESULT_PATH)
