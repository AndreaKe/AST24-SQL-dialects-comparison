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

CREATE TABLE person (
	name 		text,
	age			int4,
	location 	point
);
VACUUM ANALYZE person;

CREATE TABLE emp (
	salary 		int4,
	manager 	name
) INHERITS (person);
VACUUM ANALYZE emp;

CREATE TABLE road (
	name		text,
	thepath 	path
);
VACUUM ANALYZE road;
-- END setup from test_setup 
SELECT pg_catalog.set_config('search_path', 'public', false);

CREATE INDEX rix ON road USING btree (name text_ops);

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

CREATE TABLE real_city (
	pop			int4,
	cname		text,
	outline 	path
);
ANALYZE real_city;

CREATE VIEW street AS
   SELECT r.name, r.thepath, c.cname AS cname
   FROM ONLY road r, real_city c
   WHERE c.outline ?# r.thepath;

CREATE VIEW toyemp AS
   SELECT name, age, location, 12*salary AS annualsal
   FROM emp;
COMMENT ON VIEW toyemp IS 'is a view';
COMMENT ON VIEW toyemp IS NULL;

SET search_path TO temp_view_test, public;

CREATE TEMPORARY TABLE temp_table (a int, id int);
-- should be created in temp object schema
CREATE VIEW v1_temp AS SELECT * FROM temp_table;

-- a view should also be temporary if it references a temporary sequence
CREATE SEQUENCE seq1;
CREATE TEMPORARY SEQUENCE seq1_temp;
CREATE VIEW v9 AS SELECT seq1.is_called FROM seq1;
CREATE VIEW v13_temp AS SELECT seq1_temp.is_called FROM seq1_temp;

CREATE SCHEMA testviewschm2;
SET search_path TO testviewschm2, public;
CREATE TEMP TABLE tt (num2 int, value text);
CREATE TEMP TABLE tmptbl (i int, j int);

-- Check that unknown literals are converted to /* REPLACED */ ''text/* REPLACED */ '' in CREATE VIEW,
-- so that we don/* REPLACED */ ''t end up with unknown-type columns.

CREATE VIEW unspecified_types AS
  SELECT 42 as i, 42.5 as num, 'foo' as u, 'foo'::unknown as u2, null as n;

-- This test checks that proper typmods are assigned in a multi-row VALUES

CREATE VIEW tt1 AS
  SELECT * FROM (
    VALUES
       ('abc'::varchar(3), '0123456789', 42, 'abcd'::varchar(4)),
       ('0123456789', 'abc'::varchar(3), 42.12, 'abc'::varchar(4))
  ) vv(a,b,c,d);
DROP VIEW tt1;  -- fail, view has explicit reference to f3

-- We used to have a bug that would allow the above to succeed, posing
-- hazards for later execution of the view.  Check that the internal
-- defenses for those hazards haven/* REPLACED */ ''t bit-rotted, in case some other
-- bug with similar symptoms emerges.
begin;

rollback;  -- fail

-- ... but some bug might let it happen, so check defenses
begin;

rollback;

create view tt19v as
select 'foo'::text = any(array['abc','def','foo']::text[]) c1,
       'foo'::text = any((select array['abc','def','foo']::text[])::text[]) c2;

-- check display of assorted RTE_FUNCTION expressions

create view tt20v as
select * from
  coalesce(1,2) as c,
  collation for ('x'::text) col,
  current_date as d,
  localtimestamp(3) as t,
  cast(1+2 as int4) as i4,
  cast(1+2 as int8) as i8;

-- reverse-listing of various special function syntaxes required by SQL

create view tt201v as
select
  ('2022-12-01'::date + '1 day'::interval) at time zone 'UTC' as atz,
  extract(day from now()) as extr,
  (now(), '1 day'::interval) overlaps
    (current_timestamp(2), '1 day'::interval) as o,
  'foo' is normalized isn,
  'foo' is nfkc normalized isnn,
  normalize('foo') as n,
  normalize('foo', nfkd) as nfkd,
  overlay('foo' placing 'bar' from 2) as ovl,
  overlay('foo' placing 'bar' from 2 for 3) as ovl2,
  position('foo' in 'foobar') as p,
  substring('foo' from 2 for 3) as s,
  substring('foo' similar 'f' escape '#') as ss,
  substring('foo' from 'oo') as ssf,  -- historically-permitted abuse
  trim(' ' from ' foo ') as bt,
  trim(leading ' ' from ' foo ') as lt,
  trim(trailing ' foo ') as rt,
  trim(E'\\000'::bytea from E'\\000Tom\\000'::bytea) as btb,
  trim(leading E'\\000'::bytea from E'\\000Tom\\000'::bytea) as ltb,
  trim(trailing E'\\000'::bytea from E'\\000Tom\\000'::bytea) as rtb,
  CURRENT_DATE as cd,
  (select * from CURRENT_DATE) as cd2,
  CURRENT_TIME as ct,
  (select * from CURRENT_TIME) as ct2,
  CURRENT_TIME (1) as ct3,
  (select * from CURRENT_TIME (1)) as ct4,
  CURRENT_TIMESTAMP as ct5,
  (select * from CURRENT_TIMESTAMP) as ct6,
  CURRENT_TIMESTAMP (1) as ct7,
  (select * from CURRENT_TIMESTAMP (1)) as ct8,
  LOCALTIME as lt1,
  (select * from LOCALTIME) as lt2,
  LOCALTIME (1) as lt3,
  (select * from LOCALTIME (1)) as lt4,
  LOCALTIMESTAMP as lt5,
  (select * from LOCALTIMESTAMP) as lt6,
  LOCALTIMESTAMP (1) as lt7,
  (select * from LOCALTIMESTAMP (1)) as lt8,
  CURRENT_CATALOG as ca,
  (select * from CURRENT_CATALOG) as ca2,
  CURRENT_ROLE as cr,
  (select * from CURRENT_ROLE) as cr2,
  CURRENT_SCHEMA as cs,
  (select * from CURRENT_SCHEMA) as cs2,
  CURRENT_USER as cu,
  (select * from CURRENT_USER) as cu2,
  USER as us,
  (select * from USER) as us2,
  SESSION_USER seu,
  (select * from SESSION_USER) as seu2,
  SYSTEM_USER as su,
  (select * from SYSTEM_USER) as su2;

-- test extraction of FieldSelect field names (get_name_for_var_field)

create view tt24v as
with cte as materialized (select r from (values(1,2),(3,4)) r)
select (r).column2 as col_a, (rr).column2 as col_b from
  cte join (select rr from (values(1,7),(3,8)) rr limit 2) ss
  on (r).column1 = (rr).column1;
create view tt25v as
with cte as materialized (select pg_get_keywords() k)
select (k).word from cte;

-- test pretty-print parenthesization rules, and SubLink deparsing

create view tt26v as
select x + y + z as c1,
       (x * y) + z as c2,
       x + (y * z) as c3,
       (x + y) * z as c4,
       x * (y + z) as c5,
       x + (y + z) as c6,
       x + (y # z) as c7,
       (x > y) AND (y > z OR x > z) as c8,
       (x > y) OR (y > z AND NOT (x > z)) as c9,
       (x,y) <> ALL (values(1,2),(3,4)) as c10,
       (x,y) <= ANY (values(1,2),(3,4)) as c11
from (values(1,2,3)) v(x,y,z);
DROP SCHEMA testviewschm2 CASCADE;
-- END setup from create_view 
SELECT pg_catalog.set_config('search_path', 'public', false);
