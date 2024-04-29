#!/bin/bash

# NOTE: I use this script to debug the postgresql test in order to ensure that they return the
# expected results (as defined in the postgres repository) 

export PGTZ="PST8PDT"
export PGDATESTYLE="Postgres, MDY"
export LC_MESSAGES="C"
echo $PGOPTIONS
export PGOPTIONS="-c intervalstyle=postgres_verbose"
export LANG="C"


results_folder=results/

# make sure database does not exist already
echo "Setup clean environment..."
psql -X -q -c "DROP DATABASE IF EXISTS regression;" postgres
psql -X -q -c "DROP TABLESPACE IF EXISTS regress_tblspace;" postgres
mkdir results

for currentTestPath in ${PG_ABS_SRCDIR}/*/; do 

    currentTest=$(basename "$currentTestPath")



    currentResults=$results_folder$currentTest

    if [ "$currentTest" == "data" ] || [ "$currentTest" == "postgres_tests" ]|| [ "$currentTest" == "generated" ] || [ "$currentTest" == "typed_table" ]; then   
    continue
    fi


    # TODO probably we can just call run_postgres_single_test.sh


    echo ""
    echo "==== Start test $currentTest ===="

    mkdir -p $currentResults

    #echo "Create database regression..."
    psql -X -q -c "CREATE DATABASE \"regression\" WITH OWNER = postgres ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'C' LC_CTYPE = 'en_US.UTF-8' TEMPLATE=template0" -c "ALTER DATABASE \"regression\" SET lc_messages TO 'C';ALTER DATABASE \"regression\" SET lc_monetary TO 'C';ALTER DATABASE \"regression\" SET lc_numeric TO 'C';ALTER DATABASE \"regression\" SET lc_time TO 'C';ALTER DATABASE \"regression\" SET bytea_output TO 'hex';ALTER DATABASE \"regression\" SET timezone_abbreviations TO 'Default';" postgres

    touch "${currentResults}/postgres_setup.txt"

    #echo "Run setup.sql..."
    psql -X -a -q -d "regression" -v HIDE_TABLEAM=on -v HIDE_TOAST_COMPRESSION=on < "${currentTestPath}setup.sql" > "${currentResults}/postgres_setup.txt" 2>&1

    touch "${currentResults}/postgres.txt"
    #echo "Run test.sql..."
    psql -X -a -q -d "regression" -v HIDE_TABLEAM=on -v HIDE_TOAST_COMPRESSION=on < "${currentTestPath}test.sql" > "${currentResults}/postgres.txt" 2>&1

    #echo "Cleanup environment, drop database..."
    psql -X -q -c "DROP DATABASE IF EXISTS regression;" postgres
    psql -X -q -c "DROP TABLESPACE IF EXISTS regress_tblspace;" postgres

    #echo "Compare result.txt to expected output..."
    python3 postgres_compare_results.py ${currentResults}/postgres.txt ${currentTestPath}result.txt 

    echo "Test $currentTest finished"

    

done


