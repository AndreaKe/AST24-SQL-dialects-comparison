#!/bin/bash

currentTest=$1

# path to postgres_tests folder, e.g. /home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/
PG_ABS_SRCDIR=/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests # TODO 
export PG_ABS_SRCDIR

PG_LIBDIR="/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress"  # TODO 
export PG_LIBDIR

PG_DLSUFFIX=".so"
export PG_DLSUFFIX

export PGTZ="PST8PDT"
export PGDATESTYLE="Postgres, MDY"
export LC_MESSAGES="C"
echo $PGOPTIONS
export PGOPTIONS="-c intervalstyle=postgres_verbose"
export LANG="C"


results_folder=postgres_results/

# make sure database does not exist already
echo "Setup clean environment..."
psql -X -q -c "DROP DATABASE IF EXISTS regression;" postgres
psql -X -q -c "DROP TABLESPACE IF EXISTS regress_tblspace;" postgres

currentTestPath=$PG_ABS_SRCDIR/$currentTest/

    
currentResults=$results_folder$currentTest

if [ "$currentTest" == "data" ] || [ "$currentTest" == "test_setup" ] || [ "$currentTest" == "postgres_tests" ]; then   
continue
fi


echo ""
echo "==== Start test $currentTest ===="

mkdir -p $currentResults

#echo "Create database regression..."
psql -X -q -c "CREATE DATABASE \"regression\" WITH OWNER = postgres ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'C' LC_CTYPE = 'en_US.UTF-8' TEMPLATE=template0" -c "ALTER DATABASE \"regression\" SET lc_messages TO 'C';ALTER DATABASE \"regression\" SET lc_monetary TO 'C';ALTER DATABASE \"regression\" SET lc_numeric TO 'C';ALTER DATABASE \"regression\" SET lc_time TO 'C';ALTER DATABASE \"regression\" SET bytea_output TO 'hex';ALTER DATABASE \"regression\" SET timezone_abbreviations TO 'Default';" postgres

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


