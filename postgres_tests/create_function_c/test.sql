--
-- CREATE_FUNCTION_C
--
-- This script used to create C functions for other scripts to use.
-- But to get rid of the ordering dependencies that caused, such
-- functions are now made either in test_setup.sql or in the specific
-- test script that needs them.  All that remains here is error cases.

-- directory path and dlsuffix are passed to us in environment variables
-- \getenv libdir '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress'
-- \getenv dlsuffix '.so'

-- \set regresslib '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress' '/regress' '.so'

--
-- Check LOAD command.  (The alternative of implicitly loading the library
-- is checked in many other test scripts.)
--
LOAD '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress/regress.so';

-- Things that shouldn't work:

CREATE FUNCTION test1 (int) RETURNS int LANGUAGE C
    AS 'nosuchfile';

-- To produce stable regression test output, we have to filter the name
-- of the regresslib file out of the error message in this test.
-- \set VERBOSITY sqlstate
CREATE FUNCTION test1 (int) RETURNS int LANGUAGE C
    AS '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress/regress.so', 'nosuchsymbol';
-- \set VERBOSITY default
SELECT regexp_replace(:'LAST_ERROR_MESSAGE', 'file ".*"', 'file "..."');

CREATE FUNCTION test1 (int) RETURNS int LANGUAGE internal
    AS 'nosuch';
