# AST24: Understanding the Difference between SQL Dialects using DBMS Test Suites

## 1 Requirements

Requirements for running the tests (without extracting them)
- liblz4 and libxml2 Ubuntu: 
  - `> sudo apt install -y liblz4-dev libxml2-dev`
  - Required for some postgres tests
- Python (3.10.12)
- PostgreSQL (built from source, version 17devel)
  - make sure to add it to PATH and set PGDATA
  - build with liblz4 and libxml2
    - `> ./configure --with-lz4 --with-libxml` (see https://www.postgresql.org/docs/devel/install-make.html)
  - You will also need to set the following environments variables, which are used in the postgres tests:
  - PG_ABS_SRCDIR = [path to folder containing the extracted postgres tests, e.g. AST24-SQL-dialects-comparison/postgres_tests]
  - PG_LIBDIR = [path to regress folder of postgres repository, e.g. postgresql/src/test/regress]
  - PG_DLSUFFIX = ".so"
  - PG_ABS_BUILDDIR = [path to postgres results folder, e.g. AST24-SQL-dialects-comparison/postgres_results]

- psycopg2 (2.9.9) including psycopg2.extensions (Python library for PostgreSQL)
- DuckDB (v0.10.1)
- duckdb (Python library for DuckDB)
- MySQL Server 8.0.36 (built from source)
- MySQL Python library (v1.10.0)

    
Requirements for extracting the test cases:
- Clone postgres repository (https://github.com/postgres/postgres/tree/master)
- Clone duckdb repository (https://github.com/duckdb/duckdb/tree/main)
- Clone MySQL repository (https://github.com/mysql/mysql-server/tree/8.0)


## 2 Running the Tests

The following command can be used to run the tests, purge the tests or generated the expected results file.

`> run_tests.py [OPTIONAL ARGUMENTS]`

The (optional) arguments are used as follows:

- `--test [TEST_FOLDER]`: sets the test folder. All tests in TEST_FOLDER and any of its subfolders are executed. Default: postgres_tests
- `--result [RESULT_FOLDER]`: sets the folder, where the test results are stored in. Default: postgres_results
- `--tol [TOLERANCE]`: defines with which tolerance to compare floating point numbers. Default: 0.001
- `--mysql_pw`: sets the password for MySQL root user. Default: ""
- `--purge`: changes the mode to purging (removing non-deterministic queries, minimizing setup.sql) and also generates or replaced the expected results file. No results are reported in the results folder. Only the files in the test folder are read and written.
- `--gen_expected`: changes the mode to generation of expected.txt. No results are provided in the result folder instead the results file is stored as the (new) expected result
- `--compare_expected`: Activates the comparison to the expected result. After executing a test, the results file will be compared to the expected result file. The result of the comparison is reported in the summary file of the test.

IMPORTANT: using more than one of `--purge`, `--gen_expected`, `--compare_expected` might lead to unexpected results (untested) 

For example: 
- `> run_tests.py --test postgres_tests --result postgres_results --compare_expected` 
  - Runs all postgres tests and compares the PostgreSQL results to the expected results file
- `> run_tests.py --test postgres_tests/boolean --result postgres_results/boolean` 
  - Runs only the boolean test extracted from the PostgreSQL test suite
- `> run_tests.py --test postgres_tests --result postgres_results --purge`
  - Purges all postgres tests
- `> run_tests.py --test postgres_tests/varchar --result postgres_results/varchar --gen_expected`
  - Generates the expected results file for the varchar test only

### Results
When executing `run_tests.py` the following results and summary files are generated:

- test_case/dbms_result.txt: For each test case and each DBMS, a [DBMS]_result.txt file is generated. It contains all executed queries and its result or the error message.
- test_case/summary.txt: For each test case, a summary.txt is generated. For each executed query, it contains the query itself and the compatibility cases for each DBMS. At the end, it prints, for each DBMS, the absolute number and percentage of test cases in each compatibility case.
- summary_overall.txt: Is placed directly in the folder specified by `--test`. For each test case and each DBMS, it contains the overall compatiblity and the percentages of queries in each compatibility case. In the end, it prints, for each DBMS, the absolute numbers and percentages of compatibility cases.


### Troubleshooting

- Cannot connect to Postgres:
  - Make sure that the Postgres server is running on the correct port. You can start it for example with `>  postgres -c log_statement=all -c log_destination='stderr,csvlog' -c logging_collector=o`. The user that executes this has to have permission to postgres. You might need to login with the postgres user using `su - postgres` before executing the previous command.
- Cannot connect to MySQL
  - You might have defined a password for MySQL during installation. We use the user root and assume that the password is empty. If that is not the case for you, you can specify the password with `--mysql_pw [your password]`.


## 3 Extracting Tests from the PostgreSQL Test Suite

1. ` > ./postgres_scripts/extract_postgres_tests.sh [PATH_TO_SRC_FOLDER] [PATH_TO_TARGET_FOLDER]`

   - PATH_TO_SRC_FOLDER is set to 'postgresql/src/test/regress/' where postgresql is the root directory of the postgresql repository
   - PATH_TO_TARGET_FOLDER is set to 'postgres_tests' (or wherever you want the extracted tests to be stored in)

   - This copies the test cases from the test suite (src path) to the target folder and modifies the test cases such that
     1. dependencies between tests are resolved such that each test can be executed independently of others
     2. some other modifications that make sure we can run the script using the Python library psycopg2 (e.g. replacing psql commands)

2. `> run_tests.py --test postgres_tests --result postgres_results --purge`
   - This purges the tests and also generates expected.txt

3. Now the tests are ready to be run on other DBMS
   - `> run_tests.py --test postgres_tests --result postgres_results`





