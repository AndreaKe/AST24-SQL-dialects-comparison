# AST24: Understanding the Difference between SQL Dialects using DBMS Test Suites

## Requirements

Requirements for running the tests (without extracting them)
- Python 
- PostgreSQL - make sure to add it to PATH and set PGDATA
- psycopg2 including psycopg2.extensions (Python library for PostgreSQL)
- DuckDB - make sure to add it to PATH
- duckdb (Python library for DuckDB)
- MySQL - make sure to add it to PATH
- MySQL Python library
  
Requirements for extracting the test cases:
- Clone postgres repository (https://github.com/postgres/postgres/tree/master)
- Clone duckdb repository (https://github.com/duckdb/duckdb/tree/main)
- Clone MySQL repository


## Running the Tests

`> run_tests.py [PATH_TO_TEST_FOLDER] [PATH_TO_RESULTS_FOLDER]`

This runs all tests inside PATH_TO_TEST_FOLDER (and all its subfolders). The result files are written to PATH_TO_RESULTS_FOLDER.

For example: 
`> run_tests.py postgres_tests postgres_results` Runs all tests extracted from the PostgreSQL test suite
`> run_tests.py postgres_tests/boolean postgres_tests/boolean` Only runs the boolean test extracted from the PostgreSQL test suite


### Troubleshooting

- Cannot connect to Postgres:
  - Make sure that the Postgres server is running on the correct port. You can start it for example with `>  postgres -c log_statement=all -c log_destination='stderr,csvlog' -c logging_collector=o`.
  - The user that executes the tests has to have permission to postgres. You might need to login with the postgres user using `su - postgres` before running the test.


## Extracting PostgreSQL test cases

` > ./postgres_scripts/extract_postgres_tests.sh [PATH_TO_SRC_FOLDER] [PATH_TO_TARGET_FOLDER]`

- PATH_TO_SRC_FOLDER is set to 'postgresql/src/test/regress/' where postgresql is the root directory of the postgresql repository
- PATH_TO_TARGET_FOLDER is set to 'postgres_tests'

This copies the test cases from the test suite (src path) to the target folder and modifies the test cases such that
1. dependencies between tests are resolved such that each test can be executed independently of others
2. some other modifications that make sure we can run the script using the Python library psycopg2 (e.g. replacing psql commands)




