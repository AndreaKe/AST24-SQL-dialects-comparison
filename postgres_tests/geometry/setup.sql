-- START setup from test_setup 
--
-- TEST_SETUP --- prepare environment expected by regression test scripts
--

-- directory paths and dlsuffix are passed to us in environment variables
-- \getenv abs_srcdir PG_ABS_SRCDIR
-- \getenv libdir PG_LIBDIR
-- \getenv dlsuffix PG_DLSUFFIX

-- \set regresslib /* REPLACED */ PG_LIBDIR '/regress' /* REPLACED */ PG_DLSUFFIX

--
-- synchronous_commit=off delays when hint bits may be set. Some plans change
-- depending on the number of all-visible pages, which in turn can be
-- influenced by the delayed hint bits. Force synchronous_commit=on to avoid
-- that source of variability.
--
SET synchronous_commit = on;

--
-- Postgres formerly made the public schema read/write by default,
-- and most of the core regression tests still expect that.
--
GRANT ALL ON SCHEMA public TO public;

-- Create a tablespace we can use in tests.
SET allow_in_place_tablespaces = true;

CREATE TABLE POINT_TBL(f1 point);

INSERT INTO POINT_TBL(f1) VALUES
  ('(0.0,0.0)'),
  ('(-10.0,0.0)'),
  ('(-3.0,4.0)'),
  ('(5.1, 34.5)'),
  ('(-5.0,-12.0)'),
  ('(1e-300,-1e-300)'),  -- To underflow
  ('(1e+300,Inf)'),  -- To overflow
  ('(Inf,1e+300)'),  -- Transposed
  (' ( Nan , NaN ) '),
  ('10.0,10.0');
-- END setup from test_setup 
SELECT pg_catalog.set_config('search_path', 'public', false);

-- we want to work with a point_tbl that includes a null
CREATE TEMP TABLE point_tbl AS SELECT * FROM public.point_tbl;
INSERT INTO POINT_TBL(f1) VALUES (NULL);

CREATE INDEX gpointind ON point_tbl USING gist (f1);

--
-- Test GiST indexes
--

-- get non-indexed results for comparison purposes

SET enable_seqscan = ON;
SET enable_indexscan = OFF;
SET enable_bitmapscan = OFF;

-- Now check the results from plain indexscan
SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

-- Now check the results from bitmap indexscan
SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;

SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;
-- \d+ gin_relopts_test

--
-- HASH
--
CREATE UNLOGGED TABLE unlogged_hash_table (id int4);
CREATE INDEX unlogged_hash_index ON unlogged_hash_table USING hash (id int4_ops);
DROP TABLE unlogged_hash_table;

-- CREATE INDEX hash_ovfl_index ON hash_ovfl_heap USING hash (x int4_ops) /* REPLACED */ ,

-- Test hash index build tuplesorting.  Force hash tuplesort using low
-- maintenance_work_mem setting and fillfactor:
SET maintenance_work_mem = '1MB';
RESET maintenance_work_mem;
-- You can/* REPLACED */ ''t do a concurrent index build in a transaction
BEGIN;
COMMIT;

-- But you can do a regular index build in a transaction
BEGIN;
COMMIT;
-- \d concur_heap

-- Temporary tables with concurrent builds and on-commit actions
-- CONCURRENTLY used with CREATE INDEX and DROP INDEX is ignored.
-- PRESERVE ROWS, the default.
CREATE TEMP TABLE concur_temp (f1 int, f2 text)
  ON COMMIT PRESERVE ROWS;
INSERT INTO concur_temp VALUES (1, 'foo'), (2, 'bar');
CREATE INDEX CONCURRENTLY concur_temp_ind ON concur_temp(f1);
DROP INDEX CONCURRENTLY concur_temp_ind;
DROP TABLE concur_temp;
-- ON COMMIT DROP
BEGIN;
CREATE TEMP TABLE concur_temp (f1 int, f2 text)
  ON COMMIT DROP;
INSERT INTO concur_temp VALUES (1, 'foo'), (2, 'bar');
COMMIT;
-- ON COMMIT DELETE ROWS
CREATE TEMP TABLE concur_temp (f1 int, f2 text)
  ON COMMIT DELETE ROWS;
INSERT INTO concur_temp VALUES (1, 'foo'), (2, 'bar');
CREATE INDEX CONCURRENTLY concur_temp_ind ON concur_temp(f1);
DROP INDEX CONCURRENTLY concur_temp_ind;
DROP TABLE concur_temp;				-- works
DROP INDEX CONCURRENTLY IF EXISTS "concur_index2";
BEGIN;
ROLLBACK;

-- successes
DROP INDEX CONCURRENTLY IF EXISTS "concur_index3";

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = ON;

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;

SET enable_indexonlyscan = OFF;

RESET enable_indexonlyscan;

--
-- Check matching of boolean index columns to WHERE conditions and sort keys
--

create temp table boolindex (b bool, i int, unique(b, i), junk float); -- error
-- Cannot run in a transaction block
BEGIN;
ROLLBACK; -- error
-- Cannot run in a transaction block
BEGIN;
ROLLBACK;

-- Check errors
-- Cannot run inside a transaction block
BEGIN;
COMMIT;  -- ditto
-- Warns about catalog relations
REINDEX SCHEMA CONCURRENTLY pg_catalog;

-- Temporary tables and on-commit actions, where CONCURRENTLY is ignored.
-- ON COMMIT PRESERVE ROWS, the default.
CREATE TEMP TABLE concur_temp_tab_1 (c1 int, c2 text)
  ON COMMIT PRESERVE ROWS;
INSERT INTO concur_temp_tab_1 VALUES (1, 'foo'), (2, 'bar');
CREATE INDEX concur_temp_ind_1 ON concur_temp_tab_1(c2);
REINDEX TABLE CONCURRENTLY concur_temp_tab_1;
REINDEX INDEX CONCURRENTLY concur_temp_ind_1;
-- Still fails in transaction blocks
BEGIN;
COMMIT;
-- ON COMMIT DELETE ROWS
CREATE TEMP TABLE concur_temp_tab_2 (c1 int, c2 text)
  ON COMMIT DELETE ROWS;
CREATE INDEX concur_temp_ind_2 ON concur_temp_tab_2(c2);
REINDEX TABLE CONCURRENTLY concur_temp_tab_2;
REINDEX INDEX CONCURRENTLY concur_temp_ind_2;
-- ON COMMIT DROP
BEGIN;
CREATE TEMP TABLE concur_temp_tab_3 (c1 int, c2 text)
  ON COMMIT PRESERVE ROWS;
INSERT INTO concur_temp_tab_3 VALUES (1, 'foo'), (2, 'bar');
CREATE INDEX concur_temp_ind_3 ON concur_temp_tab_3(c2);
COMMIT; -- failure, schema does not exist
CREATE SCHEMA schema_to_reindex;
SET search_path = 'schema_to_reindex';
REINDEX SCHEMA schema_to_reindex;
REINDEX SCHEMA schema_to_reindex;
BEGIN; -- failure, cannot run in a transaction
END;

-- concurrently
REINDEX SCHEMA CONCURRENTLY schema_to_reindex;
-- Permission failures with toast tables and indexes (pg_authid here)
RESET ROLE;

-- Clean up
RESET ROLE;
DROP SCHEMA schema_to_reindex CASCADE;
-- END setup from create_index 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from point 
--
-- POINT
--

-- avoid bit-exact output here because operations may not be bit-exact.
SET extra_float_digits = 0;

-- Test that GiST indexes provide same behavior as sequential scan
CREATE TEMP TABLE point_gist_tbl(f1 point);
INSERT INTO point_gist_tbl SELECT '(0,0)' FROM generate_series(0,1000);
CREATE INDEX point_gist_tbl_index ON point_gist_tbl USING gist (f1);
INSERT INTO point_gist_tbl VALUES ('(0.0000009,0.0000009)');
SET enable_seqscan TO true;
SET enable_indexscan TO false;
SET enable_bitmapscan TO false;
SET enable_seqscan TO false;
SET enable_indexscan TO true;
SET enable_bitmapscan TO true;
RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;
-- END setup from point 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from lseg 
--
-- LSEG
-- Line segments
--

--DROP TABLE LSEG_TBL /* REPLACED */ ,
CREATE TABLE LSEG_TBL (s lseg);

INSERT INTO LSEG_TBL VALUES ('[(1,2),(3,4)]');
INSERT INTO LSEG_TBL VALUES ('(0,0),(6,6)');
INSERT INTO LSEG_TBL VALUES ('10,-10 ,-3,-4');
INSERT INTO LSEG_TBL VALUES ('[-1e6,2e2,3e5, -4e1]');
INSERT INTO LSEG_TBL VALUES (lseg(point(11, 22), point(33,44)));
INSERT INTO LSEG_TBL VALUES ('[(-10,2),(-10,3)]');	-- vertical
INSERT INTO LSEG_TBL VALUES ('[(0,-20),(30,-20)]');	-- horizontal
INSERT INTO LSEG_TBL VALUES ('[(NaN,1),(NaN,90)]');
-- END setup from lseg 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from line 
--
-- LINE
-- Infinite lines
--

--DROP TABLE LINE_TBL /* REPLACED */ ,
CREATE TABLE LINE_TBL (s line);

INSERT INTO LINE_TBL VALUES ('{0,-1,5}');	-- A == 0
INSERT INTO LINE_TBL VALUES ('{1,0,5}');	-- B == 0
INSERT INTO LINE_TBL VALUES ('{0,3,0}');	-- A == C == 0
INSERT INTO LINE_TBL VALUES (' (0,0), (6,6)');
INSERT INTO LINE_TBL VALUES ('10,-10 ,-5,-4');
INSERT INTO LINE_TBL VALUES ('[-1e6,2e2,3e5, -4e1]');

INSERT INTO LINE_TBL VALUES ('{3,NaN,5}');
INSERT INTO LINE_TBL VALUES ('{NaN,NaN,NaN}');

-- horizontal
INSERT INTO LINE_TBL VALUES ('[(1,3),(2,3)]');
-- vertical
INSERT INTO LINE_TBL VALUES (line(point '(3,1)', point '(3,2)'));
-- END setup from line 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from box 
--
-- BOX
--

--
-- box logic
--	     o
-- 3	  o--|X
--	  |  o|
-- 2	+-+-+ |
--	| | | |
-- 1	| o-+-o
--	|   |
-- 0	+---+
--
--	0 1 2 3
--

-- boxes are specified by two points, given by four floats x1,y1,x2,y2


CREATE TABLE BOX_TBL (f1 box);

INSERT INTO BOX_TBL (f1) VALUES ('(2.0,2.0,0.0,0.0)');

INSERT INTO BOX_TBL (f1) VALUES ('(1.0,1.0,3.0,3.0)');

INSERT INTO BOX_TBL (f1) VALUES ('((-8, 2), (-2, -10))');


-- degenerate cases where the box is a line or a point
-- note that lines and points boxes all have zero area
INSERT INTO BOX_TBL (f1) VALUES ('(2.5, 2.5, 2.5,3.5)');

INSERT INTO BOX_TBL (f1) VALUES ('(3.0, 3.0,3.0,3.0)');

--
-- Test the SP-GiST index
--

CREATE TEMPORARY TABLE box_temp (f1 box);

INSERT INTO box_temp
	SELECT box(point(i, i), point(i * 2, i * 2))
	FROM generate_series(1, 50) AS i;

CREATE INDEX box_spgist ON box_temp USING spgist (f1);

INSERT INTO box_temp
	VALUES (NULL),
		   ('(0,0)(0,100)'),
		   ('(-3,4.3333333333)(40,1)'),
		   ('(0,100)(0,infinity)'),
		   ('(-infinity,0)(0,infinity)'),
		   ('(-infinity,-infinity)(infinity,infinity)');

SET enable_seqscan = false;

RESET enable_seqscan;

DROP INDEX box_spgist;

-- get reference results for ORDER BY distance from seq scan
SET enable_seqscan = ON;
SET enable_indexscan = OFF;
SET enable_bitmapscan = OFF;

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = ON;

-- test ORDER BY distance
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;
-- END setup from box 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from path 
--
-- PATH
--

--DROP TABLE PATH_TBL /* REPLACED */ ,

CREATE TABLE PATH_TBL (f1 path);

INSERT INTO PATH_TBL VALUES ('[(1,2),(3,4)]');

INSERT INTO PATH_TBL VALUES (' ( ( 1 , 2 ) , ( 3 , 4 ) ) ');

INSERT INTO PATH_TBL VALUES ('[ (0,0),(3,0),(4,5),(1,6) ]');

INSERT INTO PATH_TBL VALUES ('((1,2) ,(3,4 ))');

INSERT INTO PATH_TBL VALUES ('1,2 ,3,4 ');

INSERT INTO PATH_TBL VALUES (' [1,2,3, 4] ');

INSERT INTO PATH_TBL VALUES ('((10,20))');	-- Only one point

INSERT INTO PATH_TBL VALUES ('[ 11,12,13,14 ]');

INSERT INTO PATH_TBL VALUES ('( 11,12,13,14) ');
-- END setup from path 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from polygon 
--
-- POLYGON
--
-- polygon logic
--

CREATE TABLE POLYGON_TBL(f1 polygon);


INSERT INTO POLYGON_TBL(f1) VALUES ('(2.0,0.0),(2.0,4.0),(0.0,0.0)');

INSERT INTO POLYGON_TBL(f1) VALUES ('(3.0,1.0),(3.0,3.0),(1.0,0.0)');

INSERT INTO POLYGON_TBL(f1) VALUES ('(1,2),(3,4),(5,6),(7,8)');
INSERT INTO POLYGON_TBL(f1) VALUES ('(7,8),(5,6),(3,4),(1,2)'); -- Reverse
INSERT INTO POLYGON_TBL(f1) VALUES ('(1,2),(7,8),(5,6),(3,-4)');

-- degenerate polygons
INSERT INTO POLYGON_TBL(f1) VALUES ('(0.0,0.0)');

INSERT INTO POLYGON_TBL(f1) VALUES ('(0.0,1.0),(0.0,1.0)');

-- get reference results for ORDER BY distance from seq scan
SET enable_seqscan = ON;
SET enable_indexscan = OFF;
SET enable_bitmapscan = OFF;

-- check results from index scan
SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;

-- test ORDER BY distance
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;
-- END setup from polygon 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from circle 
--
-- CIRCLE
--

-- Back off displayed precision a little bit to reduce platform-to-platform
-- variation in results.
SET extra_float_digits = -1;

CREATE TABLE CIRCLE_TBL (f1 circle);

INSERT INTO CIRCLE_TBL VALUES ('<(5,1),3>');

INSERT INTO CIRCLE_TBL VALUES ('((1,2),100)');

INSERT INTO CIRCLE_TBL VALUES (' 1 , 3 , 5 ');

INSERT INTO CIRCLE_TBL VALUES (' ( ( 1 , 2 ) , 3 ) ');

INSERT INTO CIRCLE_TBL VALUES (' ( 100 , 200 ) , 10 ');

INSERT INTO CIRCLE_TBL VALUES (' < ( 100 , 1 ) , 115 > ');

INSERT INTO CIRCLE_TBL VALUES ('<(3,5),0>');	-- Zero radius

INSERT INTO CIRCLE_TBL VALUES ('<(3,5),NaN>');
-- END setup from circle 
SELECT pg_catalog.set_config('search_path', 'public', false);
