# AST24: Understanding the Difference between SQL Dialects using DBMS Test Suites

Our goal is to understand and summarize the differences between SQL dialects. 

For this purpose, extract the test suite of one DBMS with its own dialect and features and run the extracted tests on another DBMS for comparison. We use the existing test suites since they cover all features of a SQL dialect.

The DBMS/Test Suites supported are:

1. Postgres
2. MySQL

Additionally, we implemented support for executing the extracted test suites not only on Postgres and MySQL but also on DuckDB.

In this repository you find the scripts used for extracting the test cases of Postgres in the `postgres_scripts` directory and MySQL in `mysql_scripts`.

Inside the `postgres_tests` directory you find the extracted test cases and our generated expected result files.

Since the MySQL main test suite is very large, we only included a few extracted test here, which you'll find in `mysql_tests`.
All of the extracted test cases can be downloaded here: https://polybox.ethz.ch/index.php/s/NELgI95awuaNrTC

After extracting the test suites a certain DBMS we execute them against the other DBMS using our `run_test.py` script, which is described further down below in this README. The script classifies the queries executed into three compatibility cases: SAME, ERROR and DIFFERENT. It also collects statistics. Summaries, query comparison logs and results of executing the test suite of one specific DBMS's test suite can be found in the corresponding '..._results' folder, i.e. the results of executing the Postgres Test Suite against all DBMS can be found in `postgres_results`.

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
- MySQL Server 8.0.36 (built from source, cmake with `-
DWITH_DEBUG=1`)
  - Prerquisites: https://dev.mysql.com/doc/refman/8.0/en/source-installation-prerequisites.html
  - Manual on how to build from source: https://downloads.mysql.com/docs/mysql-sourcebuild-excerpt-8.0-en.pdf
  - Quick way to build from source if you haven't installed the correct version of boost: 
  1. `git clone https://github.com/mysql/mysql-server/tree/8.0`
  2. `cd mysql-server`
  3. `mkdir build`
  4. `cd build`
  5. `cmake .. -DDOWNLOAD_BOOST=1 -DWITH_BOOST=~/boost -DWITH_DEBUG=1`
  6. `make`
- MySQL Python library (v1.10.0)

    
Requirements for extracting the test cases:
- Clone postgres repository (https://github.com/postgres/postgres/tree/master)
- Clone duckdb repository (https://github.com/duckdb/duckdb/tree/main)
- Clone MySQL repository (https://github.com/mysql/mysql-server/tree/8.0)


## 2 Running the Tests

The following command can be used to run the tests, purge the tests or generate the expected results file.

`> run_tests.py [OPTIONAL ARGUMENTS]`

The (optional) arguments are used as follows:

- `--test [TEST_FOLDER]`: sets the test folder. All tests in TEST_FOLDER and any of its subfolders are executed. Default: postgres_tests
- `--result [RESULT_FOLDER]`: sets the folder, where the test results are stored in. Default: postgres_results
- `--tol [TOLERANCE]`: defines with which tolerance to compare floating point numbers. Default: 0.001
- `--mysql_pw`: sets the password for MySQL root user. Default: ""
- `--purge`: changes the mode to purging (removing non-deterministic queries, minimizing setup.sql) and also generates or replaces the expected results file. No results are reported in the results folder. Only the files in the test folder are read and written.
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
- The MySQL server is running with the --read-only option so it cannot execute this statement
  - Ensure that you have executed 'SET GLOBAL read_only = OFF;' before executing `run_tests.py`.
- Setting the MySQL root user password to an empty string:
  - Log in to MySQL using sudo `sudo mysql -u root`, then execute `ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '';` and finally `exit`.

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

## 4 Extracting Tests from the MySQL Test Suite

1. ` > ./mysql_scripts/extract_mysql_tests.sh -MYSQL_TEST_SUITE_PATH [PATH_TO_MYSQL_TEST_SUITE] -MYSQL_BUILD_PATH [PATH_TO_MYSQL_BUILD_FOLDER]`

   - -MYSQL_TEST_SUITE_PATH is set to 'mysql-server/mysql-test/t' where mysql-server is the root directory of the mysql repository
   - -MYSQL_BUILD_PATH is set to the build folder
   -dont_skip_existing also already extracted test cases

  The script modifies the test cases in the repository such that all the executed queries by a test case should appear in query log and afterwards, it executes 'git reset --hard'. Then executes mysql-test-run on each modified test case (one by one), stores the query log inside the temp_mysql folder and writes the extracted test case into the mysql-tests folder. The test cases which it failed to extract are logged into failed.txt.

2. `> run_tests.py --test mysql_tests --result mysql_results --gen_expected`
   - This generates expected.txt

3. Now the tests are ready to be run on other DBMS
   - `> run_tests.py --test mysql_tests --result mysql_results`


