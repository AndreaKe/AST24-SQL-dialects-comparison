#!/bin/bash

# path to postgres_tests folder, e.g. /home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/
PG_ABS_SRCDIR=/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests
export PG_ABS_SRCDIR

results_folder=postgres_results/

# make sure database does not exist already
echo "Setup clean environment..."
psql -X -q -c "DROP DATABASE IF EXISTS regression;" postgres
psql -X -q -c "DROP TABLESPACE IF EXISTS regress_tblspace;" postgres

for currentTestPath in ${PG_ABS_SRCDIR}/*/; do 

    currentTest=$(basename "$currentTestPath")
    currentResults=$results_folder$currentTest

    if [ "$currentTest" == "data" ] || [ "$currentTest" == "test_setup" ] || [ "$currentTest" == "postgres_tests" ]; then   
    continue
    fi


    echo ""
    echo "==== Start test $currentTest ===="

    mkdir -p $currentResults

    #echo "Create database regression..."
    psql -X -q -c "CREATE DATABASE \"regression\" TEMPLATE=template0" -c "ALTER DATABASE \"regression\" SET lc_messages TO 'C';ALTER DATABASE \"regression\" SET lc_monetary TO 'C';ALTER DATABASE \"regression\" SET lc_numeric TO 'C';ALTER DATABASE \"regression\" SET lc_time TO 'C';ALTER DATABASE \"regression\" SET bytea_output TO 'hex';ALTER DATABASE \"regression\" SET timezone_abbreviations TO 'Default';" postgres

    #echo "Run setup.sql..."
    psql -X -a -q -d "regression" -v HIDE_TABLEAM=on -v HIDE_TOAST_COMPRESSION=on < "${currentTestPath}setup.sql" > "${currentResults}/postgres_setup.txt" 2>&1

    #echo "Run test.sql..."
    psql -X -a -q -d "regression" -v HIDE_TABLEAM=on -v HIDE_TOAST_COMPRESSION=on < "${currentTestPath}test.sql" > "${currentResults}/postgres.txt" 2>&1

    #echo "Cleanup environment, drop database..."
    psql -X -q -c "DROP DATABASE IF EXISTS regression;" postgres
    psql -X -q -c "DROP TABLESPACE IF EXISTS regress_tblspace;" postgres

    #echo "Compare result.txt to expected output..."
    diff -q ${currentTestPath}result.txt ${currentResults}/postgres.txt

    echo "Test $currentTest finished"

    sleep 2

done


