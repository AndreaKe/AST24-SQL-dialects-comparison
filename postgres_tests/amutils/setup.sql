-- START setup from test_setup 
--
-- TEST_SETUP --- prepare environment expected by regression test scripts
--

-- directory paths and dlsuffix are passed to us in environment variables
-- \getenv abs_srcdir PG_ABS_SRCDIR
-- \getenv libdir PG_LIBDIR
-- \getenv dlsuffix PG_DLSUFFIX

-- \set regresslib /* REPLACED */PG_LIBDIR '/regress' /* REPLACED */PG_DLSUFFIX

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
CREATE TABLESPACE regress_tblspace LOCATION '';

--
-- These tables have traditionally been referenced by many tests,
-- so create and populate them.  Insert only non-error values here.
-- (Some subsequent tests try to insert erroneous values.  That/* REPLACED */''s okay
-- because the table won/* REPLACED */''t actually change.  Do not change the contents
-- of these tables in later tests, as it may affect other tests.)
--

CREATE TABLE CHAR_TBL(f1 char(4));

INSERT INTO CHAR_TBL (f1) VALUES
  ('a'),
  ('ab'),
  ('abcd'),
  ('abcd    ');
VACUUM CHAR_TBL;

CREATE TABLE FLOAT8_TBL(f1 float8);

INSERT INTO FLOAT8_TBL(f1) VALUES
  ('0.0'),
  ('-34.84'),
  ('-1004.30'),
  ('-1.2345678901234e+200'),
  ('-1.2345678901234e-200');
VACUUM FLOAT8_TBL;

CREATE TABLE INT2_TBL(f1 int2);

INSERT INTO INT2_TBL(f1) VALUES
  ('0   '),
  ('  1234 '),
  ('    -1234'),
  ('32767'),  -- largest and smallest values
  ('-32767');
VACUUM INT2_TBL;

CREATE TABLE INT4_TBL(f1 int4);

INSERT INTO INT4_TBL(f1) VALUES
  ('   0  '),
  ('123456     '),
  ('    -123456'),
  ('2147483647'),  -- largest and smallest values
  ('-2147483647');
VACUUM INT4_TBL;

CREATE TABLE INT8_TBL(q1 int8, q2 int8);

INSERT INTO INT8_TBL VALUES
  ('  123   ','  456'),
  ('123   ','4567890123456789'),
  ('4567890123456789','123'),
  (+4567890123456789,'4567890123456789'),
  ('+4567890123456789','-4567890123456789');
VACUUM INT8_TBL;

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
-- We intentionally don/* REPLACED */''t vacuum point_tbl here /* REPLACED */, geometry depends on that

CREATE TABLE TEXT_TBL (f1 text);

INSERT INTO TEXT_TBL VALUES
  ('doh!'),
  ('hi de ho neighbor');
VACUUM TEXT_TBL;

CREATE TABLE VARCHAR_TBL(f1 varchar(4));

INSERT INTO VARCHAR_TBL (f1) VALUES
  ('a'),
  ('ab'),
  ('abcd'),
  ('abcd    ');
VACUUM VARCHAR_TBL;

CREATE TABLE onek (
	unique1		int4,
	unique2		int4,
	two			int4,
	four		int4,
	ten			int4,
	twenty		int4,
	hundred		int4,
	thousand	int4,
	twothousand	int4,
	fivethous	int4,
	tenthous	int4,
	odd			int4,
	even		int4,
	stringu1	name,
	stringu2	name,
	string4		name
);

-- \set filename /* REPLACED */PG_ABS_SRCDIR '/data/onek.data'
COPY onek FROM /* REPLACED */PG_ABS_SRCDIR '/data/onek.data';
VACUUM ANALYZE onek;

CREATE TABLE onek2 AS SELECT * FROM onek;
VACUUM ANALYZE onek2;

CREATE TABLE tenk1 (
	unique1		int4,
	unique2		int4,
	two			int4,
	four		int4,
	ten			int4,
	twenty		int4,
	hundred		int4,
	thousand	int4,
	twothousand	int4,
	fivethous	int4,
	tenthous	int4,
	odd			int4,
	even		int4,
	stringu1	name,
	stringu2	name,
	string4		name
);

-- \set filename /* REPLACED */PG_ABS_SRCDIR '/data/tenk.data'
COPY tenk1 FROM /* REPLACED */PG_ABS_SRCDIR '/data/tenk.data';
VACUUM ANALYZE tenk1;

CREATE TABLE tenk2 AS SELECT * FROM tenk1;
VACUUM ANALYZE tenk2;

CREATE TABLE person (
	name 		text,
	age			int4,
	location 	point
);

-- \set filename /* REPLACED */PG_ABS_SRCDIR '/data/person.data'
COPY person FROM /* REPLACED */PG_ABS_SRCDIR '/data/person.data';
VACUUM ANALYZE person;

CREATE TABLE emp (
	salary 		int4,
	manager 	name
) INHERITS (person);

-- \set filename /* REPLACED */PG_ABS_SRCDIR '/data/emp.data'
COPY emp FROM /* REPLACED */PG_ABS_SRCDIR '/data/emp.data';
VACUUM ANALYZE emp;

CREATE TABLE student (
	gpa 		float8
) INHERITS (person);

-- \set filename /* REPLACED */PG_ABS_SRCDIR '/data/student.data'
COPY student FROM /* REPLACED */PG_ABS_SRCDIR '/data/student.data';
VACUUM ANALYZE student;

CREATE TABLE stud_emp (
	percent 	int4
) INHERITS (emp, student);

-- \set filename /* REPLACED */PG_ABS_SRCDIR '/data/stud_emp.data'
COPY stud_emp FROM /* REPLACED */PG_ABS_SRCDIR '/data/stud_emp.data';
VACUUM ANALYZE stud_emp;

CREATE TABLE road (
	name		text,
	thepath 	path
);

-- \set filename /* REPLACED */PG_ABS_SRCDIR '/data/streets.data'
COPY road FROM /* REPLACED */PG_ABS_SRCDIR '/data/streets.data';
VACUUM ANALYZE road;

CREATE TABLE ihighway () INHERITS (road);

INSERT INTO ihighway
   SELECT *
   FROM ONLY road
   WHERE name ~ 'I- .*';
VACUUM ANALYZE ihighway;

CREATE TABLE shighway (
	surface		text
) INHERITS (road);

INSERT INTO shighway
   SELECT *, 'asphalt'
   FROM ONLY road
   WHERE name ~ 'State Hwy.*';
VACUUM ANALYZE shighway;

--
-- We must have some enum type in the database for opr_sanity and type_sanity.
--

create type stoplight as enum ('red', 'yellow', 'green');

--
-- Also create some non-built-in range types.
--

create type float8range as range (subtype = float8, subtype_diff = float8mi);

create type textrange as range (subtype = text, collation = "C");

--
-- Create some C functions that will be used by various tests.
--

CREATE FUNCTION binary_coercible(oid, oid)
    RETURNS bool
    AS /* REPLACED */PG_LIBDIR '/regress' PG_DLSUFFIX, 'binary_coercible'
    LANGUAGE C STRICT STABLE PARALLEL SAFE;

CREATE FUNCTION ttdummy ()
    RETURNS trigger
    AS /* REPLACED */PG_LIBDIR '/regress' PG_DLSUFFIX
    LANGUAGE C;

-- Use hand-rolled hash functions and operator classes to get predictable
-- result on different machines.  The hash function for int4 simply returns
-- the sum of the values passed to it and the one for text returns the length
-- of the non-empty string value passed to it or 0.

create function part_hashint4_noop(value int4, seed int8)
    returns int8 as $$
    select value + seed;
    $$ language sql strict immutable parallel safe;

create operator class part_test_int4_ops for type int4 using hash as
    operator 1 =,
    function 2 part_hashint4_noop(int4, int8);

create function part_hashtext_length(value text, seed int8)
    returns int8 as $$
    select length(coalesce(value, ''))::int8
    $$ language sql strict immutable parallel safe;

create operator class part_test_text_ops for type text using hash as
    operator 1 =,
    function 2 part_hashtext_length(text, int8);

--
-- These functions are used in tests that used to use md5(), which we now
-- mostly avoid so that the tests will pass in FIPS mode.
--

create function fipshash(bytea)
    returns text
    strict immutable parallel safe leakproof
    return substr(encode(sha256($1), 'hex'), 1, 32);

create function fipshash(text)
    returns text
    strict immutable parallel safe leakproof
    return substr(encode(sha256($1::bytea), 'hex'), 1, 32);
-- END setup from test_setup 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from create_index 
--
-- CREATE_INDEX
-- Create ancillary data structures (i.e. indices)
--

-- directory paths are passed to us in environment variables
-- \getenv abs_srcdir PG_ABS_SRCDIR

--
-- BTREE
--
CREATE INDEX onek_unique1 ON onek USING btree(unique1 int4_ops);

CREATE INDEX IF NOT EXISTS onek_unique1 ON onek USING btree(unique1 int4_ops);

CREATE INDEX IF NOT EXISTS ON onek USING btree(unique1 int4_ops);

CREATE INDEX onek_unique2 ON onek USING btree(unique2 int4_ops);

CREATE INDEX onek_hundred ON onek USING btree(hundred int4_ops);

CREATE INDEX onek_stringu1 ON onek USING btree(stringu1 name_ops);

CREATE INDEX tenk1_unique1 ON tenk1 USING btree(unique1 int4_ops);

CREATE INDEX tenk1_unique2 ON tenk1 USING btree(unique2 int4_ops);

CREATE INDEX tenk1_hundred ON tenk1 USING btree(hundred int4_ops);

CREATE INDEX tenk1_thous_tenthous ON tenk1 (thousand, tenthous);

CREATE INDEX tenk2_unique1 ON tenk2 USING btree(unique1 int4_ops);

CREATE INDEX tenk2_unique2 ON tenk2 USING btree(unique2 int4_ops);

CREATE INDEX tenk2_hundred ON tenk2 USING btree(hundred int4_ops);

CREATE INDEX rix ON road USING btree (name text_ops);

CREATE INDEX iix ON ihighway USING btree (name text_ops);

CREATE INDEX six ON shighway USING btree (name text_ops);

-- test comments
COMMENT ON INDEX six_wrong IS 'bad index';
COMMENT ON INDEX six IS 'good index';
COMMENT ON INDEX six IS NULL;

--
-- BTREE partial indices
--
CREATE INDEX onek2_u1_prtl ON onek2 USING btree(unique1 int4_ops)
	where unique1 < 20 or unique1 > 980;

CREATE INDEX onek2_u2_prtl ON onek2 USING btree(unique2 int4_ops)
	where stringu1 < 'B';

CREATE INDEX onek2_stu1_prtl ON onek2 USING btree(stringu1 name_ops)
	where onek2.stringu1 >= 'J' and onek2.stringu1 < 'K';

--
-- GiST (rtree-equivalent opclasses only)
--

CREATE TABLE slow_emp4000 (
	home_base	 box
);

CREATE TABLE fast_emp4000 (
	home_base	 box
);

-- \set filename /* REPLACED */PG_ABS_SRCDIR '/data/rect.data'
COPY slow_emp4000 FROM /* REPLACED */PG_ABS_SRCDIR '/data/rect.data';

INSERT INTO fast_emp4000 SELECT * FROM slow_emp4000;

ANALYZE slow_emp4000;
ANALYZE fast_emp4000;

CREATE INDEX grect2ind ON fast_emp4000 USING gist (home_base);

-- we want to work with a point_tbl that includes a null
CREATE TEMP TABLE point_tbl AS SELECT * FROM public.point_tbl;
INSERT INTO POINT_TBL(f1) VALUES (NULL);

CREATE INDEX gpointind ON point_tbl USING gist (f1);

CREATE TEMP TABLE gpolygon_tbl AS
    SELECT polygon(home_base) AS f1 FROM slow_emp4000;
INSERT INTO gpolygon_tbl VALUES ( '(1000,0,0,1000)' );
INSERT INTO gpolygon_tbl VALUES ( '(0,1000,1000,1000)' );

CREATE TEMP TABLE gcircle_tbl AS
    SELECT circle(home_base) AS f1 FROM slow_emp4000;

CREATE INDEX ggpolygonind ON gpolygon_tbl USING gist (f1);

CREATE INDEX ggcircleind ON gcircle_tbl USING gist (f1);

--
-- Test GiST indexes
--

-- get non-indexed results for comparison purposes

SET enable_seqscan = ON;
SET enable_indexscan = OFF;
SET enable_bitmapscan = OFF;

SELECT * FROM fast_emp4000
    WHERE home_base <@ '(200,200),(2000,1000)'::box
    ORDER BY (home_base[0])[0];

SELECT count(*) FROM fast_emp4000 WHERE home_base && '(1000,1000,0,0)'::box;

SELECT count(*) FROM fast_emp4000 WHERE home_base IS NULL;

SELECT count(*) FROM gpolygon_tbl WHERE f1 && '(1000,1000,0,0)'::polygon;

SELECT count(*) FROM gcircle_tbl WHERE f1 && '<(500,500),500>'::circle;

SELECT count(*) FROM point_tbl WHERE f1 <@ box '(0,0,100,100)';

SELECT count(*) FROM point_tbl WHERE box '(0,0,100,100)' @> f1;

SELECT count(*) FROM point_tbl WHERE f1 <@ polygon '(0,0),(0,100),(100,100),(50,50),(100,0),(0,0)';

SELECT count(*) FROM point_tbl WHERE f1 <@ circle '<(50,50),50>';

SELECT count(*) FROM point_tbl p WHERE p.f1 << '(0.0, 0.0)';

SELECT count(*) FROM point_tbl p WHERE p.f1 >> '(0.0, 0.0)';

SELECT count(*) FROM point_tbl p WHERE p.f1 <<| '(0.0, 0.0)';

SELECT count(*) FROM point_tbl p WHERE p.f1 |>> '(0.0, 0.0)';

SELECT count(*) FROM point_tbl p WHERE p.f1 ~= '(-5, -12)';

SELECT * FROM point_tbl ORDER BY f1 <-> '0,1';

SELECT * FROM point_tbl WHERE f1 IS NULL;

SELECT * FROM point_tbl WHERE f1 IS NOT NULL ORDER BY f1 <-> '0,1';

SELECT * FROM point_tbl WHERE f1 <@ '(-10,-10),(10,10)':: box ORDER BY f1 <-> '0,1';

SELECT * FROM gpolygon_tbl ORDER BY f1 <-> '(0,0)'::point LIMIT 10;

SELECT circle_center(f1), round(radius(f1)) as radius FROM gcircle_tbl ORDER BY f1 <-> '(200,300)'::point LIMIT 10;

-- Now check the results from plain indexscan
SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

EXPLAIN (COSTS OFF)
SELECT * FROM fast_emp4000
    WHERE home_base <@ '(200,200),(2000,1000)'::box
    ORDER BY (home_base[0])[0];
SELECT * FROM fast_emp4000
    WHERE home_base <@ '(200,200),(2000,1000)'::box
    ORDER BY (home_base[0])[0];

EXPLAIN (COSTS OFF)
SELECT count(*) FROM fast_emp4000 WHERE home_base && '(1000,1000,0,0)'::box;
SELECT count(*) FROM fast_emp4000 WHERE home_base && '(1000,1000,0,0)'::box;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM fast_emp4000 WHERE home_base IS NULL;
SELECT count(*) FROM fast_emp4000 WHERE home_base IS NULL;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM gpolygon_tbl WHERE f1 && '(1000,1000,0,0)'::polygon;
SELECT count(*) FROM gpolygon_tbl WHERE f1 && '(1000,1000,0,0)'::polygon;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM gcircle_tbl WHERE f1 && '<(500,500),500>'::circle;
SELECT count(*) FROM gcircle_tbl WHERE f1 && '<(500,500),500>'::circle;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM point_tbl WHERE f1 <@ box '(0,0,100,100)';
SELECT count(*) FROM point_tbl WHERE f1 <@ box '(0,0,100,100)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM point_tbl WHERE box '(0,0,100,100)' @> f1;
SELECT count(*) FROM point_tbl WHERE box '(0,0,100,100)' @> f1;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM point_tbl WHERE f1 <@ polygon '(0,0),(0,100),(100,100),(50,50),(100,0),(0,0)';
SELECT count(*) FROM point_tbl WHERE f1 <@ polygon '(0,0),(0,100),(100,100),(50,50),(100,0),(0,0)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM point_tbl WHERE f1 <@ circle '<(50,50),50>';
SELECT count(*) FROM point_tbl WHERE f1 <@ circle '<(50,50),50>';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM point_tbl p WHERE p.f1 << '(0.0, 0.0)';
SELECT count(*) FROM point_tbl p WHERE p.f1 << '(0.0, 0.0)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM point_tbl p WHERE p.f1 >> '(0.0, 0.0)';
SELECT count(*) FROM point_tbl p WHERE p.f1 >> '(0.0, 0.0)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM point_tbl p WHERE p.f1 <<| '(0.0, 0.0)';
SELECT count(*) FROM point_tbl p WHERE p.f1 <<| '(0.0, 0.0)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM point_tbl p WHERE p.f1 |>> '(0.0, 0.0)';
SELECT count(*) FROM point_tbl p WHERE p.f1 |>> '(0.0, 0.0)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM point_tbl p WHERE p.f1 ~= '(-5, -12)';
SELECT count(*) FROM point_tbl p WHERE p.f1 ~= '(-5, -12)';

EXPLAIN (COSTS OFF)
SELECT * FROM point_tbl ORDER BY f1 <-> '0,1';
SELECT * FROM point_tbl ORDER BY f1 <-> '0,1';

EXPLAIN (COSTS OFF)
SELECT * FROM point_tbl WHERE f1 IS NULL;
SELECT * FROM point_tbl WHERE f1 IS NULL;

EXPLAIN (COSTS OFF)
SELECT * FROM point_tbl WHERE f1 IS NOT NULL ORDER BY f1 <-> '0,1';
SELECT * FROM point_tbl WHERE f1 IS NOT NULL ORDER BY f1 <-> '0,1';

EXPLAIN (COSTS OFF)
SELECT * FROM point_tbl WHERE f1 <@ '(-10,-10),(10,10)':: box ORDER BY f1 <-> '0,1';
SELECT * FROM point_tbl WHERE f1 <@ '(-10,-10),(10,10)':: box ORDER BY f1 <-> '0,1';

EXPLAIN (COSTS OFF)
SELECT * FROM gpolygon_tbl ORDER BY f1 <-> '(0,0)'::point LIMIT 10;
SELECT * FROM gpolygon_tbl ORDER BY f1 <-> '(0,0)'::point LIMIT 10;

EXPLAIN (COSTS OFF)
SELECT circle_center(f1), round(radius(f1)) as radius FROM gcircle_tbl ORDER BY f1 <-> '(200,300)'::point LIMIT 10;
SELECT circle_center(f1), round(radius(f1)) as radius FROM gcircle_tbl ORDER BY f1 <-> '(200,300)'::point LIMIT 10;

EXPLAIN (COSTS OFF)
SELECT point(x,x), (SELECT f1 FROM gpolygon_tbl ORDER BY f1 <-> point(x,x) LIMIT 1) as c FROM generate_series(0,10,1) x;
SELECT point(x,x), (SELECT f1 FROM gpolygon_tbl ORDER BY f1 <-> point(x,x) LIMIT 1) as c FROM generate_series(0,10,1) x;

-- Now check the results from bitmap indexscan
SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;

EXPLAIN (COSTS OFF)
SELECT * FROM point_tbl WHERE f1 <@ '(-10,-10),(10,10)':: box ORDER BY f1 <-> '0,1';
SELECT * FROM point_tbl WHERE f1 <@ '(-10,-10),(10,10)':: box ORDER BY f1 <-> '0,1';

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;

--
-- GIN over int[] and text[]
--
-- Note: GIN currently supports only bitmap scans, not plain indexscans
--

CREATE TABLE array_index_op_test (
	seqno		int4,
	i			int4[],
	t			text[]
);

-- \set filename /* REPLACED */PG_ABS_SRCDIR '/data/array.data'
COPY array_index_op_test FROM /* REPLACED */PG_ABS_SRCDIR '/data/array.data';
ANALYZE array_index_op_test;

SELECT * FROM array_index_op_test WHERE i = '{NULL}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{NULL}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{NULL}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i <@ '{NULL}' ORDER BY seqno;

SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;

CREATE INDEX intarrayidx ON array_index_op_test USING gin (i);

explain (costs off)
SELECT * FROM array_index_op_test WHERE i @> '{32}' ORDER BY seqno;

SELECT * FROM array_index_op_test WHERE i @> '{32}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{32}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{17}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{17}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{32,17}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{32,17}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i <@ '{38,34,32,89}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i = '{47,77}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i = '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i <@ '{}' ORDER BY seqno;

CREATE INDEX textarrayidx ON array_index_op_test USING gin (t);

explain (costs off)
SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAA72908}' ORDER BY seqno;

SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAA72908}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t && '{AAAAAAAA72908}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t && '{AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAA72908,AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t && '{AAAAAAAA72908,AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t <@ '{AAAAAAAA72908,AAAAAAAAAAAAAAAAAAA17075,AA88409,AAAAAAAAAAAAAAAAAA36842,AAAAAAA48038,AAAAAAAAAAAAAA10611}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t = '{AAAAAAAAAA646,A87088}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t = '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t @> '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t && '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t <@ '{}' ORDER BY seqno;

-- And try it with a multicolumn GIN index

DROP INDEX intarrayidx, textarrayidx;

CREATE INDEX botharrayidx ON array_index_op_test USING gin (i, t);

SELECT * FROM array_index_op_test WHERE i @> '{32}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{32}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAA80240}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t && '{AAAAAAA80240}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{32}' AND t && '{AAAAAAA80240}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{32}' AND t @> '{AAAAAAA80240}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t = '{}' ORDER BY seqno;

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;

--
-- Try a GIN index with a lot of items with same key. (GIN creates a posting
-- tree when there are enough duplicates)
--
CREATE TABLE array_gin_test (a int[]);

INSERT INTO array_gin_test SELECT ARRAY[1, g%5, g] FROM generate_series(1, 10000) g;

CREATE INDEX array_gin_test_idx ON array_gin_test USING gin (a);

SELECT COUNT(*) FROM array_gin_test WHERE a @> '{2}';

DROP TABLE array_gin_test;

--
-- Test GIN index/* REPLACED */''s reloptions
--
CREATE INDEX gin_relopts_test ON array_index_op_test USING gin (i)
  WITH (FASTUPDATE=on, GIN_PENDING_LIST_LIMIT=128);
-- \d+ gin_relopts_test

--
-- HASH
--
CREATE UNLOGGED TABLE unlogged_hash_table (id int4);
CREATE INDEX unlogged_hash_index ON unlogged_hash_table USING hash (id int4_ops);
DROP TABLE unlogged_hash_table;

-- CREATE INDEX hash_ovfl_index ON hash_ovfl_heap USING hash (x int4_ops) /* REPLACED */,

-- Test hash index build tuplesorting.  Force hash tuplesort using low
-- maintenance_work_mem setting and fillfactor:
SET maintenance_work_mem = '1MB';
CREATE INDEX hash_tuplesort_idx ON tenk1 USING hash (stringu1 name_ops) WITH (fillfactor = 10);
EXPLAIN (COSTS OFF)
SELECT count(*) FROM tenk1 WHERE stringu1 = 'TVAAAA';
SELECT count(*) FROM tenk1 WHERE stringu1 = 'TVAAAA';
DROP INDEX hash_tuplesort_idx;
RESET maintenance_work_mem;


--
-- Test unique null behavior
--
CREATE TABLE unique_tbl (i int, t text);

CREATE UNIQUE INDEX unique_idx1 ON unique_tbl (i) NULLS DISTINCT;
CREATE UNIQUE INDEX unique_idx2 ON unique_tbl (i) NULLS NOT DISTINCT;

INSERT INTO unique_tbl VALUES (1, 'one');
INSERT INTO unique_tbl VALUES (2, 'two');
INSERT INTO unique_tbl VALUES (3, 'three');
INSERT INTO unique_tbl VALUES (4, 'four');
INSERT INTO unique_tbl VALUES (5, 'one');
INSERT INTO unique_tbl (t) VALUES ('six');
INSERT INTO unique_tbl (t) VALUES ('seven');  -- error from unique_idx2

DROP INDEX unique_idx1, unique_idx2;

INSERT INTO unique_tbl (t) VALUES ('seven');

-- build indexes on filled table
CREATE UNIQUE INDEX unique_idx3 ON unique_tbl (i) NULLS DISTINCT;  -- ok
CREATE UNIQUE INDEX unique_idx4 ON unique_tbl (i) NULLS NOT DISTINCT;  -- error

DELETE FROM unique_tbl WHERE t = 'seven';

CREATE UNIQUE INDEX unique_idx4 ON unique_tbl (i) NULLS NOT DISTINCT;  -- ok now

-- \d unique_tbl
-- \d unique_idx3
-- \d unique_idx4
SELECT pg_get_indexdef('unique_idx3'::regclass);
SELECT pg_get_indexdef('unique_idx4'::regclass);

DROP TABLE unique_tbl;


--
-- Test functional index
--
CREATE TABLE func_index_heap (f1 text, f2 text);
CREATE UNIQUE INDEX func_index_index on func_index_heap (textcat(f1,f2));

INSERT INTO func_index_heap VALUES('ABC','DEF');
INSERT INTO func_index_heap VALUES('AB','CDEFG');
INSERT INTO func_index_heap VALUES('QWE','RTY');
-- this should fail because of unique index:
INSERT INTO func_index_heap VALUES('ABCD', 'EF');
-- but this shouldn/* REPLACED */''t:
INSERT INTO func_index_heap VALUES('QWERTY');

-- while we/* REPLACED */''re here, see that the metadata looks sane
-- \d func_index_heap
-- \d func_index_index


--
-- Same test, expressional index
--
DROP TABLE func_index_heap;
CREATE TABLE func_index_heap (f1 text, f2 text);
CREATE UNIQUE INDEX func_index_index on func_index_heap ((f1 || f2) text_ops);

INSERT INTO func_index_heap VALUES('ABC','DEF');
INSERT INTO func_index_heap VALUES('AB','CDEFG');
INSERT INTO func_index_heap VALUES('QWE','RTY');
-- this should fail because of unique index:
INSERT INTO func_index_heap VALUES('ABCD', 'EF');
-- but this shouldn/* REPLACED */''t:
INSERT INTO func_index_heap VALUES('QWERTY');

-- while we/* REPLACED */''re here, see that the metadata looks sane
-- \d func_index_heap
-- \d func_index_index

-- this should fail because of unsafe column type (anonymous record)
create index on func_index_heap ((f1 || f2), (row(f1, f2)));


--
-- Test unique index with included columns
--
CREATE TABLE covering_index_heap (f1 int, f2 int, f3 text);
CREATE UNIQUE INDEX covering_index_index on covering_index_heap (f1,f2) INCLUDE(f3);

INSERT INTO covering_index_heap VALUES(1,1,'AAA');
INSERT INTO covering_index_heap VALUES(1,2,'AAA');
-- this should fail because of unique index on f1,f2:
INSERT INTO covering_index_heap VALUES(1,2,'BBB');
-- and this shouldn/* REPLACED */''t:
INSERT INTO covering_index_heap VALUES(1,4,'AAA');
-- Try to build index on table that already contains data
CREATE UNIQUE INDEX covering_pkey on covering_index_heap (f1,f2) INCLUDE(f3);
-- Try to use existing covering index as primary key
ALTER TABLE covering_index_heap ADD CONSTRAINT covering_pkey PRIMARY KEY USING INDEX
covering_pkey;
DROP TABLE covering_index_heap;

--
-- Try some concurrent index builds
--
-- Unfortunately this only tests about half the code paths because there are
-- no concurrent updates happening to the table at the same time.

CREATE TABLE concur_heap (f1 text, f2 text);
-- empty table
CREATE INDEX CONCURRENTLY concur_index1 ON concur_heap(f2,f1);
CREATE INDEX CONCURRENTLY IF NOT EXISTS concur_index1 ON concur_heap(f2,f1);
INSERT INTO concur_heap VALUES  ('a','b');
INSERT INTO concur_heap VALUES  ('b','b');
-- unique index
CREATE UNIQUE INDEX CONCURRENTLY concur_index2 ON concur_heap(f1);
CREATE UNIQUE INDEX CONCURRENTLY IF NOT EXISTS concur_index2 ON concur_heap(f1);
-- check if constraint is set up properly to be enforced
INSERT INTO concur_heap VALUES ('b','x');
-- check if constraint is enforced properly at build time
CREATE UNIQUE INDEX CONCURRENTLY concur_index3 ON concur_heap(f2);
-- test that expression indexes and partial indexes work concurrently
CREATE INDEX CONCURRENTLY concur_index4 on concur_heap(f2) WHERE f1='a';
CREATE INDEX CONCURRENTLY concur_index5 on concur_heap(f2) WHERE f1='x';
-- here we also check that you can default the index name
CREATE INDEX CONCURRENTLY on concur_heap((f2||f1));
-- You can/* REPLACED */''t do a concurrent index build in a transaction
BEGIN;
CREATE INDEX CONCURRENTLY concur_index7 ON concur_heap(f1);
COMMIT;
-- test where predicate is able to do a transactional update during
-- a concurrent build before switching pg_index state flags.
CREATE FUNCTION predicate_stable() RETURNS bool IMMUTABLE
LANGUAGE plpgsql AS $$
BEGIN
  EXECUTE 'SELECT txid_current()';
  RETURN true;
END; $$;
CREATE INDEX CONCURRENTLY concur_index8 ON concur_heap (f1)
  WHERE predicate_stable();
DROP INDEX concur_index8;
DROP FUNCTION predicate_stable();

-- But you can do a regular index build in a transaction
BEGIN;
CREATE INDEX std_index on concur_heap(f2);
COMMIT;

-- Failed builds are left invalid by VACUUM FULL, fixed by REINDEX
VACUUM FULL concur_heap;
REINDEX TABLE concur_heap;
DELETE FROM concur_heap WHERE f1 = 'b';
VACUUM FULL concur_heap;
-- \d concur_heap
REINDEX TABLE concur_heap;
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
-- Fails when running in a transaction.
CREATE INDEX CONCURRENTLY concur_temp_ind ON concur_temp(f1);
COMMIT;
-- ON COMMIT DELETE ROWS
CREATE TEMP TABLE concur_temp (f1 int, f2 text)
  ON COMMIT DELETE ROWS;
INSERT INTO concur_temp VALUES (1, 'foo'), (2, 'bar');
CREATE INDEX CONCURRENTLY concur_temp_ind ON concur_temp(f1);
DROP INDEX CONCURRENTLY concur_temp_ind;
DROP TABLE concur_temp;

--
-- Try some concurrent index drops
--
DROP INDEX CONCURRENTLY "concur_index2";				-- works
DROP INDEX CONCURRENTLY IF EXISTS "concur_index2";		-- notice

-- failures
DROP INDEX CONCURRENTLY "concur_index2", "concur_index3";
BEGIN;
DROP INDEX CONCURRENTLY "concur_index5";
ROLLBACK;

-- successes
DROP INDEX CONCURRENTLY IF EXISTS "concur_index3";
DROP INDEX CONCURRENTLY "concur_index4";
DROP INDEX CONCURRENTLY "concur_index5";
DROP INDEX CONCURRENTLY "concur_index1";
DROP INDEX CONCURRENTLY "concur_heap_expr_idx";

-- \d concur_heap

DROP TABLE concur_heap;

--
-- Test ADD CONSTRAINT USING INDEX
--

CREATE TABLE cwi_test( a int , b varchar(10), c char);

-- add some data so that all tests have something to work with.

INSERT INTO cwi_test VALUES(1, 2), (3, 4), (5, 6);

CREATE UNIQUE INDEX cwi_uniq_idx ON cwi_test(a , b);
ALTER TABLE cwi_test ADD primary key USING INDEX cwi_uniq_idx;

-- \d cwi_test
-- \d cwi_uniq_idx

CREATE UNIQUE INDEX cwi_uniq2_idx ON cwi_test(b , a);
ALTER TABLE cwi_test DROP CONSTRAINT cwi_uniq_idx,
	ADD CONSTRAINT cwi_replaced_pkey PRIMARY KEY
		USING INDEX cwi_uniq2_idx;

-- \d cwi_test
-- \d cwi_replaced_pkey

DROP INDEX cwi_replaced_pkey;	-- Should fail /* REPLACED */, a constraint depends on it

-- Check that non-default index options are rejected
CREATE UNIQUE INDEX cwi_uniq3_idx ON cwi_test(a desc);
ALTER TABLE cwi_test ADD UNIQUE USING INDEX cwi_uniq3_idx;  -- fail
CREATE UNIQUE INDEX cwi_uniq4_idx ON cwi_test(b collate "POSIX");
ALTER TABLE cwi_test ADD UNIQUE USING INDEX cwi_uniq4_idx;  -- fail

DROP TABLE cwi_test;

-- ADD CONSTRAINT USING INDEX is forbidden on partitioned tables
CREATE TABLE cwi_test(a int) PARTITION BY hash (a);
create unique index on cwi_test (a);
alter table cwi_test add primary key using index cwi_test_a_idx ;
DROP TABLE cwi_test;

-- PRIMARY KEY constraint cannot be backed by a NULLS NOT DISTINCT index
CREATE TABLE cwi_test(a int, b int);
CREATE UNIQUE INDEX cwi_a_nnd ON cwi_test (a) NULLS NOT DISTINCT;
ALTER TABLE cwi_test ADD PRIMARY KEY USING INDEX cwi_a_nnd;
DROP TABLE cwi_test;

--
-- Check handling of indexes on system columns
--
CREATE TABLE syscol_table (a INT);

-- System columns cannot be indexed
CREATE INDEX ON syscolcol_table (ctid);

-- nor used in expressions
CREATE INDEX ON syscol_table ((ctid >= '(1000,0)'));

-- nor used in predicates
CREATE INDEX ON syscol_table (a) WHERE ctid >= '(1000,0)';

DROP TABLE syscol_table;

--
-- Tests for IS NULL/IS NOT NULL with b-tree indexes
--

CREATE TABLE onek_with_null AS SELECT unique1, unique2 FROM onek;
INSERT INTO onek_with_null (unique1,unique2) VALUES (NULL, -1), (NULL, NULL);
CREATE UNIQUE INDEX onek_nulltest ON onek_with_null (unique2,unique1);

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = ON;

SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique2 IS NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NOT NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique2 IS NOT NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NOT NULL AND unique1 > 500;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique1 > 500;

DROP INDEX onek_nulltest;

CREATE UNIQUE INDEX onek_nulltest ON onek_with_null (unique2 desc,unique1);

SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique2 IS NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NOT NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique2 IS NOT NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NOT NULL AND unique1 > 500;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique1 > 500;

DROP INDEX onek_nulltest;

CREATE UNIQUE INDEX onek_nulltest ON onek_with_null (unique2 desc nulls last,unique1);

SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique2 IS NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NOT NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique2 IS NOT NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NOT NULL AND unique1 > 500;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique1 > 500;

DROP INDEX onek_nulltest;

CREATE UNIQUE INDEX onek_nulltest ON onek_with_null (unique2  nulls first,unique1);

SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique2 IS NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NOT NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique2 IS NOT NULL;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NOT NULL AND unique1 > 500;
SELECT count(*) FROM onek_with_null WHERE unique1 IS NULL AND unique1 > 500;

DROP INDEX onek_nulltest;

-- Check initial-positioning logic too

CREATE UNIQUE INDEX onek_nulltest ON onek_with_null (unique2);

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

SELECT unique1, unique2 FROM onek_with_null
  ORDER BY unique2 LIMIT 2;
SELECT unique1, unique2 FROM onek_with_null WHERE unique2 >= -1
  ORDER BY unique2 LIMIT 2;
SELECT unique1, unique2 FROM onek_with_null WHERE unique2 >= 0
  ORDER BY unique2 LIMIT 2;

SELECT unique1, unique2 FROM onek_with_null
  ORDER BY unique2 DESC LIMIT 2;
SELECT unique1, unique2 FROM onek_with_null WHERE unique2 >= -1
  ORDER BY unique2 DESC LIMIT 2;
SELECT unique1, unique2 FROM onek_with_null WHERE unique2 < 999
  ORDER BY unique2 DESC LIMIT 2;

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;

DROP TABLE onek_with_null;

--
-- Check bitmap index path planning
--

EXPLAIN (COSTS OFF)
SELECT * FROM tenk1
  WHERE thousand = 42 AND (tenthous = 1 OR tenthous = 3 OR tenthous = 42);
SELECT * FROM tenk1
  WHERE thousand = 42 AND (tenthous = 1 OR tenthous = 3 OR tenthous = 42);

EXPLAIN (COSTS OFF)
SELECT count(*) FROM tenk1
  WHERE hundred = 42 AND (thousand = 42 OR thousand = 99);
SELECT count(*) FROM tenk1
  WHERE hundred = 42 AND (thousand = 42 OR thousand = 99);

--
-- Check behavior with duplicate index column contents
--

CREATE TABLE dupindexcols AS
  SELECT unique1 as id, stringu2::text as f1 FROM tenk1;
CREATE INDEX dupindexcols_i ON dupindexcols (f1, id, f1 text_pattern_ops);
ANALYZE dupindexcols;

EXPLAIN (COSTS OFF)
  SELECT count(*) FROM dupindexcols
    WHERE f1 BETWEEN 'WA' AND 'ZZZ' and id < 1000 and f1 ~<~ 'YX';
SELECT count(*) FROM dupindexcols
  WHERE f1 BETWEEN 'WA' AND 'ZZZ' and id < 1000 and f1 ~<~ 'YX';

--
-- Check ordering of =ANY indexqual results (bug in 9.2.0)
--

explain (costs off)
SELECT unique1 FROM tenk1
WHERE unique1 IN (1,42,7)
ORDER BY unique1;

SELECT unique1 FROM tenk1
WHERE unique1 IN (1,42,7)
ORDER BY unique1;

explain (costs off)
SELECT thousand, tenthous FROM tenk1
WHERE thousand < 2 AND tenthous IN (1001,3000)
ORDER BY thousand;

SELECT thousand, tenthous FROM tenk1
WHERE thousand < 2 AND tenthous IN (1001,3000)
ORDER BY thousand;

SET enable_indexonlyscan = OFF;

explain (costs off)
SELECT thousand, tenthous FROM tenk1
WHERE thousand < 2 AND tenthous IN (1001,3000)
ORDER BY thousand;

SELECT thousand, tenthous FROM tenk1
WHERE thousand < 2 AND tenthous IN (1001,3000)
ORDER BY thousand;

RESET enable_indexonlyscan;

--
-- Check elimination of constant-NULL subexpressions
--

explain (costs off)
  select * from tenk1 where (thousand, tenthous) in ((1,1001), (null,null));

--
-- Check matching of boolean index columns to WHERE conditions and sort keys
--

create temp table boolindex (b bool, i int, unique(b, i), junk float);

explain (costs off)
  select * from boolindex order by b, i limit 10;
explain (costs off)
  select * from boolindex where b order by i limit 10;
explain (costs off)
  select * from boolindex where b = true order by i desc limit 10;
explain (costs off)
  select * from boolindex where not b order by i limit 10;
explain (costs off)
  select * from boolindex where b is true order by i desc limit 10;
explain (costs off)
  select * from boolindex where b is false order by i desc limit 10;

--
-- REINDEX (VERBOSE)
--
CREATE TABLE reindex_verbose(id integer primary key);
-- \set VERBOSITY terse \\ -- suppress machine-dependent details
REINDEX (VERBOSE) TABLE reindex_verbose;
-- \set VERBOSITY default
DROP TABLE reindex_verbose;

--
-- REINDEX CONCURRENTLY
--
CREATE TABLE concur_reindex_tab (c1 int);
-- REINDEX
REINDEX TABLE concur_reindex_tab; -- notice
REINDEX (CONCURRENTLY) TABLE concur_reindex_tab; -- notice
ALTER TABLE concur_reindex_tab ADD COLUMN c2 text; -- add toast index
-- Normal index with integer column
CREATE UNIQUE INDEX concur_reindex_ind1 ON concur_reindex_tab(c1);
-- Normal index with text column
CREATE INDEX concur_reindex_ind2 ON concur_reindex_tab(c2);
-- UNIQUE index with expression
CREATE UNIQUE INDEX concur_reindex_ind3 ON concur_reindex_tab(abs(c1));
-- Duplicate column names
CREATE INDEX concur_reindex_ind4 ON concur_reindex_tab(c1, c1, c2);
-- Create table for check on foreign key dependence switch with indexes swapped
ALTER TABLE concur_reindex_tab ADD PRIMARY KEY USING INDEX concur_reindex_ind1;
CREATE TABLE concur_reindex_tab2 (c1 int REFERENCES concur_reindex_tab);
INSERT INTO concur_reindex_tab VALUES  (1, 'a');
INSERT INTO concur_reindex_tab VALUES  (2, 'a');
-- Reindex concurrently of exclusion constraint currently not supported
CREATE TABLE concur_reindex_tab3 (c1 int, c2 int4range, EXCLUDE USING gist (c2 WITH &&));
INSERT INTO concur_reindex_tab3 VALUES  (3, '[1,2]');
REINDEX INDEX CONCURRENTLY  concur_reindex_tab3_c2_excl;  -- error
REINDEX TABLE CONCURRENTLY concur_reindex_tab3;  -- succeeds with warning
INSERT INTO concur_reindex_tab3 VALUES  (4, '[2,4]');
-- Check materialized views
CREATE MATERIALIZED VIEW concur_reindex_matview AS SELECT * FROM concur_reindex_tab;
-- Dependency lookup before and after the follow-up REINDEX commands.
-- These should remain consistent.
SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid,refobjid,refobjsubid) as objref,
       deptype
FROM pg_depend
WHERE classid = 'pg_class'::regclass AND
  objid in ('concur_reindex_tab'::regclass,
            'concur_reindex_ind1'::regclass,
	    'concur_reindex_ind2'::regclass,
	    'concur_reindex_ind3'::regclass,
	    'concur_reindex_ind4'::regclass,
	    'concur_reindex_matview'::regclass)
  ORDER BY 1, 2;
REINDEX INDEX CONCURRENTLY concur_reindex_ind1;
REINDEX TABLE CONCURRENTLY concur_reindex_tab;
REINDEX TABLE CONCURRENTLY concur_reindex_matview;
SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid,refobjid,refobjsubid) as objref,
       deptype
FROM pg_depend
WHERE classid = 'pg_class'::regclass AND
  objid in ('concur_reindex_tab'::regclass,
            'concur_reindex_ind1'::regclass,
	    'concur_reindex_ind2'::regclass,
	    'concur_reindex_ind3'::regclass,
	    'concur_reindex_ind4'::regclass,
	    'concur_reindex_matview'::regclass)
  ORDER BY 1, 2;
-- Check that comments are preserved
CREATE TABLE testcomment (i int);
CREATE INDEX testcomment_idx1 ON testcomment (i);
COMMENT ON INDEX testcomment_idx1 IS 'test comment';
SELECT obj_description('testcomment_idx1'::regclass, 'pg_class');
REINDEX TABLE testcomment;
SELECT obj_description('testcomment_idx1'::regclass, 'pg_class');
REINDEX TABLE CONCURRENTLY testcomment ;
SELECT obj_description('testcomment_idx1'::regclass, 'pg_class');
DROP TABLE testcomment;
-- Check that indisclustered updates are preserved
CREATE TABLE concur_clustered(i int);
CREATE INDEX concur_clustered_i_idx ON concur_clustered(i);
ALTER TABLE concur_clustered CLUSTER ON concur_clustered_i_idx;
REINDEX TABLE CONCURRENTLY concur_clustered;
SELECT indexrelid::regclass, indisclustered FROM pg_index
  WHERE indrelid = 'concur_clustered'::regclass;
DROP TABLE concur_clustered;
-- Check that indisreplident updates are preserved.
CREATE TABLE concur_replident(i int NOT NULL);
CREATE UNIQUE INDEX concur_replident_i_idx ON concur_replident(i);
ALTER TABLE concur_replident REPLICA IDENTITY
  USING INDEX concur_replident_i_idx;
SELECT indexrelid::regclass, indisreplident FROM pg_index
  WHERE indrelid = 'concur_replident'::regclass;
REINDEX TABLE CONCURRENTLY concur_replident;
SELECT indexrelid::regclass, indisreplident FROM pg_index
  WHERE indrelid = 'concur_replident'::regclass;
DROP TABLE concur_replident;
-- Check that opclass parameters are preserved
CREATE TABLE concur_appclass_tab(i tsvector, j tsvector, k tsvector);
CREATE INDEX concur_appclass_ind on concur_appclass_tab
  USING gist (i tsvector_ops (siglen='1000'), j tsvector_ops (siglen='500'));
CREATE INDEX concur_appclass_ind_2 on concur_appclass_tab
  USING gist (k tsvector_ops (siglen='300'), j tsvector_ops);
REINDEX TABLE CONCURRENTLY concur_appclass_tab;
-- \d concur_appclass_tab
DROP TABLE concur_appclass_tab;

-- Partitions
-- Create some partitioned tables
CREATE TABLE concur_reindex_part (c1 int, c2 int) PARTITION BY RANGE (c1);
CREATE TABLE concur_reindex_part_0 PARTITION OF concur_reindex_part
  FOR VALUES FROM (0) TO (10) PARTITION BY list (c2);
CREATE TABLE concur_reindex_part_0_1 PARTITION OF concur_reindex_part_0
  FOR VALUES IN (1);
CREATE TABLE concur_reindex_part_0_2 PARTITION OF concur_reindex_part_0
  FOR VALUES IN (2);
-- This partitioned table will have no partitions.
CREATE TABLE concur_reindex_part_10 PARTITION OF concur_reindex_part
  FOR VALUES FROM (10) TO (20) PARTITION BY list (c2);
-- Create some partitioned indexes
CREATE INDEX concur_reindex_part_index ON ONLY concur_reindex_part (c1);
CREATE INDEX concur_reindex_part_index_0 ON ONLY concur_reindex_part_0 (c1);
ALTER INDEX concur_reindex_part_index ATTACH PARTITION concur_reindex_part_index_0;
-- This partitioned index will have no partitions.
CREATE INDEX concur_reindex_part_index_10 ON ONLY concur_reindex_part_10 (c1);
ALTER INDEX concur_reindex_part_index ATTACH PARTITION concur_reindex_part_index_10;
CREATE INDEX concur_reindex_part_index_0_1 ON ONLY concur_reindex_part_0_1 (c1);
ALTER INDEX concur_reindex_part_index_0 ATTACH PARTITION concur_reindex_part_index_0_1;
CREATE INDEX concur_reindex_part_index_0_2 ON ONLY concur_reindex_part_0_2 (c1);
ALTER INDEX concur_reindex_part_index_0 ATTACH PARTITION concur_reindex_part_index_0_2;
SELECT relid, parentrelid, level FROM pg_partition_tree('concur_reindex_part_index')
  ORDER BY relid, level;
SELECT relid, parentrelid, level FROM pg_partition_tree('concur_reindex_part_index')
  ORDER BY relid, level;
-- REINDEX should preserve dependencies of partition tree.
SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid,refobjid,refobjsubid) as objref,
       deptype
FROM pg_depend
WHERE classid = 'pg_class'::regclass AND
  objid in ('concur_reindex_part'::regclass,
            'concur_reindex_part_0'::regclass,
            'concur_reindex_part_0_1'::regclass,
            'concur_reindex_part_0_2'::regclass,
            'concur_reindex_part_index'::regclass,
            'concur_reindex_part_index_0'::regclass,
            'concur_reindex_part_index_0_1'::regclass,
            'concur_reindex_part_index_0_2'::regclass)
  ORDER BY 1, 2;
REINDEX INDEX CONCURRENTLY concur_reindex_part_index_0_1;
REINDEX INDEX CONCURRENTLY concur_reindex_part_index_0_2;
SELECT relid, parentrelid, level FROM pg_partition_tree('concur_reindex_part_index')
  ORDER BY relid, level;
REINDEX TABLE CONCURRENTLY concur_reindex_part_0_1;
REINDEX TABLE CONCURRENTLY concur_reindex_part_0_2;
SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid,refobjid,refobjsubid) as objref,
       deptype
FROM pg_depend
WHERE classid = 'pg_class'::regclass AND
  objid in ('concur_reindex_part'::regclass,
            'concur_reindex_part_0'::regclass,
            'concur_reindex_part_0_1'::regclass,
            'concur_reindex_part_0_2'::regclass,
            'concur_reindex_part_index'::regclass,
            'concur_reindex_part_index_0'::regclass,
            'concur_reindex_part_index_0_1'::regclass,
            'concur_reindex_part_index_0_2'::regclass)
  ORDER BY 1, 2;
SELECT relid, parentrelid, level FROM pg_partition_tree('concur_reindex_part_index')
  ORDER BY relid, level;

-- REINDEX for partitioned indexes
-- REINDEX TABLE fails for partitioned indexes
-- Top-most parent index
REINDEX TABLE concur_reindex_part_index; -- error
REINDEX TABLE CONCURRENTLY concur_reindex_part_index; -- error
-- Partitioned index with no leaves
REINDEX TABLE concur_reindex_part_index_10; -- error
REINDEX TABLE CONCURRENTLY concur_reindex_part_index_10; -- error
-- Cannot run in a transaction block
BEGIN;
REINDEX INDEX concur_reindex_part_index;
ROLLBACK;
-- Helper functions to track changes of relfilenodes in a partition tree.
-- Create a table tracking the relfilenode state.
CREATE OR REPLACE FUNCTION create_relfilenode_part(relname text, indname text)
  RETURNS VOID AS
  $func$
  BEGIN
  EXECUTE format('
    CREATE TABLE %I AS
      SELECT oid, relname, relfilenode, relkind, reltoastrelid
      FROM pg_class
      WHERE oid IN
         (SELECT relid FROM pg_partition_tree(''%I''));',
	 relname, indname);
  END
  $func$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION compare_relfilenode_part(tabname text)
  RETURNS TABLE (relname name, relkind "char", state text) AS
  $func$
  BEGIN
    RETURN QUERY EXECUTE
      format(
        'SELECT  b.relname,
                 b.relkind,
                 CASE WHEN a.relfilenode = b.relfilenode THEN ''relfilenode is unchanged''
                 ELSE ''relfilenode has changed'' END
           -- Do not join with OID here as CONCURRENTLY changes it.
           FROM %I b JOIN pg_class a ON b.relname = a.relname
           ORDER BY 1;', tabname);
  END
  $func$ LANGUAGE plpgsql;
--  Check that expected relfilenodes are changed, non-concurrent case.
SELECT create_relfilenode_part('reindex_index_status', 'concur_reindex_part_index');
REINDEX INDEX concur_reindex_part_index;
SELECT * FROM compare_relfilenode_part('reindex_index_status');
DROP TABLE reindex_index_status;
-- concurrent case.
SELECT create_relfilenode_part('reindex_index_status', 'concur_reindex_part_index');
REINDEX INDEX CONCURRENTLY concur_reindex_part_index;
SELECT * FROM compare_relfilenode_part('reindex_index_status');
DROP TABLE reindex_index_status;

-- REINDEX for partitioned tables
-- REINDEX INDEX fails for partitioned tables
-- Top-most parent
REINDEX INDEX concur_reindex_part; -- error
REINDEX INDEX CONCURRENTLY concur_reindex_part; -- error
-- Partitioned with no leaves
REINDEX INDEX concur_reindex_part_10; -- error
REINDEX INDEX CONCURRENTLY concur_reindex_part_10; -- error
-- Cannot run in a transaction block
BEGIN;
REINDEX TABLE concur_reindex_part;
ROLLBACK;
-- Check that expected relfilenodes are changed, non-concurrent case.
-- Note that the partition tree changes of the *indexes* need to be checked.
SELECT create_relfilenode_part('reindex_index_status', 'concur_reindex_part_index');
REINDEX TABLE concur_reindex_part;
SELECT * FROM compare_relfilenode_part('reindex_index_status');
DROP TABLE reindex_index_status;
-- concurrent case.
SELECT create_relfilenode_part('reindex_index_status', 'concur_reindex_part_index');
REINDEX TABLE CONCURRENTLY concur_reindex_part;
SELECT * FROM compare_relfilenode_part('reindex_index_status');
DROP TABLE reindex_index_status;

DROP FUNCTION create_relfilenode_part;
DROP FUNCTION compare_relfilenode_part;

-- Cleanup of partition tree used for REINDEX test.
DROP TABLE concur_reindex_part;

-- Check errors
-- Cannot run inside a transaction block
BEGIN;
REINDEX TABLE CONCURRENTLY concur_reindex_tab;
COMMIT;
REINDEX TABLE CONCURRENTLY pg_class; -- no catalog relation
REINDEX INDEX CONCURRENTLY pg_class_oid_index; -- no catalog index
-- These are the toast table and index of pg_authid.
REINDEX TABLE CONCURRENTLY pg_toast.pg_toast_1260; -- no catalog toast table
REINDEX INDEX CONCURRENTLY pg_toast.pg_toast_1260_index; -- no catalog toast index
REINDEX SYSTEM CONCURRENTLY postgres; -- not allowed for SYSTEM
REINDEX (CONCURRENTLY) SYSTEM postgres; -- ditto
REINDEX (CONCURRENTLY) SYSTEM;  -- ditto
-- Warns about catalog relations
REINDEX SCHEMA CONCURRENTLY pg_catalog;
-- Not the current database
REINDEX DATABASE not_current_database;

-- Check the relation status, there should not be invalid indexes
-- \d concur_reindex_tab
DROP MATERIALIZED VIEW concur_reindex_matview;
DROP TABLE concur_reindex_tab, concur_reindex_tab2, concur_reindex_tab3;

-- Check handling of invalid indexes
CREATE TABLE concur_reindex_tab4 (c1 int);
INSERT INTO concur_reindex_tab4 VALUES (1), (1), (2);
-- This trick creates an invalid index.
CREATE UNIQUE INDEX CONCURRENTLY concur_reindex_ind5 ON concur_reindex_tab4 (c1);
-- Reindexing concurrently this index fails with the same failure.
-- The extra index created is itself invalid, and can be dropped.
REINDEX INDEX CONCURRENTLY concur_reindex_ind5;
-- \d concur_reindex_tab4
DROP INDEX concur_reindex_ind5_ccnew;
-- This makes the previous failure go away, so the index can become valid.
DELETE FROM concur_reindex_tab4 WHERE c1 = 1;
-- The invalid index is not processed when running REINDEX TABLE.
REINDEX TABLE CONCURRENTLY concur_reindex_tab4;
-- \d concur_reindex_tab4
-- But it is fixed with REINDEX INDEX.
REINDEX INDEX CONCURRENTLY concur_reindex_ind5;
-- \d concur_reindex_tab4
DROP TABLE concur_reindex_tab4;

-- Check handling of indexes with expressions and predicates.  The
-- definitions of the rebuilt indexes should match the original
-- definitions.
CREATE TABLE concur_exprs_tab (c1 int , c2 boolean);
INSERT INTO concur_exprs_tab (c1, c2) VALUES (1369652450, FALSE),
  (414515746, TRUE),
  (897778963, FALSE);
CREATE UNIQUE INDEX concur_exprs_index_expr
  ON concur_exprs_tab ((c1::text COLLATE "C"));
CREATE UNIQUE INDEX concur_exprs_index_pred ON concur_exprs_tab (c1)
  WHERE (c1::text > 500000000::text COLLATE "C");
CREATE UNIQUE INDEX concur_exprs_index_pred_2
  ON concur_exprs_tab ((1 / c1))
  WHERE ('-H') >= (c2::TEXT) COLLATE "C";
ALTER INDEX concur_exprs_index_expr ALTER COLUMN 1 SET STATISTICS 100;
ANALYZE concur_exprs_tab;
SELECT starelid::regclass, count(*) FROM pg_statistic WHERE starelid IN (
  'concur_exprs_index_expr'::regclass,
  'concur_exprs_index_pred'::regclass,
  'concur_exprs_index_pred_2'::regclass)
  GROUP BY starelid ORDER BY starelid::regclass::text;
SELECT pg_get_indexdef('concur_exprs_index_expr'::regclass);
SELECT pg_get_indexdef('concur_exprs_index_pred'::regclass);
SELECT pg_get_indexdef('concur_exprs_index_pred_2'::regclass);
REINDEX TABLE CONCURRENTLY concur_exprs_tab;
SELECT pg_get_indexdef('concur_exprs_index_expr'::regclass);
SELECT pg_get_indexdef('concur_exprs_index_pred'::regclass);
SELECT pg_get_indexdef('concur_exprs_index_pred_2'::regclass);
-- ALTER TABLE recreates the indexes, which should keep their collations.
ALTER TABLE concur_exprs_tab ALTER c2 TYPE TEXT;
SELECT pg_get_indexdef('concur_exprs_index_expr'::regclass);
SELECT pg_get_indexdef('concur_exprs_index_pred'::regclass);
SELECT pg_get_indexdef('concur_exprs_index_pred_2'::regclass);
-- Statistics should remain intact.
SELECT starelid::regclass, count(*) FROM pg_statistic WHERE starelid IN (
  'concur_exprs_index_expr'::regclass,
  'concur_exprs_index_pred'::regclass,
  'concur_exprs_index_pred_2'::regclass)
  GROUP BY starelid ORDER BY starelid::regclass::text;
-- attstattarget should remain intact
SELECT attrelid::regclass, attnum, attstattarget
  FROM pg_attribute WHERE attrelid IN (
    'concur_exprs_index_expr'::regclass,
    'concur_exprs_index_pred'::regclass,
    'concur_exprs_index_pred_2'::regclass)
  ORDER BY attrelid::regclass::text, attnum;
DROP TABLE concur_exprs_tab;

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
REINDEX INDEX CONCURRENTLY concur_temp_ind_1;
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
-- Fails when running in a transaction
REINDEX INDEX CONCURRENTLY concur_temp_ind_3;
COMMIT;
-- REINDEX SCHEMA processes all temporary relations
CREATE TABLE reindex_temp_before AS
SELECT oid, relname, relfilenode, relkind, reltoastrelid
  FROM pg_class
  WHERE relname IN ('concur_temp_ind_1', 'concur_temp_ind_2');
SELECT pg_my_temp_schema()::regnamespace as temp_schema_name \gset
REINDEX SCHEMA CONCURRENTLY :temp_schema_name;
SELECT  b.relname,
        b.relkind,
        CASE WHEN a.relfilenode = b.relfilenode THEN 'relfilenode is unchanged'
        ELSE 'relfilenode has changed' END
  FROM reindex_temp_before b JOIN pg_class a ON b.oid = a.oid
  ORDER BY 1;
DROP TABLE concur_temp_tab_1, concur_temp_tab_2, reindex_temp_before;

--
-- REINDEX SCHEMA
--
REINDEX SCHEMA schema_to_reindex; -- failure, schema does not exist
CREATE SCHEMA schema_to_reindex;
SET search_path = 'schema_to_reindex';
CREATE TABLE table1(col1 SERIAL PRIMARY KEY);
INSERT INTO table1 SELECT generate_series(1,400);
CREATE TABLE table2(col1 SERIAL PRIMARY KEY, col2 TEXT NOT NULL);
INSERT INTO table2 SELECT generate_series(1,400), 'abc';
CREATE INDEX ON table2(col2);
CREATE MATERIALIZED VIEW matview AS SELECT col1 FROM table2;
CREATE INDEX ON matview(col1);
CREATE VIEW view AS SELECT col2 FROM table2;
CREATE TABLE reindex_before AS
SELECT oid, relname, relfilenode, relkind, reltoastrelid
	FROM pg_class
	where relnamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'schema_to_reindex');
INSERT INTO reindex_before
SELECT oid, 'pg_toast_TABLE', relfilenode, relkind, reltoastrelid
FROM pg_class WHERE oid IN
	(SELECT reltoastrelid FROM reindex_before WHERE reltoastrelid > 0);
INSERT INTO reindex_before
SELECT oid, 'pg_toast_TABLE_index', relfilenode, relkind, reltoastrelid
FROM pg_class where oid in
	(select indexrelid from pg_index where indrelid in
		(select reltoastrelid from reindex_before where reltoastrelid > 0));
REINDEX SCHEMA schema_to_reindex;
CREATE TABLE reindex_after AS SELECT oid, relname, relfilenode, relkind
	FROM pg_class
	where relnamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'schema_to_reindex');
SELECT  b.relname,
        b.relkind,
        CASE WHEN a.relfilenode = b.relfilenode THEN 'relfilenode is unchanged'
        ELSE 'relfilenode has changed' END
  FROM reindex_before b JOIN pg_class a ON b.oid = a.oid
  ORDER BY 1;
REINDEX SCHEMA schema_to_reindex;
BEGIN;
REINDEX SCHEMA schema_to_reindex; -- failure, cannot run in a transaction
END;

-- concurrently
REINDEX SCHEMA CONCURRENTLY schema_to_reindex;

-- Failure for unauthorized user
CREATE ROLE regress_reindexuser NOLOGIN;
SET SESSION ROLE regress_reindexuser;
REINDEX SCHEMA schema_to_reindex;
-- Permission failures with toast tables and indexes (pg_authid here)
RESET ROLE;
GRANT USAGE ON SCHEMA pg_toast TO regress_reindexuser;
SET SESSION ROLE regress_reindexuser;
REINDEX TABLE pg_toast.pg_toast_1260;
REINDEX INDEX pg_toast.pg_toast_1260_index;

-- Clean up
RESET ROLE;
REVOKE USAGE ON SCHEMA pg_toast FROM regress_reindexuser;
DROP ROLE regress_reindexuser;
DROP SCHEMA schema_to_reindex CASCADE;
-- END setup from create_index 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from point 
--
-- POINT
--

-- avoid bit-exact output here because operations may not be bit-exact.
SET extra_float_digits = 0;

-- point_tbl was already created and filled in test_setup.sql.
-- Here we just try to insert bad values.

INSERT INTO POINT_TBL(f1) VALUES ('asdfasdf');

INSERT INTO POINT_TBL(f1) VALUES ('(10.0 10.0)');

INSERT INTO POINT_TBL(f1) VALUES ('(10.0, 10.0) x');

INSERT INTO POINT_TBL(f1) VALUES ('(10.0,10.0');

INSERT INTO POINT_TBL(f1) VALUES ('(10.0, 1e+500)');	-- Out of range


SELECT * FROM POINT_TBL;

-- left of
SELECT p.* FROM POINT_TBL p WHERE p.f1 << '(0.0, 0.0)';

-- right of
SELECT p.* FROM POINT_TBL p WHERE '(0.0,0.0)' >> p.f1;

-- above
SELECT p.* FROM POINT_TBL p WHERE '(0.0,0.0)' |>> p.f1;

-- below
SELECT p.* FROM POINT_TBL p WHERE p.f1 <<| '(0.0, 0.0)';

-- equal
SELECT p.* FROM POINT_TBL p WHERE p.f1 ~= '(5.1, 34.5)';

-- point in box
SELECT p.* FROM POINT_TBL p
   WHERE p.f1 <@ box '(0,0,100,100)';

SELECT p.* FROM POINT_TBL p
   WHERE box '(0,0,100,100)' @> p.f1;

SELECT p.* FROM POINT_TBL p
   WHERE not p.f1 <@ box '(0,0,100,100)';

SELECT p.* FROM POINT_TBL p
   WHERE p.f1 <@ path '[(0,0),(-10,0),(-10,10)]';

SELECT p.* FROM POINT_TBL p
   WHERE not box '(0,0,100,100)' @> p.f1;

SELECT p.f1, p.f1 <-> point '(0,0)' AS dist
   FROM POINT_TBL p
   ORDER BY dist;

SELECT p1.f1 AS point1, p2.f1 AS point2, p1.f1 <-> p2.f1 AS dist
   FROM POINT_TBL p1, POINT_TBL p2
   ORDER BY dist, p1.f1[0], p2.f1[0];

SELECT p1.f1 AS point1, p2.f1 AS point2
   FROM POINT_TBL p1, POINT_TBL p2
   WHERE (p1.f1 <-> p2.f1) > 3;

-- put distance result into output to allow sorting with GEQ optimizer - tgl 97/05/10
SELECT p1.f1 AS point1, p2.f1 AS point2, (p1.f1 <-> p2.f1) AS distance
   FROM POINT_TBL p1, POINT_TBL p2
   WHERE (p1.f1 <-> p2.f1) > 3 and p1.f1 << p2.f1
   ORDER BY distance, p1.f1[0], p2.f1[0];

-- put distance result into output to allow sorting with GEQ optimizer - tgl 97/05/10
SELECT p1.f1 AS point1, p2.f1 AS point2, (p1.f1 <-> p2.f1) AS distance
   FROM POINT_TBL p1, POINT_TBL p2
   WHERE (p1.f1 <-> p2.f1) > 3 and p1.f1 << p2.f1 and p1.f1 |>> p2.f1
   ORDER BY distance;

-- Test that GiST indexes provide same behavior as sequential scan
CREATE TEMP TABLE point_gist_tbl(f1 point);
INSERT INTO point_gist_tbl SELECT '(0,0)' FROM generate_series(0,1000);
CREATE INDEX point_gist_tbl_index ON point_gist_tbl USING gist (f1);
INSERT INTO point_gist_tbl VALUES ('(0.0000009,0.0000009)');
SET enable_seqscan TO true;
SET enable_indexscan TO false;
SET enable_bitmapscan TO false;
SELECT COUNT(*) FROM point_gist_tbl WHERE f1 ~= '(0.0000009,0.0000009)'::point;
SELECT COUNT(*) FROM point_gist_tbl WHERE f1 <@ '(0.0000009,0.0000009),(0.0000009,0.0000009)'::box;
SELECT COUNT(*) FROM point_gist_tbl WHERE f1 ~= '(0.0000018,0.0000018)'::point;
SET enable_seqscan TO false;
SET enable_indexscan TO true;
SET enable_bitmapscan TO true;
SELECT COUNT(*) FROM point_gist_tbl WHERE f1 ~= '(0.0000009,0.0000009)'::point;
SELECT COUNT(*) FROM point_gist_tbl WHERE f1 <@ '(0.0000009,0.0000009),(0.0000009,0.0000009)'::box;
SELECT COUNT(*) FROM point_gist_tbl WHERE f1 ~= '(0.0000018,0.0000018)'::point;
RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;

-- test non-error-throwing API for some core types
SELECT pg_input_is_valid('1,y', 'point');
SELECT * FROM pg_input_error_info('1,y', 'point');
-- END setup from point 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from lseg 
--
-- LSEG
-- Line segments
--

--DROP TABLE LSEG_TBL /* REPLACED */,
CREATE TABLE LSEG_TBL (s lseg);

INSERT INTO LSEG_TBL VALUES ('[(1,2),(3,4)]');
INSERT INTO LSEG_TBL VALUES ('(0,0),(6,6)');
INSERT INTO LSEG_TBL VALUES ('10,-10 ,-3,-4');
INSERT INTO LSEG_TBL VALUES ('[-1e6,2e2,3e5, -4e1]');
INSERT INTO LSEG_TBL VALUES (lseg(point(11, 22), point(33,44)));
INSERT INTO LSEG_TBL VALUES ('[(-10,2),(-10,3)]');	-- vertical
INSERT INTO LSEG_TBL VALUES ('[(0,-20),(30,-20)]');	-- horizontal
INSERT INTO LSEG_TBL VALUES ('[(NaN,1),(NaN,90)]');	-- NaN

-- bad values for parser testing
INSERT INTO LSEG_TBL VALUES ('(3asdf,2 ,3,4r2)');
INSERT INTO LSEG_TBL VALUES ('[1,2,3, 4');
INSERT INTO LSEG_TBL VALUES ('[(,2),(3,4)]');
INSERT INTO LSEG_TBL VALUES ('[(1,2),(3,4)');

select * from LSEG_TBL;

-- test non-error-throwing API for some core types
SELECT pg_input_is_valid('[(1,2),(3)]', 'lseg');
SELECT * FROM pg_input_error_info('[(1,2),(3)]', 'lseg');
-- END setup from lseg 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from line 
--
-- LINE
-- Infinite lines
--

--DROP TABLE LINE_TBL /* REPLACED */,
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

-- bad values for parser testing
INSERT INTO LINE_TBL VALUES ('{}');
INSERT INTO LINE_TBL VALUES ('{0');
INSERT INTO LINE_TBL VALUES ('{0,0}');
INSERT INTO LINE_TBL VALUES ('{0,0,1');
INSERT INTO LINE_TBL VALUES ('{0,0,1}');
INSERT INTO LINE_TBL VALUES ('{0,0,1} x');
INSERT INTO LINE_TBL VALUES ('(3asdf,2 ,3,4r2)');
INSERT INTO LINE_TBL VALUES ('[1,2,3, 4');
INSERT INTO LINE_TBL VALUES ('[(,2),(3,4)]');
INSERT INTO LINE_TBL VALUES ('[(1,2),(3,4)');
INSERT INTO LINE_TBL VALUES ('[(1,2),(1,2)]');

INSERT INTO LINE_TBL VALUES (line(point '(1,0)', point '(1,0)'));

select * from LINE_TBL;

select '{nan, 1, nan}'::line = '{nan, 1, nan}'::line as true,
	   '{nan, 1, nan}'::line = '{nan, 2, nan}'::line as false;

-- test non-error-throwing API for some core types
SELECT pg_input_is_valid('{1, 1}', 'line');
SELECT * FROM pg_input_error_info('{1, 1}', 'line');
SELECT pg_input_is_valid('{0, 0, 0}', 'line');
SELECT * FROM pg_input_error_info('{0, 0, 0}', 'line');
SELECT pg_input_is_valid('{1, 1, a}', 'line');
SELECT * FROM pg_input_error_info('{1, 1, a}', 'line');
SELECT pg_input_is_valid('{1, 1, 1e400}', 'line');
SELECT * FROM pg_input_error_info('{1, 1, 1e400}', 'line');
SELECT pg_input_is_valid('(1, 1), (1, 1e400)', 'line');
SELECT * FROM pg_input_error_info('(1, 1), (1, 1e400)', 'line');
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

-- badly formatted box inputs
INSERT INTO BOX_TBL (f1) VALUES ('(2.3, 4.5)');

INSERT INTO BOX_TBL (f1) VALUES ('[1, 2, 3, 4)');

INSERT INTO BOX_TBL (f1) VALUES ('(1, 2, 3, 4]');

INSERT INTO BOX_TBL (f1) VALUES ('(1, 2, 3, 4) x');

INSERT INTO BOX_TBL (f1) VALUES ('asdfasdf(ad');


SELECT * FROM BOX_TBL;

SELECT b.*, area(b.f1) as barea
   FROM BOX_TBL b;

-- overlap
SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 && box '(2.5,2.5,1.0,1.0)';

-- left-or-overlap (x only)
SELECT b1.*
   FROM BOX_TBL b1
   WHERE b1.f1 &< box '(2.0,2.0,2.5,2.5)';

-- right-or-overlap (x only)
SELECT b1.*
   FROM BOX_TBL b1
   WHERE b1.f1 &> box '(2.0,2.0,2.5,2.5)';

-- left of
SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 << box '(3.0,3.0,5.0,5.0)';

-- area <=
SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 <= box '(3.0,3.0,5.0,5.0)';

-- area <
SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 < box '(3.0,3.0,5.0,5.0)';

-- area =
SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 = box '(3.0,3.0,5.0,5.0)';

-- area >
SELECT b.f1
   FROM BOX_TBL b				-- zero area
   WHERE b.f1 > box '(3.5,3.0,4.5,3.0)';

-- area >=
SELECT b.f1
   FROM BOX_TBL b				-- zero area
   WHERE b.f1 >= box '(3.5,3.0,4.5,3.0)';

-- right of
SELECT b.f1
   FROM BOX_TBL b
   WHERE box '(3.0,3.0,5.0,5.0)' >> b.f1;

-- contained in
SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 <@ box '(0,0,3,3)';

-- contains
SELECT b.f1
   FROM BOX_TBL b
   WHERE box '(0,0,3,3)' @> b.f1;

-- box equality
SELECT b.f1
   FROM BOX_TBL b
   WHERE box '(1,1,3,3)' ~= b.f1;

-- center of box, left unary operator
SELECT @@(b1.f1) AS p
   FROM BOX_TBL b1;

-- wholly-contained
SELECT b1.*, b2.*
   FROM BOX_TBL b1, BOX_TBL b2
   WHERE b1.f1 @> b2.f1 and not b1.f1 ~= b2.f1;

SELECT height(f1), width(f1) FROM BOX_TBL;

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

SELECT * FROM box_temp WHERE f1 << '(10,20),(30,40)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 << '(10,20),(30,40)';

SELECT * FROM box_temp WHERE f1 &< '(10,4.333334),(5,100)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 &< '(10,4.333334),(5,100)';

SELECT * FROM box_temp WHERE f1 && '(15,20),(25,30)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 && '(15,20),(25,30)';

SELECT * FROM box_temp WHERE f1 &> '(40,30),(45,50)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 &> '(40,30),(45,50)';

SELECT * FROM box_temp WHERE f1 >> '(30,40),(40,30)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 >> '(30,40),(40,30)';

SELECT * FROM box_temp WHERE f1 <<| '(10,4.33334),(5,100)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 <<| '(10,4.33334),(5,100)';

SELECT * FROM box_temp WHERE f1 &<| '(10,4.3333334),(5,1)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 &<| '(10,4.3333334),(5,1)';

SELECT * FROM box_temp WHERE f1 |&> '(49.99,49.99),(49.99,49.99)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 |&> '(49.99,49.99),(49.99,49.99)';

SELECT * FROM box_temp WHERE f1 |>> '(37,38),(39,40)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 |>> '(37,38),(39,40)';

SELECT * FROM box_temp WHERE f1 @> '(10,11),(15,16)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 @> '(10,11),(15,15)';

SELECT * FROM box_temp WHERE f1 <@ '(10,15),(30,35)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 <@ '(10,15),(30,35)';

SELECT * FROM box_temp WHERE f1 ~= '(20,20),(40,40)';
EXPLAIN (COSTS OFF) SELECT * FROM box_temp WHERE f1 ~= '(20,20),(40,40)';

RESET enable_seqscan;

DROP INDEX box_spgist;

--
-- Test the SP-GiST index on the larger volume of data
--
CREATE TABLE quad_box_tbl (id int, b box);

INSERT INTO quad_box_tbl
  SELECT (x - 1) * 100 + y, box(point(x * 10, y * 10), point(x * 10 + 5, y * 10 + 5))
  FROM generate_series(1, 100) x,
       generate_series(1, 100) y;

-- insert repeating data to test allTheSame
INSERT INTO quad_box_tbl
  SELECT i, '((200, 300),(210, 310))'
  FROM generate_series(10001, 11000) AS i;

INSERT INTO quad_box_tbl
VALUES
  (11001, NULL),
  (11002, NULL),
  (11003, '((-infinity,-infinity),(infinity,infinity))'),
  (11004, '((-infinity,100),(-infinity,500))'),
  (11005, '((-infinity,-infinity),(700,infinity))');

CREATE INDEX quad_box_tbl_idx ON quad_box_tbl USING spgist(b);

-- get reference results for ORDER BY distance from seq scan
SET enable_seqscan = ON;
SET enable_indexscan = OFF;
SET enable_bitmapscan = OFF;

CREATE TABLE quad_box_tbl_ord_seq1 AS
SELECT rank() OVER (ORDER BY b <-> point '123,456') n, b <-> point '123,456' dist, id
FROM quad_box_tbl;

CREATE TABLE quad_box_tbl_ord_seq2 AS
SELECT rank() OVER (ORDER BY b <-> point '123,456') n, b <-> point '123,456' dist, id
FROM quad_box_tbl WHERE b <@ box '((200,300),(500,600))';

SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = ON;

SELECT count(*) FROM quad_box_tbl WHERE b <<  box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b &<  box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b &&  box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b &>  box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b >>  box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b >>  box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b <<| box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b &<| box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b |&> box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b |>> box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b @>  box '((201,301),(202,303))';
SELECT count(*) FROM quad_box_tbl WHERE b <@  box '((100,200),(300,500))';
SELECT count(*) FROM quad_box_tbl WHERE b ~=  box '((200,300),(205,305))';

-- test ORDER BY distance
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

EXPLAIN (COSTS OFF)
SELECT rank() OVER (ORDER BY b <-> point '123,456') n, b <-> point '123,456' dist, id
FROM quad_box_tbl;

CREATE TEMP TABLE quad_box_tbl_ord_idx1 AS
SELECT rank() OVER (ORDER BY b <-> point '123,456') n, b <-> point '123,456' dist, id
FROM quad_box_tbl;

SELECT *
FROM quad_box_tbl_ord_seq1 seq FULL JOIN quad_box_tbl_ord_idx1 idx
	ON seq.n = idx.n AND seq.id = idx.id AND
		(seq.dist = idx.dist OR seq.dist IS NULL AND idx.dist IS NULL)
WHERE seq.id IS NULL OR idx.id IS NULL;


EXPLAIN (COSTS OFF)
SELECT rank() OVER (ORDER BY b <-> point '123,456') n, b <-> point '123,456' dist, id
FROM quad_box_tbl WHERE b <@ box '((200,300),(500,600))';

CREATE TEMP TABLE quad_box_tbl_ord_idx2 AS
SELECT rank() OVER (ORDER BY b <-> point '123,456') n, b <-> point '123,456' dist, id
FROM quad_box_tbl WHERE b <@ box '((200,300),(500,600))';

SELECT *
FROM quad_box_tbl_ord_seq2 seq FULL JOIN quad_box_tbl_ord_idx2 idx
	ON seq.n = idx.n AND seq.id = idx.id AND
		(seq.dist = idx.dist OR seq.dist IS NULL AND idx.dist IS NULL)
WHERE seq.id IS NULL OR idx.id IS NULL;

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;

-- test non-error-throwing API for some core types
SELECT pg_input_is_valid('200', 'box');
SELECT * FROM pg_input_error_info('200', 'box');
SELECT pg_input_is_valid('((200,300),(500, xyz))', 'box');
SELECT * FROM pg_input_error_info('((200,300),(500, xyz))', 'box');
-- END setup from box 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from path 
--
-- PATH
--

--DROP TABLE PATH_TBL /* REPLACED */,

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

-- bad values for parser testing
INSERT INTO PATH_TBL VALUES ('[]');

INSERT INTO PATH_TBL VALUES ('[(,2),(3,4)]');

INSERT INTO PATH_TBL VALUES ('[(1,2),(3,4)');

INSERT INTO PATH_TBL VALUES ('(1,2,3,4');

INSERT INTO PATH_TBL VALUES ('(1,2),(3,4)]');

SELECT f1 AS open_path FROM PATH_TBL WHERE isopen(f1);

SELECT f1 AS closed_path FROM PATH_TBL WHERE isclosed(f1);

SELECT pclose(f1) AS closed_path FROM PATH_TBL;

SELECT popen(f1) AS open_path FROM PATH_TBL;

-- test non-error-throwing API for some core types
SELECT pg_input_is_valid('[(1,2),(3)]', 'path');
SELECT * FROM pg_input_error_info('[(1,2),(3)]', 'path');
SELECT pg_input_is_valid('[(1,2,6),(3,4,6)]', 'path');
SELECT * FROM pg_input_error_info('[(1,2,6),(3,4,6)]', 'path');
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

-- bad polygon input strings
INSERT INTO POLYGON_TBL(f1) VALUES ('0.0');

INSERT INTO POLYGON_TBL(f1) VALUES ('(0.0 0.0');

INSERT INTO POLYGON_TBL(f1) VALUES ('(0,1,2)');

INSERT INTO POLYGON_TBL(f1) VALUES ('(0,1,2,3');

INSERT INTO POLYGON_TBL(f1) VALUES ('asdf');


SELECT * FROM POLYGON_TBL;

--
-- Test the SP-GiST index
--

CREATE TABLE quad_poly_tbl (id int, p polygon);

INSERT INTO quad_poly_tbl
	SELECT (x - 1) * 100 + y, polygon(circle(point(x * 10, y * 10), 1 + (x + y) % 10))
	FROM generate_series(1, 100) x,
		 generate_series(1, 100) y;

INSERT INTO quad_poly_tbl
	SELECT i, polygon '((200, 300),(210, 310),(230, 290))'
	FROM generate_series(10001, 11000) AS i;

INSERT INTO quad_poly_tbl
	VALUES
		(11001, NULL),
		(11002, NULL),
		(11003, NULL);

CREATE INDEX quad_poly_tbl_idx ON quad_poly_tbl USING spgist(p);

-- get reference results for ORDER BY distance from seq scan
SET enable_seqscan = ON;
SET enable_indexscan = OFF;
SET enable_bitmapscan = OFF;

CREATE TEMP TABLE quad_poly_tbl_ord_seq2 AS
SELECT rank() OVER (ORDER BY p <-> point '123,456') n, p <-> point '123,456' dist, id
FROM quad_poly_tbl WHERE p <@ polygon '((300,300),(400,600),(600,500),(700,200))';

-- check results from index scan
SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p << polygon '((300,300),(400,600),(600,500),(700,200))';
SELECT count(*) FROM quad_poly_tbl WHERE p << polygon '((300,300),(400,600),(600,500),(700,200))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p &< polygon '((300,300),(400,600),(600,500),(700,200))';
SELECT count(*) FROM quad_poly_tbl WHERE p &< polygon '((300,300),(400,600),(600,500),(700,200))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p && polygon '((300,300),(400,600),(600,500),(700,200))';
SELECT count(*) FROM quad_poly_tbl WHERE p && polygon '((300,300),(400,600),(600,500),(700,200))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p &> polygon '((300,300),(400,600),(600,500),(700,200))';
SELECT count(*) FROM quad_poly_tbl WHERE p &> polygon '((300,300),(400,600),(600,500),(700,200))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p >> polygon '((300,300),(400,600),(600,500),(700,200))';
SELECT count(*) FROM quad_poly_tbl WHERE p >> polygon '((300,300),(400,600),(600,500),(700,200))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p <<| polygon '((300,300),(400,600),(600,500),(700,200))';
SELECT count(*) FROM quad_poly_tbl WHERE p <<| polygon '((300,300),(400,600),(600,500),(700,200))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p &<| polygon '((300,300),(400,600),(600,500),(700,200))';
SELECT count(*) FROM quad_poly_tbl WHERE p &<| polygon '((300,300),(400,600),(600,500),(700,200))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p |&> polygon '((300,300),(400,600),(600,500),(700,200))';
SELECT count(*) FROM quad_poly_tbl WHERE p |&> polygon '((300,300),(400,600),(600,500),(700,200))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p |>> polygon '((300,300),(400,600),(600,500),(700,200))';
SELECT count(*) FROM quad_poly_tbl WHERE p |>> polygon '((300,300),(400,600),(600,500),(700,200))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p <@ polygon '((300,300),(400,600),(600,500),(700,200))';
SELECT count(*) FROM quad_poly_tbl WHERE p <@ polygon '((300,300),(400,600),(600,500),(700,200))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p @> polygon '((340,550),(343,552),(341,553))';
SELECT count(*) FROM quad_poly_tbl WHERE p @> polygon '((340,550),(343,552),(341,553))';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_poly_tbl WHERE p ~= polygon '((200, 300),(210, 310),(230, 290))';
SELECT count(*) FROM quad_poly_tbl WHERE p ~= polygon '((200, 300),(210, 310),(230, 290))';

-- test ORDER BY distance
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

EXPLAIN (COSTS OFF)
SELECT rank() OVER (ORDER BY p <-> point '123,456') n, p <-> point '123,456' dist, id
FROM quad_poly_tbl WHERE p <@ polygon '((300,300),(400,600),(600,500),(700,200))';

CREATE TEMP TABLE quad_poly_tbl_ord_idx2 AS
SELECT rank() OVER (ORDER BY p <-> point '123,456') n, p <-> point '123,456' dist, id
FROM quad_poly_tbl WHERE p <@ polygon '((300,300),(400,600),(600,500),(700,200))';

SELECT *
FROM quad_poly_tbl_ord_seq2 seq FULL JOIN quad_poly_tbl_ord_idx2 idx
	ON seq.n = idx.n AND seq.id = idx.id AND
		(seq.dist = idx.dist OR seq.dist IS NULL AND idx.dist IS NULL)
WHERE seq.id IS NULL OR idx.id IS NULL;

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;

-- test non-error-throwing API for some core types
SELECT pg_input_is_valid('(2.0,0.8,0.1)', 'polygon');
SELECT * FROM pg_input_error_info('(2.0,0.8,0.1)', 'polygon');
SELECT pg_input_is_valid('(2.0,xyz)', 'polygon');
SELECT * FROM pg_input_error_info('(2.0,xyz)', 'polygon');
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

INSERT INTO CIRCLE_TBL VALUES ('<(3,5),NaN>');	-- NaN radius

-- bad values

INSERT INTO CIRCLE_TBL VALUES ('<(-100,0),-100>');

INSERT INTO CIRCLE_TBL VALUES ('<(100,200),10');

INSERT INTO CIRCLE_TBL VALUES ('<(100,200),10> x');

INSERT INTO CIRCLE_TBL VALUES ('1abc,3,5');

INSERT INTO CIRCLE_TBL VALUES ('(3,(1,2),3)');

SELECT * FROM CIRCLE_TBL;

SELECT center(f1) AS center
  FROM CIRCLE_TBL;

SELECT radius(f1) AS radius
  FROM CIRCLE_TBL;

SELECT diameter(f1) AS diameter
  FROM CIRCLE_TBL;

SELECT f1 FROM CIRCLE_TBL WHERE radius(f1) < 5;

SELECT f1 FROM CIRCLE_TBL WHERE diameter(f1) >= 10;

SELECT c1.f1 AS one, c2.f1 AS two, (c1.f1 <-> c2.f1) AS distance
  FROM CIRCLE_TBL c1, CIRCLE_TBL c2
  WHERE (c1.f1 < c2.f1) AND ((c1.f1 <-> c2.f1) > 0)
  ORDER BY distance, area(c1.f1), area(c2.f1);
-- END setup from circle 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from geometry 
--
-- GEOMETRY
--

-- Back off displayed precision a little bit to reduce platform-to-platform
-- variation in results.
SET extra_float_digits TO -3;

--
-- Points
--

SELECT center(f1) AS center
   FROM BOX_TBL;

SELECT (@@ f1) AS center
   FROM BOX_TBL;

SELECT point(f1) AS center
   FROM CIRCLE_TBL;

SELECT (@@ f1) AS center
   FROM CIRCLE_TBL;

SELECT (@@ f1) AS center
   FROM POLYGON_TBL
   WHERE (# f1) > 2;

-- /* REPLACED */''is horizontal/* REPLACED */'' function
SELECT p1.f1
   FROM POINT_TBL p1
   WHERE ishorizontal(p1.f1, point '(0,0)');

-- /* REPLACED */''is horizontal/* REPLACED */'' operator
SELECT p1.f1
   FROM POINT_TBL p1
   WHERE p1.f1 ?- point '(0,0)';

-- /* REPLACED */''is vertical/* REPLACED */'' function
SELECT p1.f1
   FROM POINT_TBL p1
   WHERE isvertical(p1.f1, point '(5.1,34.5)');

-- /* REPLACED */''is vertical/* REPLACED */'' operator
SELECT p1.f1
   FROM POINT_TBL p1
   WHERE p1.f1 ?| point '(5.1,34.5)';

-- Slope
SELECT p1.f1, p2.f1, slope(p1.f1, p2.f1) FROM POINT_TBL p1, POINT_TBL p2;

-- Add point
SELECT p1.f1, p2.f1, p1.f1 + p2.f1 FROM POINT_TBL p1, POINT_TBL p2;

-- Subtract point
SELECT p1.f1, p2.f1, p1.f1 - p2.f1 FROM POINT_TBL p1, POINT_TBL p2;

-- Multiply with point
SELECT p1.f1, p2.f1, p1.f1 * p2.f1 FROM POINT_TBL p1, POINT_TBL p2 WHERE p1.f1[0] BETWEEN 1 AND 1000;

-- Underflow error
SELECT p1.f1, p2.f1, p1.f1 * p2.f1 FROM POINT_TBL p1, POINT_TBL p2 WHERE p1.f1[0] < 1;

-- Divide by point
SELECT p1.f1, p2.f1, p1.f1 / p2.f1 FROM POINT_TBL p1, POINT_TBL p2 WHERE p2.f1[0] BETWEEN 1 AND 1000;

-- Overflow error
SELECT p1.f1, p2.f1, p1.f1 / p2.f1 FROM POINT_TBL p1, POINT_TBL p2 WHERE p2.f1[0] > 1000;

-- Division by 0 error
SELECT p1.f1, p2.f1, p1.f1 / p2.f1 FROM POINT_TBL p1, POINT_TBL p2 WHERE p2.f1 ~= '(0,0)'::point;

-- Distance to line
SELECT p.f1, l.s, p.f1 <-> l.s AS dist_pl, l.s <-> p.f1 AS dist_lp FROM POINT_TBL p, LINE_TBL l;

-- Distance to line segment
SELECT p.f1, l.s, p.f1 <-> l.s AS dist_ps, l.s <-> p.f1 AS dist_sp FROM POINT_TBL p, LSEG_TBL l;

-- Distance to box
SELECT p.f1, b.f1, p.f1 <-> b.f1 AS dist_pb, b.f1 <-> p.f1 AS dist_bp FROM POINT_TBL p, BOX_TBL b;

-- Distance to path
SELECT p.f1, p1.f1, p.f1 <-> p1.f1 AS dist_ppath, p1.f1 <-> p.f1 AS dist_pathp FROM POINT_TBL p, PATH_TBL p1;

-- Distance to polygon
SELECT p.f1, p1.f1, p.f1 <-> p1.f1 AS dist_ppoly, p1.f1 <-> p.f1 AS dist_polyp FROM POINT_TBL p, POLYGON_TBL p1;

-- Construct line through two points
SELECT p1.f1, p2.f1, line(p1.f1, p2.f1)
  FROM POINT_TBL p1, POINT_TBL p2 WHERE p1.f1 <> p2.f1;

-- Closest point to line
SELECT p.f1, l.s, p.f1 ## l.s FROM POINT_TBL p, LINE_TBL l;

-- Closest point to line segment
SELECT p.f1, l.s, p.f1 ## l.s FROM POINT_TBL p, LSEG_TBL l;

-- Closest point to box
SELECT p.f1, b.f1, p.f1 ## b.f1 FROM POINT_TBL p, BOX_TBL b;

-- On line
SELECT p.f1, l.s FROM POINT_TBL p, LINE_TBL l WHERE p.f1 <@ l.s;

-- On line segment
SELECT p.f1, l.s FROM POINT_TBL p, LSEG_TBL l WHERE p.f1 <@ l.s;

-- On path
SELECT p.f1, p1.f1 FROM POINT_TBL p, PATH_TBL p1 WHERE p.f1 <@ p1.f1;

--
-- Lines
--

-- Vertical
SELECT s FROM LINE_TBL WHERE ?| s;

-- Horizontal
SELECT s FROM LINE_TBL WHERE ?- s;

-- Same as line
SELECT l1.s, l2.s FROM LINE_TBL l1, LINE_TBL l2 WHERE l1.s = l2.s;

-- Parallel to line
SELECT l1.s, l2.s FROM LINE_TBL l1, LINE_TBL l2 WHERE l1.s ?|| l2.s;

-- Perpendicular to line
SELECT l1.s, l2.s FROM LINE_TBL l1, LINE_TBL l2 WHERE l1.s ?-| l2.s;

-- Distance to line
SELECT l1.s, l2.s, l1.s <-> l2.s FROM LINE_TBL l1, LINE_TBL l2;

-- Intersect with line
SELECT l1.s, l2.s FROM LINE_TBL l1, LINE_TBL l2 WHERE l1.s ?# l2.s;

-- Intersect with box
SELECT l.s, b.f1 FROM LINE_TBL l, BOX_TBL b WHERE l.s ?# b.f1;

-- Intersection point with line
SELECT l1.s, l2.s, l1.s # l2.s FROM LINE_TBL l1, LINE_TBL l2;

-- Closest point to line segment
SELECT l.s, l1.s, l.s ## l1.s FROM LINE_TBL l, LSEG_TBL l1;

--
-- Line segments
--

-- intersection
SELECT p.f1, l.s, l.s # p.f1 AS intersection
   FROM LSEG_TBL l, POINT_TBL p;

-- Length
SELECT s, @-@ s FROM LSEG_TBL;

-- Vertical
SELECT s FROM LSEG_TBL WHERE ?| s;

-- Horizontal
SELECT s FROM LSEG_TBL WHERE ?- s;

-- Center
SELECT s, @@ s FROM LSEG_TBL;

-- To point
SELECT s, s::point FROM LSEG_TBL;

-- Has points less than line segment
SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s < l2.s;

-- Has points less than or equal to line segment
SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s <= l2.s;

-- Has points equal to line segment
SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s = l2.s;

-- Has points greater than or equal to line segment
SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s >= l2.s;

-- Has points greater than line segment
SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s > l2.s;

-- Has points not equal to line segment
SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s != l2.s;

-- Parallel with line segment
SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s ?|| l2.s;

-- Perpendicular with line segment
SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s ?-| l2.s;

-- Distance to line
SELECT l.s, l1.s, l.s <-> l1.s AS dist_sl, l1.s <-> l.s AS dist_ls FROM LSEG_TBL l, LINE_TBL l1;

-- Distance to line segment
SELECT l1.s, l2.s, l1.s <-> l2.s FROM LSEG_TBL l1, LSEG_TBL l2;

-- Distance to box
SELECT l.s, b.f1, l.s <-> b.f1 AS dist_sb, b.f1 <-> l.s AS dist_bs FROM LSEG_TBL l, BOX_TBL b;

-- Intersect with line segment
SELECT l.s, l1.s FROM LSEG_TBL l, LINE_TBL l1 WHERE l.s ?# l1.s;

-- Intersect with box
SELECT l.s, b.f1 FROM LSEG_TBL l, BOX_TBL b WHERE l.s ?# b.f1;

-- Intersection point with line segment
SELECT l1.s, l2.s, l1.s # l2.s FROM LSEG_TBL l1, LSEG_TBL l2;

-- Closest point to line segment
SELECT l1.s, l2.s, l1.s ## l2.s FROM LSEG_TBL l1, LSEG_TBL l2;

-- Closest point to box
SELECT l.s, b.f1, l.s ## b.f1 FROM LSEG_TBL l, BOX_TBL b;

-- On line
SELECT l.s, l1.s FROM LSEG_TBL l, LINE_TBL l1 WHERE l.s <@ l1.s;

-- On box
SELECT l.s, b.f1 FROM LSEG_TBL l, BOX_TBL b WHERE l.s <@ b.f1;

--
-- Boxes
--

SELECT box(f1) AS box FROM CIRCLE_TBL;

-- translation
SELECT b.f1 + p.f1 AS translation
   FROM BOX_TBL b, POINT_TBL p;

SELECT b.f1 - p.f1 AS translation
   FROM BOX_TBL b, POINT_TBL p;

-- Multiply with point
SELECT b.f1, p.f1, b.f1 * p.f1 FROM BOX_TBL b, POINT_TBL p WHERE p.f1[0] BETWEEN 1 AND 1000;

-- Overflow error
SELECT b.f1, p.f1, b.f1 * p.f1 FROM BOX_TBL b, POINT_TBL p WHERE p.f1[0] > 1000;

-- Divide by point
SELECT b.f1, p.f1, b.f1 / p.f1 FROM BOX_TBL b, POINT_TBL p WHERE p.f1[0] BETWEEN 1 AND 1000;

-- To box
SELECT f1::box
	FROM POINT_TBL;

SELECT bound_box(a.f1, b.f1)
	FROM BOX_TBL a, BOX_TBL b;

-- Below box
SELECT b1.f1, b2.f1, b1.f1 <^ b2.f1 FROM BOX_TBL b1, BOX_TBL b2;

-- Above box
SELECT b1.f1, b2.f1, b1.f1 >^ b2.f1 FROM BOX_TBL b1, BOX_TBL b2;

-- Intersection point with box
SELECT b1.f1, b2.f1, b1.f1 # b2.f1 FROM BOX_TBL b1, BOX_TBL b2;

-- Diagonal
SELECT f1, diagonal(f1) FROM BOX_TBL;

-- Distance to box
SELECT b1.f1, b2.f1, b1.f1 <-> b2.f1 FROM BOX_TBL b1, BOX_TBL b2;

--
-- Paths
--

-- Points
SELECT f1, npoints(f1) FROM PATH_TBL;

-- Area
SELECT f1, area(f1) FROM PATH_TBL;

-- Length
SELECT f1, @-@ f1 FROM PATH_TBL;

-- To polygon
SELECT f1, f1::polygon FROM PATH_TBL WHERE isclosed(f1);

-- Open path cannot be converted to polygon error
SELECT f1, f1::polygon FROM PATH_TBL WHERE isopen(f1);

-- Has points less than path
SELECT p1.f1, p2.f1 FROM PATH_TBL p1, PATH_TBL p2 WHERE p1.f1 < p2.f1;

-- Has points less than or equal to path
SELECT p1.f1, p2.f1 FROM PATH_TBL p1, PATH_TBL p2 WHERE p1.f1 <= p2.f1;

-- Has points equal to path
SELECT p1.f1, p2.f1 FROM PATH_TBL p1, PATH_TBL p2 WHERE p1.f1 = p2.f1;

-- Has points greater than or equal to path
SELECT p1.f1, p2.f1 FROM PATH_TBL p1, PATH_TBL p2 WHERE p1.f1 >= p2.f1;

-- Has points greater than path
SELECT p1.f1, p2.f1 FROM PATH_TBL p1, PATH_TBL p2 WHERE p1.f1 > p2.f1;

-- Add path
SELECT p1.f1, p2.f1, p1.f1 + p2.f1 FROM PATH_TBL p1, PATH_TBL p2;

-- Add point
SELECT p.f1, p1.f1, p.f1 + p1.f1 FROM PATH_TBL p, POINT_TBL p1;

-- Subtract point
SELECT p.f1, p1.f1, p.f1 - p1.f1 FROM PATH_TBL p, POINT_TBL p1;

-- Multiply with point
SELECT p.f1, p1.f1, p.f1 * p1.f1 FROM PATH_TBL p, POINT_TBL p1;

-- Divide by point
SELECT p.f1, p1.f1, p.f1 / p1.f1 FROM PATH_TBL p, POINT_TBL p1 WHERE p1.f1[0] BETWEEN 1 AND 1000;

-- Division by 0 error
SELECT p.f1, p1.f1, p.f1 / p1.f1 FROM PATH_TBL p, POINT_TBL p1 WHERE p1.f1 ~= '(0,0)'::point;

-- Distance to path
SELECT p1.f1, p2.f1, p1.f1 <-> p2.f1 FROM PATH_TBL p1, PATH_TBL p2;

--
-- Polygons
--

-- containment
SELECT p.f1, poly.f1, poly.f1 @> p.f1 AS contains
   FROM POLYGON_TBL poly, POINT_TBL p;

SELECT p.f1, poly.f1, p.f1 <@ poly.f1 AS contained
   FROM POLYGON_TBL poly, POINT_TBL p;

SELECT npoints(f1) AS npoints, f1 AS polygon
   FROM POLYGON_TBL;

SELECT polygon(f1)
   FROM BOX_TBL;

SELECT polygon(f1)
   FROM PATH_TBL WHERE isclosed(f1);

SELECT f1 AS open_path, polygon( pclose(f1)) AS polygon
   FROM PATH_TBL
   WHERE isopen(f1);

-- To box
SELECT f1, f1::box FROM POLYGON_TBL;

-- To path
SELECT f1, f1::path FROM POLYGON_TBL;

-- Same as polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 ~= p2.f1;

-- Contained by polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 <@ p2.f1;

-- Contains polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 @> p2.f1;

-- Overlap with polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 && p2.f1;

-- Left of polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 << p2.f1;

-- Overlap of left of polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 &< p2.f1;

-- Right of polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 >> p2.f1;

-- Overlap of right of polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 &> p2.f1;

-- Below polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 <<| p2.f1;

-- Overlap or below polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 &<| p2.f1;

-- Above polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 |>> p2.f1;

-- Overlap or above polygon
SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 |&> p2.f1;

-- Distance to polygon
SELECT p1.f1, p2.f1, p1.f1 <-> p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2;

--
-- Circles
--

SELECT circle(f1, 50.0)
   FROM POINT_TBL;

SELECT circle(f1)
   FROM BOX_TBL;

SELECT circle(f1)
   FROM POLYGON_TBL
   WHERE (# f1) >= 3;

SELECT c1.f1 AS circle, p1.f1 AS point, (p1.f1 <-> c1.f1) AS distance
   FROM CIRCLE_TBL c1, POINT_TBL p1
   WHERE (p1.f1 <-> c1.f1) > 0
   ORDER BY distance, area(c1.f1), p1.f1[0];

-- To polygon
SELECT f1, f1::polygon FROM CIRCLE_TBL WHERE f1 >= '<(0,0),1>';

-- To polygon with less points
SELECT f1, polygon(8, f1) FROM CIRCLE_TBL WHERE f1 >= '<(0,0),1>';

-- Error for insufficient number of points
SELECT f1, polygon(1, f1) FROM CIRCLE_TBL WHERE f1 >= '<(0,0),1>';

-- Zero radius error
SELECT f1, polygon(10, f1) FROM CIRCLE_TBL WHERE f1 < '<(0,0),1>';

-- Same as circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 ~= c2.f1;

-- Overlap with circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 && c2.f1;

-- Overlap or left of circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 &< c2.f1;

-- Left of circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 << c2.f1;

-- Right of circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 >> c2.f1;

-- Overlap or right of circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 &> c2.f1;

-- Contained by circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 <@ c2.f1;

-- Contain by circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 @> c2.f1;

-- Below circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 <<| c2.f1;

-- Above circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 |>> c2.f1;

-- Overlap or below circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 &<| c2.f1;

-- Overlap or above circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 |&> c2.f1;

-- Area equal with circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 = c2.f1;

-- Area not equal with circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 != c2.f1;

-- Area less than circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 < c2.f1;

-- Area greater than circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 > c2.f1;

-- Area less than or equal circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 <= c2.f1;

-- Area greater than or equal circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 >= c2.f1;

-- Area less than circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 < c2.f1;

-- Area greater than circle
SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 < c2.f1;

-- Add point
SELECT c.f1, p.f1, c.f1 + p.f1 FROM CIRCLE_TBL c, POINT_TBL p;

-- Subtract point
SELECT c.f1, p.f1, c.f1 - p.f1 FROM CIRCLE_TBL c, POINT_TBL p;

-- Multiply with point
SELECT c.f1, p.f1, c.f1 * p.f1 FROM CIRCLE_TBL c, POINT_TBL p;

-- Divide by point
SELECT c.f1, p.f1, c.f1 / p.f1 FROM CIRCLE_TBL c, POINT_TBL p WHERE p.f1[0] BETWEEN 1 AND 1000;

-- Overflow error
SELECT c.f1, p.f1, c.f1 / p.f1 FROM CIRCLE_TBL c, POINT_TBL p WHERE p.f1[0] > 1000;

-- Division by 0 error
SELECT c.f1, p.f1, c.f1 / p.f1 FROM CIRCLE_TBL c, POINT_TBL p WHERE p.f1 ~= '(0,0)'::point;

-- Distance to polygon
SELECT c.f1, p.f1, c.f1 <-> p.f1 FROM CIRCLE_TBL c, POLYGON_TBL p;

-- Check index behavior for circles

CREATE INDEX gcircleind ON circle_tbl USING gist (f1);

SELECT * FROM circle_tbl WHERE f1 && circle(point(1,-2), 1)
    ORDER BY area(f1);

EXPLAIN (COSTS OFF)
SELECT * FROM circle_tbl WHERE f1 && circle(point(1,-2), 1)
    ORDER BY area(f1);
SELECT * FROM circle_tbl WHERE f1 && circle(point(1,-2), 1)
    ORDER BY area(f1);

-- Check index behavior for polygons

CREATE INDEX gpolygonind ON polygon_tbl USING gist (f1);

SELECT * FROM polygon_tbl WHERE f1 @> '((1,1),(2,2),(2,1))'::polygon
    ORDER BY (poly_center(f1))[0];

EXPLAIN (COSTS OFF)
SELECT * FROM polygon_tbl WHERE f1 @> '((1,1),(2,2),(2,1))'::polygon
    ORDER BY (poly_center(f1))[0];
SELECT * FROM polygon_tbl WHERE f1 @> '((1,1),(2,2),(2,1))'::polygon
    ORDER BY (poly_center(f1))[0];

-- test non-error-throwing API for some core types
SELECT pg_input_is_valid('(1', 'circle');
SELECT * FROM pg_input_error_info('1,', 'circle');
SELECT pg_input_is_valid('(1,2),-1', 'circle');
SELECT * FROM pg_input_error_info('(1,2),-1', 'circle');
-- END setup from geometry 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from create_index_spgist 
--
-- SP-GiST index tests
--

CREATE TABLE quad_point_tbl AS
    SELECT point(unique1,unique2) AS p FROM tenk1;

INSERT INTO quad_point_tbl
    SELECT '(333.0,400.0)'::point FROM generate_series(1,1000);

INSERT INTO quad_point_tbl VALUES (NULL), (NULL), (NULL);

CREATE INDEX sp_quad_ind ON quad_point_tbl USING spgist (p);

CREATE TABLE kd_point_tbl AS SELECT * FROM quad_point_tbl;

CREATE INDEX sp_kd_ind ON kd_point_tbl USING spgist (p kd_point_ops);

CREATE TABLE radix_text_tbl AS
    SELECT name AS t FROM road WHERE name !~ '^[0-9]';

INSERT INTO radix_text_tbl
    SELECT 'P0123456789abcdef' FROM generate_series(1,1000);
INSERT INTO radix_text_tbl VALUES ('P0123456789abcde');
INSERT INTO radix_text_tbl VALUES ('P0123456789abcdefF');

CREATE INDEX sp_radix_ind ON radix_text_tbl USING spgist (t);

-- get non-indexed results for comparison purposes

SET enable_seqscan = ON;
SET enable_indexscan = OFF;
SET enable_bitmapscan = OFF;

SELECT count(*) FROM quad_point_tbl WHERE p IS NULL;

SELECT count(*) FROM quad_point_tbl WHERE p IS NOT NULL;

SELECT count(*) FROM quad_point_tbl;

SELECT count(*) FROM quad_point_tbl WHERE p <@ box '(200,200,1000,1000)';

SELECT count(*) FROM quad_point_tbl WHERE box '(200,200,1000,1000)' @> p;

SELECT count(*) FROM quad_point_tbl WHERE p << '(5000, 4000)';

SELECT count(*) FROM quad_point_tbl WHERE p >> '(5000, 4000)';

SELECT count(*) FROM quad_point_tbl WHERE p <<| '(5000, 4000)';

SELECT count(*) FROM quad_point_tbl WHERE p |>> '(5000, 4000)';

SELECT count(*) FROM quad_point_tbl WHERE p ~= '(4585, 365)';

CREATE TEMP TABLE quad_point_tbl_ord_seq1 AS
SELECT row_number() OVER (ORDER BY p <-> '0,0') n, p <-> '0,0' dist, p
FROM quad_point_tbl;

CREATE TEMP TABLE quad_point_tbl_ord_seq2 AS
SELECT row_number() OVER (ORDER BY p <-> '0,0') n, p <-> '0,0' dist, p
FROM quad_point_tbl WHERE p <@ box '(200,200,1000,1000)';

CREATE TEMP TABLE quad_point_tbl_ord_seq3 AS
SELECT row_number() OVER (ORDER BY p <-> '333,400') n, p <-> '333,400' dist, p
FROM quad_point_tbl WHERE p IS NOT NULL;

SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcdef';

SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcde';

SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcdefF';

SELECT count(*) FROM radix_text_tbl WHERE t <    'Aztec                         Ct  ';

SELECT count(*) FROM radix_text_tbl WHERE t ~<~  'Aztec                         Ct  ';

SELECT count(*) FROM radix_text_tbl WHERE t <=   'Aztec                         Ct  ';

SELECT count(*) FROM radix_text_tbl WHERE t ~<=~ 'Aztec                         Ct  ';

SELECT count(*) FROM radix_text_tbl WHERE t =    'Aztec                         Ct  ';

SELECT count(*) FROM radix_text_tbl WHERE t =    'Worth                         St  ';

SELECT count(*) FROM radix_text_tbl WHERE t >=   'Worth                         St  ';

SELECT count(*) FROM radix_text_tbl WHERE t ~>=~ 'Worth                         St  ';

SELECT count(*) FROM radix_text_tbl WHERE t >    'Worth                         St  ';

SELECT count(*) FROM radix_text_tbl WHERE t ~>~  'Worth                         St  ';

SELECT count(*) FROM radix_text_tbl WHERE t ^@  'Worth';

-- Now check the results from plain indexscan
SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p IS NULL;
SELECT count(*) FROM quad_point_tbl WHERE p IS NULL;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p IS NOT NULL;
SELECT count(*) FROM quad_point_tbl WHERE p IS NOT NULL;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl;
SELECT count(*) FROM quad_point_tbl;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p <@ box '(200,200,1000,1000)';
SELECT count(*) FROM quad_point_tbl WHERE p <@ box '(200,200,1000,1000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE box '(200,200,1000,1000)' @> p;
SELECT count(*) FROM quad_point_tbl WHERE box '(200,200,1000,1000)' @> p;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p << '(5000, 4000)';
SELECT count(*) FROM quad_point_tbl WHERE p << '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p >> '(5000, 4000)';
SELECT count(*) FROM quad_point_tbl WHERE p >> '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p <<| '(5000, 4000)';
SELECT count(*) FROM quad_point_tbl WHERE p <<| '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p |>> '(5000, 4000)';
SELECT count(*) FROM quad_point_tbl WHERE p |>> '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p ~= '(4585, 365)';
SELECT count(*) FROM quad_point_tbl WHERE p ~= '(4585, 365)';

EXPLAIN (COSTS OFF)
SELECT row_number() OVER (ORDER BY p <-> '0,0') n, p <-> '0,0' dist, p
FROM quad_point_tbl;
CREATE TEMP TABLE quad_point_tbl_ord_idx1 AS
SELECT row_number() OVER (ORDER BY p <-> '0,0') n, p <-> '0,0' dist, p
FROM quad_point_tbl;
SELECT * FROM quad_point_tbl_ord_seq1 seq FULL JOIN quad_point_tbl_ord_idx1 idx
ON seq.n = idx.n
WHERE seq.dist IS DISTINCT FROM idx.dist;

EXPLAIN (COSTS OFF)
SELECT row_number() OVER (ORDER BY p <-> '0,0') n, p <-> '0,0' dist, p
FROM quad_point_tbl WHERE p <@ box '(200,200,1000,1000)';
CREATE TEMP TABLE quad_point_tbl_ord_idx2 AS
SELECT row_number() OVER (ORDER BY p <-> '0,0') n, p <-> '0,0' dist, p
FROM quad_point_tbl WHERE p <@ box '(200,200,1000,1000)';
SELECT * FROM quad_point_tbl_ord_seq2 seq FULL JOIN quad_point_tbl_ord_idx2 idx
ON seq.n = idx.n
WHERE seq.dist IS DISTINCT FROM idx.dist;

EXPLAIN (COSTS OFF)
SELECT row_number() OVER (ORDER BY p <-> '333,400') n, p <-> '333,400' dist, p
FROM quad_point_tbl WHERE p IS NOT NULL;
CREATE TEMP TABLE quad_point_tbl_ord_idx3 AS
SELECT row_number() OVER (ORDER BY p <-> '333,400') n, p <-> '333,400' dist, p
FROM quad_point_tbl WHERE p IS NOT NULL;
SELECT * FROM quad_point_tbl_ord_seq3 seq FULL JOIN quad_point_tbl_ord_idx3 idx
ON seq.n = idx.n
WHERE seq.dist IS DISTINCT FROM idx.dist;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p <@ box '(200,200,1000,1000)';
SELECT count(*) FROM kd_point_tbl WHERE p <@ box '(200,200,1000,1000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE box '(200,200,1000,1000)' @> p;
SELECT count(*) FROM kd_point_tbl WHERE box '(200,200,1000,1000)' @> p;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p << '(5000, 4000)';
SELECT count(*) FROM kd_point_tbl WHERE p << '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p >> '(5000, 4000)';
SELECT count(*) FROM kd_point_tbl WHERE p >> '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p <<| '(5000, 4000)';
SELECT count(*) FROM kd_point_tbl WHERE p <<| '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p |>> '(5000, 4000)';
SELECT count(*) FROM kd_point_tbl WHERE p |>> '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p ~= '(4585, 365)';
SELECT count(*) FROM kd_point_tbl WHERE p ~= '(4585, 365)';

EXPLAIN (COSTS OFF)
SELECT row_number() OVER (ORDER BY p <-> '0,0') n, p <-> '0,0' dist, p
FROM kd_point_tbl;
CREATE TEMP TABLE kd_point_tbl_ord_idx1 AS
SELECT row_number() OVER (ORDER BY p <-> '0,0') n, p <-> '0,0' dist, p
FROM kd_point_tbl;
SELECT * FROM quad_point_tbl_ord_seq1 seq FULL JOIN kd_point_tbl_ord_idx1 idx
ON seq.n = idx.n
WHERE seq.dist IS DISTINCT FROM idx.dist;

EXPLAIN (COSTS OFF)
SELECT row_number() OVER (ORDER BY p <-> '0,0') n, p <-> '0,0' dist, p
FROM kd_point_tbl WHERE p <@ box '(200,200,1000,1000)';
CREATE TEMP TABLE kd_point_tbl_ord_idx2 AS
SELECT row_number() OVER (ORDER BY p <-> '0,0') n, p <-> '0,0' dist, p
FROM kd_point_tbl WHERE p <@ box '(200,200,1000,1000)';
SELECT * FROM quad_point_tbl_ord_seq2 seq FULL JOIN kd_point_tbl_ord_idx2 idx
ON seq.n = idx.n
WHERE seq.dist IS DISTINCT FROM idx.dist;

EXPLAIN (COSTS OFF)
SELECT row_number() OVER (ORDER BY p <-> '333,400') n, p <-> '333,400' dist, p
FROM kd_point_tbl WHERE p IS NOT NULL;
CREATE TEMP TABLE kd_point_tbl_ord_idx3 AS
SELECT row_number() OVER (ORDER BY p <-> '333,400') n, p <-> '333,400' dist, p
FROM kd_point_tbl WHERE p IS NOT NULL;
SELECT * FROM quad_point_tbl_ord_seq3 seq FULL JOIN kd_point_tbl_ord_idx3 idx
ON seq.n = idx.n
WHERE seq.dist IS DISTINCT FROM idx.dist;

-- test KNN scan with included columns
-- the distance numbers are not exactly the same across platforms
SET extra_float_digits = 0;
CREATE INDEX ON quad_point_tbl_ord_seq1 USING spgist(p) INCLUDE(dist);
EXPLAIN (COSTS OFF)
SELECT p, dist FROM quad_point_tbl_ord_seq1 ORDER BY p <-> '0,0' LIMIT 10;
SELECT p, dist FROM quad_point_tbl_ord_seq1 ORDER BY p <-> '0,0' LIMIT 10;
RESET extra_float_digits;

-- check ORDER BY distance to NULL
SELECT (SELECT p FROM kd_point_tbl ORDER BY p <-> pt, p <-> '0,0' LIMIT 1)
FROM (VALUES (point '1,2'), (NULL), ('1234,5678')) pts(pt);


EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcdef';
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcdef';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcde';
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcde';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcdefF';
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcdefF';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t <    'Aztec                         Ct  ';
SELECT count(*) FROM radix_text_tbl WHERE t <    'Aztec                         Ct  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t ~<~  'Aztec                         Ct  ';
SELECT count(*) FROM radix_text_tbl WHERE t ~<~  'Aztec                         Ct  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t <=   'Aztec                         Ct  ';
SELECT count(*) FROM radix_text_tbl WHERE t <=   'Aztec                         Ct  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t ~<=~ 'Aztec                         Ct  ';
SELECT count(*) FROM radix_text_tbl WHERE t ~<=~ 'Aztec                         Ct  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t =    'Aztec                         Ct  ';
SELECT count(*) FROM radix_text_tbl WHERE t =    'Aztec                         Ct  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t =    'Worth                         St  ';
SELECT count(*) FROM radix_text_tbl WHERE t =    'Worth                         St  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t >=   'Worth                         St  ';
SELECT count(*) FROM radix_text_tbl WHERE t >=   'Worth                         St  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t ~>=~ 'Worth                         St  ';
SELECT count(*) FROM radix_text_tbl WHERE t ~>=~ 'Worth                         St  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t >    'Worth                         St  ';
SELECT count(*) FROM radix_text_tbl WHERE t >    'Worth                         St  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t ~>~  'Worth                         St  ';
SELECT count(*) FROM radix_text_tbl WHERE t ~>~  'Worth                         St  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t ^@	 'Worth';
SELECT count(*) FROM radix_text_tbl WHERE t ^@	 'Worth';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE starts_with(t, 'Worth');
SELECT count(*) FROM radix_text_tbl WHERE starts_with(t, 'Worth');

-- Now check the results from bitmap indexscan
SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p IS NULL;
SELECT count(*) FROM quad_point_tbl WHERE p IS NULL;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p IS NOT NULL;
SELECT count(*) FROM quad_point_tbl WHERE p IS NOT NULL;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl;
SELECT count(*) FROM quad_point_tbl;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p <@ box '(200,200,1000,1000)';
SELECT count(*) FROM quad_point_tbl WHERE p <@ box '(200,200,1000,1000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE box '(200,200,1000,1000)' @> p;
SELECT count(*) FROM quad_point_tbl WHERE box '(200,200,1000,1000)' @> p;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p << '(5000, 4000)';
SELECT count(*) FROM quad_point_tbl WHERE p << '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p >> '(5000, 4000)';
SELECT count(*) FROM quad_point_tbl WHERE p >> '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p <<| '(5000, 4000)';
SELECT count(*) FROM quad_point_tbl WHERE p <<| '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p |>> '(5000, 4000)';
SELECT count(*) FROM quad_point_tbl WHERE p |>> '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM quad_point_tbl WHERE p ~= '(4585, 365)';
SELECT count(*) FROM quad_point_tbl WHERE p ~= '(4585, 365)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p <@ box '(200,200,1000,1000)';
SELECT count(*) FROM kd_point_tbl WHERE p <@ box '(200,200,1000,1000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE box '(200,200,1000,1000)' @> p;
SELECT count(*) FROM kd_point_tbl WHERE box '(200,200,1000,1000)' @> p;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p << '(5000, 4000)';
SELECT count(*) FROM kd_point_tbl WHERE p << '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p >> '(5000, 4000)';
SELECT count(*) FROM kd_point_tbl WHERE p >> '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p <<| '(5000, 4000)';
SELECT count(*) FROM kd_point_tbl WHERE p <<| '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p |>> '(5000, 4000)';
SELECT count(*) FROM kd_point_tbl WHERE p |>> '(5000, 4000)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM kd_point_tbl WHERE p ~= '(4585, 365)';
SELECT count(*) FROM kd_point_tbl WHERE p ~= '(4585, 365)';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcdef';
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcdef';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcde';
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcde';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcdefF';
SELECT count(*) FROM radix_text_tbl WHERE t = 'P0123456789abcdefF';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t <    'Aztec                         Ct  ';
SELECT count(*) FROM radix_text_tbl WHERE t <    'Aztec                         Ct  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t ~<~  'Aztec                         Ct  ';
SELECT count(*) FROM radix_text_tbl WHERE t ~<~  'Aztec                         Ct  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t <=   'Aztec                         Ct  ';
SELECT count(*) FROM radix_text_tbl WHERE t <=   'Aztec                         Ct  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t ~<=~ 'Aztec                         Ct  ';
SELECT count(*) FROM radix_text_tbl WHERE t ~<=~ 'Aztec                         Ct  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t =    'Aztec                         Ct  ';
SELECT count(*) FROM radix_text_tbl WHERE t =    'Aztec                         Ct  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t =    'Worth                         St  ';
SELECT count(*) FROM radix_text_tbl WHERE t =    'Worth                         St  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t >=   'Worth                         St  ';
SELECT count(*) FROM radix_text_tbl WHERE t >=   'Worth                         St  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t ~>=~ 'Worth                         St  ';
SELECT count(*) FROM radix_text_tbl WHERE t ~>=~ 'Worth                         St  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t >    'Worth                         St  ';
SELECT count(*) FROM radix_text_tbl WHERE t >    'Worth                         St  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t ~>~  'Worth                         St  ';
SELECT count(*) FROM radix_text_tbl WHERE t ~>~  'Worth                         St  ';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE t ^@	 'Worth';
SELECT count(*) FROM radix_text_tbl WHERE t ^@	 'Worth';

EXPLAIN (COSTS OFF)
SELECT count(*) FROM radix_text_tbl WHERE starts_with(t, 'Worth');
SELECT count(*) FROM radix_text_tbl WHERE starts_with(t, 'Worth');

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;
-- END setup from create_index_spgist 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from hash_index 
--
-- HASH_INDEX
--

-- directory paths are passed to us in environment variables
-- \getenv abs_srcdir PG_ABS_SRCDIR

CREATE TABLE hash_i4_heap (
	seqno 		int4,
	random 		int4
);

CREATE TABLE hash_name_heap (
	seqno 		int4,
	random 		name
);

CREATE TABLE hash_txt_heap (
	seqno 		int4,
	random 		text
);

CREATE TABLE hash_f8_heap (
	seqno		int4,
	random 		float8
);

-- \set filename /* REPLACED */PG_ABS_SRCDIR '/data/hash.data'
COPY hash_i4_heap FROM /* REPLACED */PG_ABS_SRCDIR '/data/hash.data';
COPY hash_name_heap FROM /* REPLACED */PG_ABS_SRCDIR '/data/hash.data';
COPY hash_txt_heap FROM /* REPLACED */PG_ABS_SRCDIR '/data/hash.data';
COPY hash_f8_heap FROM /* REPLACED */PG_ABS_SRCDIR '/data/hash.data';

-- the data in this file has a lot of duplicates in the index key
-- fields, leading to long bucket chains and lots of table expansion.
-- this is therefore a stress test of the bucket overflow code (unlike
-- the data in hash.data, which has unique index keys).
--
-- \set filename /* REPLACED */PG_ABS_SRCDIR /* REPLACED */''/data/hashovfl.data/* REPLACED */''
-- COPY hash_ovfl_heap FROM :/* REPLACED */''filename/* REPLACED */'' /* REPLACED */,

ANALYZE hash_i4_heap;
ANALYZE hash_name_heap;
ANALYZE hash_txt_heap;
ANALYZE hash_f8_heap;

CREATE INDEX hash_i4_index ON hash_i4_heap USING hash (random int4_ops);

CREATE INDEX hash_name_index ON hash_name_heap USING hash (random name_ops);

CREATE INDEX hash_txt_index ON hash_txt_heap USING hash (random text_ops);

CREATE INDEX hash_f8_index ON hash_f8_heap USING hash (random float8_ops)
  WITH (fillfactor=60);

--
-- Also try building functional, expressional, and partial indexes on
-- tables that already contain data.
--
create unique index hash_f8_index_1 on hash_f8_heap(abs(random));
create unique index hash_f8_index_2 on hash_f8_heap((seqno + 1), random);
create unique index hash_f8_index_3 on hash_f8_heap(random) where seqno > 1000;

--
-- hash index
-- grep 843938989 hash.data
--
SELECT * FROM hash_i4_heap
   WHERE hash_i4_heap.random = 843938989;

--
-- hash index
-- grep 66766766 hash.data
--
SELECT * FROM hash_i4_heap
   WHERE hash_i4_heap.random = 66766766;

--
-- hash index
-- grep 1505703298 hash.data
--
SELECT * FROM hash_name_heap
   WHERE hash_name_heap.random = '1505703298'::name;

--
-- hash index
-- grep 7777777 hash.data
--
SELECT * FROM hash_name_heap
   WHERE hash_name_heap.random = '7777777'::name;

--
-- hash index
-- grep 1351610853 hash.data
--
SELECT * FROM hash_txt_heap
   WHERE hash_txt_heap.random = '1351610853'::text;

--
-- hash index
-- grep 111111112222222233333333 hash.data
--
SELECT * FROM hash_txt_heap
   WHERE hash_txt_heap.random = '111111112222222233333333'::text;

--
-- hash index
-- grep 444705537 hash.data
--
SELECT * FROM hash_f8_heap
   WHERE hash_f8_heap.random = '444705537'::float8;

--
-- hash index
-- grep 88888888 hash.data
--
SELECT * FROM hash_f8_heap
   WHERE hash_f8_heap.random = '88888888'::float8;

--
-- hash index
-- grep /* REPLACED */''^90[^0-9]/* REPLACED */'' hashovfl.data
--
-- SELECT count(*) AS i988 FROM hash_ovfl_heap
--    WHERE x = 90 /* REPLACED */,

--
-- hash index
-- grep /* REPLACED */''^1000[^0-9]/* REPLACED */'' hashovfl.data
--
-- SELECT count(*) AS i0 FROM hash_ovfl_heap
--    WHERE x = 1000 /* REPLACED */,

--
-- HASH
--
UPDATE hash_i4_heap
   SET random = 1
   WHERE hash_i4_heap.seqno = 1492;

SELECT h.seqno AS i1492, h.random AS i1
   FROM hash_i4_heap h
   WHERE h.random = 1;

UPDATE hash_i4_heap
   SET seqno = 20000
   WHERE hash_i4_heap.random = 1492795354;

SELECT h.seqno AS i20000
   FROM hash_i4_heap h
   WHERE h.random = 1492795354;

UPDATE hash_name_heap
   SET random = '0123456789abcdef'::name
   WHERE hash_name_heap.seqno = 6543;

SELECT h.seqno AS i6543, h.random AS c0_to_f
   FROM hash_name_heap h
   WHERE h.random = '0123456789abcdef'::name;

UPDATE hash_name_heap
   SET seqno = 20000
   WHERE hash_name_heap.random = '76652222'::name;

--
-- this is the row we just replaced /* REPLACED */, index scan should return zero rows
--
SELECT h.seqno AS emptyset
   FROM hash_name_heap h
   WHERE h.random = '76652222'::name;

UPDATE hash_txt_heap
   SET random = '0123456789abcdefghijklmnop'::text
   WHERE hash_txt_heap.seqno = 4002;

SELECT h.seqno AS i4002, h.random AS c0_to_p
   FROM hash_txt_heap h
   WHERE h.random = '0123456789abcdefghijklmnop'::text;

UPDATE hash_txt_heap
   SET seqno = 20000
   WHERE hash_txt_heap.random = '959363399'::text;

SELECT h.seqno AS t20000
   FROM hash_txt_heap h
   WHERE h.random = '959363399'::text;

UPDATE hash_f8_heap
   SET random = '-1234.1234'::float8
   WHERE hash_f8_heap.seqno = 8906;

SELECT h.seqno AS i8096, h.random AS f1234_1234
   FROM hash_f8_heap h
   WHERE h.random = '-1234.1234'::float8;

UPDATE hash_f8_heap
   SET seqno = 20000
   WHERE hash_f8_heap.random = '488912369'::float8;

SELECT h.seqno AS f20000
   FROM hash_f8_heap h
   WHERE h.random = '488912369'::float8;

-- UPDATE hash_ovfl_heap
--    SET x = 1000
--   WHERE x = 90 /* REPLACED */,

-- this vacuums the index as well
-- VACUUM hash_ovfl_heap /* REPLACED */,

-- SELECT count(*) AS i0 FROM hash_ovfl_heap
--   WHERE x = 90 /* REPLACED */,

-- SELECT count(*) AS i988 FROM hash_ovfl_heap
--  WHERE x = 1000 /* REPLACED */,

--
-- Cause some overflow insert and splits.
--
CREATE TABLE hash_split_heap (keycol INT);
INSERT INTO hash_split_heap SELECT 1 FROM generate_series(1, 500) a;
CREATE INDEX hash_split_index on hash_split_heap USING HASH (keycol);
INSERT INTO hash_split_heap SELECT 1 FROM generate_series(1, 5000) a;

-- Let/* REPLACED */''s do a backward scan.
BEGIN;
SET enable_seqscan = OFF;
SET enable_bitmapscan = OFF;

DECLARE c CURSOR FOR SELECT * from hash_split_heap WHERE keycol = 1;
MOVE FORWARD ALL FROM c;
MOVE BACKWARD 10000 FROM c;
MOVE BACKWARD ALL FROM c;
CLOSE c;
END;

-- DELETE, INSERT, VACUUM.
DELETE FROM hash_split_heap WHERE keycol = 1;
INSERT INTO hash_split_heap SELECT a/2 FROM generate_series(1, 25000) a;

VACUUM hash_split_heap;

-- Rebuild the index using a different fillfactor
ALTER INDEX hash_split_index SET (fillfactor = 10);
REINDEX INDEX hash_split_index;

-- Clean up.
DROP TABLE hash_split_heap;

-- Testcases for removing overflow pages.
CREATE TABLE hash_cleanup_heap(keycol INT);
CREATE INDEX hash_cleanup_index on hash_cleanup_heap USING HASH (keycol);

-- Insert tuples to both the primary bucket page and overflow pages.
INSERT INTO hash_cleanup_heap SELECT 1 FROM generate_series(1, 500) as i;

-- Fill overflow pages by /* REPLACED */''dead/* REPLACED */'' tuples.
BEGIN;
INSERT INTO hash_cleanup_heap SELECT 1 FROM generate_series(1, 1000) as i;
ROLLBACK;

-- Checkpoint will ensure that all hash buffers are cleaned before we try
-- to remove overflow pages.
CHECKPOINT;

-- This will squeeze the bucket and remove overflow pages.
VACUUM hash_cleanup_heap;

TRUNCATE hash_cleanup_heap;

-- Insert a few tuples so that the primary bucket page doesn/* REPLACED */''t get full and
-- tuples can be moved to it.
INSERT INTO hash_cleanup_heap SELECT 1 FROM generate_series(1, 50) as i;

-- Fill overflow pages by /* REPLACED */''dead/* REPLACED */'' tuples.
BEGIN;
INSERT INTO hash_cleanup_heap SELECT 1 FROM generate_series(1, 1500) as i;
ROLLBACK;

-- And insert some tuples again. During squeeze operation, these will be moved
-- to the primary bucket allowing to test freeing intermediate overflow pages.
INSERT INTO hash_cleanup_heap SELECT 1 FROM generate_series(1, 500) as i;

CHECKPOINT;
VACUUM hash_cleanup_heap;

TRUNCATE hash_cleanup_heap;

-- Insert tuples to both the primary bucket page and overflow pages.
INSERT INTO hash_cleanup_heap SELECT 1 FROM generate_series(1, 500) as i;
-- Fill overflow pages by /* REPLACED */''dead/* REPLACED */'' tuples.
BEGIN;
INSERT INTO hash_cleanup_heap SELECT 1 FROM generate_series(1, 1500) as i;
ROLLBACK;
-- And insert some tuples again. During squeeze operation, these will be moved
-- to other overflow pages and also allow overflow pages filled by dead tuples
-- to be freed. Note the main purpose of this test is to test the case where
-- we don/* REPLACED */''t need to move any tuple from the overflow page being freed.
INSERT INTO hash_cleanup_heap SELECT 1 FROM generate_series(1, 50) as i;

CHECKPOINT;
VACUUM hash_cleanup_heap;

-- Clean up.
DROP TABLE hash_cleanup_heap;

-- Index on temp table.
CREATE TEMP TABLE hash_temp_heap (x int, y int);
INSERT INTO hash_temp_heap VALUES (1,1);
CREATE INDEX hash_idx ON hash_temp_heap USING hash (x);
DROP TABLE hash_temp_heap CASCADE;

-- Float4 type.
CREATE TABLE hash_heap_float4 (x float4, y int);
INSERT INTO hash_heap_float4 VALUES (1.1,1);
CREATE INDEX hash_idx ON hash_heap_float4 USING hash (x);
DROP TABLE hash_heap_float4 CASCADE;

-- Test out-of-range fillfactor values
CREATE INDEX hash_f8_index2 ON hash_f8_heap USING hash (random float8_ops)
	WITH (fillfactor=9);
CREATE INDEX hash_f8_index2 ON hash_f8_heap USING hash (random float8_ops)
	WITH (fillfactor=101);
-- END setup from hash_index 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from brin 
CREATE TABLE brintest (byteacol bytea,
	charcol "char",
	namecol name,
	int8col bigint,
	int2col smallint,
	int4col integer,
	textcol text,
	oidcol oid,
	tidcol tid,
	float4col real,
	float8col double precision,
	macaddrcol macaddr,
	inetcol inet,
	cidrcol cidr,
	bpcharcol character,
	datecol date,
	timecol time without time zone,
	timestampcol timestamp without time zone,
	timestamptzcol timestamp with time zone,
	intervalcol interval,
	timetzcol time with time zone,
	bitcol bit(10),
	varbitcol bit varying(16),
	numericcol numeric,
	uuidcol uuid,
	int4rangecol int4range,
	lsncol pg_lsn,
	boxcol box
) WITH (fillfactor=10, autovacuum_enabled=off);

INSERT INTO brintest SELECT
	repeat(stringu1, 8)::bytea,
	substr(stringu1, 1, 1)::"char",
	stringu1::name, 142857 * tenthous,
	thousand,
	twothousand,
	repeat(stringu1, 8),
	unique1::oid,
	format('(%s,%s)', tenthous, twenty)::tid,
	(four + 1.0)/(hundred+1),
	odd::float8 / (tenthous + 1),
	format('%s:00:%s:00:%s:00', to_hex(odd), to_hex(even), to_hex(hundred))::macaddr,
	inet '10.2.3.4/24' + tenthous,
	cidr '10.2.3/24' + tenthous,
	substr(stringu1, 1, 1)::bpchar,
	date '1995-08-15' + tenthous,
	time '01:20:30' + thousand * interval '18.5 second',
	timestamp '1942-07-23 03:05:09' + tenthous * interval '36.38 hours',
	timestamptz '1972-10-10 03:00' + thousand * interval '1 hour',
	justify_days(justify_hours(tenthous * interval '12 minutes')),
	timetz '01:30:20+02' + hundred * interval '15 seconds',
	thousand::bit(10),
	tenthous::bit(16)::varbit,
	tenthous::numeric(36,30) * fivethous * even / (hundred + 1),
	format('%s%s-%s-%s-%s-%s%s%s', to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'))::uuid,
	int4range(thousand, twothousand),
	format('%s/%s%s', odd, even, tenthous)::pg_lsn,
	box(point(odd, even), point(thousand, twothousand))
FROM tenk1 ORDER BY unique2 LIMIT 100;

-- throw in some NULL/* REPLACED */''s and different values
INSERT INTO brintest (inetcol, cidrcol, int4rangecol) SELECT
	inet 'fe80::6e40:8ff:fea9:8c46' + tenthous,
	cidr 'fe80::6e40:8ff:fea9:8c46' + tenthous,
	'empty'::int4range
FROM tenk1 ORDER BY thousand, tenthous LIMIT 25;

CREATE INDEX brinidx ON brintest USING brin (
	byteacol,
	charcol,
	namecol,
	int8col,
	int2col,
	int4col,
	textcol,
	oidcol,
	tidcol,
	float4col,
	float8col,
	macaddrcol,
	inetcol inet_inclusion_ops,
	inetcol inet_minmax_ops,
	cidrcol inet_inclusion_ops,
	cidrcol inet_minmax_ops,
	bpcharcol,
	datecol,
	timecol,
	timestampcol,
	timestamptzcol,
	intervalcol,
	timetzcol,
	bitcol,
	varbitcol,
	numericcol,
	uuidcol,
	int4rangecol,
	lsncol,
	boxcol
) with (pages_per_range = 1);

CREATE TABLE brinopers (colname name, typ text,
	op text[], value text[], matches int[],
	check (cardinality(op) = cardinality(value)),
	check (cardinality(op) = cardinality(matches)));

INSERT INTO brinopers VALUES
	('byteacol', 'bytea',
	 '{>, >=, =, <=, <}',
	 '{AAAAAA, AAAAAA, BNAAAABNAAAABNAAAABNAAAABNAAAABNAAAABNAAAABNAAAA, ZZZZZZ, ZZZZZZ}',
	 '{100, 100, 1, 100, 100}'),
	('charcol', '"char"',
	 '{>, >=, =, <=, <}',
	 '{A, A, M, Z, Z}',
	 '{97, 100, 6, 100, 98}'),
	('namecol', 'name',
	 '{>, >=, =, <=, <}',
	 '{AAAAAA, AAAAAA, MAAAAA, ZZAAAA, ZZAAAA}',
	 '{100, 100, 2, 100, 100}'),
	('int2col', 'int2',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 999, 999}',
	 '{100, 100, 1, 100, 100}'),
	('int2col', 'int4',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 999, 1999}',
	 '{100, 100, 1, 100, 100}'),
	('int2col', 'int8',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 999, 1428427143}',
	 '{100, 100, 1, 100, 100}'),
	('int4col', 'int2',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 1999, 1999}',
	 '{100, 100, 1, 100, 100}'),
	('int4col', 'int4',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 1999, 1999}',
	 '{100, 100, 1, 100, 100}'),
	('int4col', 'int8',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 800, 1999, 1428427143}',
	 '{100, 100, 1, 100, 100}'),
	('int8col', 'int2',
	 '{>, >=}',
	 '{0, 0}',
	 '{100, 100}'),
	('int8col', 'int4',
	 '{>, >=}',
	 '{0, 0}',
	 '{100, 100}'),
	('int8col', 'int8',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 1257141600, 1428427143, 1428427143}',
	 '{100, 100, 1, 100, 100}'),
	('textcol', 'text',
	 '{>, >=, =, <=, <}',
	 '{ABABAB, ABABAB, BNAAAABNAAAABNAAAABNAAAABNAAAABNAAAABNAAAABNAAAA, ZZAAAA, ZZAAAA}',
	 '{100, 100, 1, 100, 100}'),
	('oidcol', 'oid',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 8800, 9999, 9999}',
	 '{100, 100, 1, 100, 100}'),
	('tidcol', 'tid',
	 '{>, >=, =, <=, <}',
	 '{"(0,0)", "(0,0)", "(8800,0)", "(9999,19)", "(9999,19)"}',
	 '{100, 100, 1, 100, 100}'),
	('float4col', 'float4',
	 '{>, >=, =, <=, <}',
	 '{0.0103093, 0.0103093, 1, 1, 1}',
	 '{100, 100, 4, 100, 96}'),
	('float4col', 'float8',
	 '{>, >=, =, <=, <}',
	 '{0.0103093, 0.0103093, 1, 1, 1}',
	 '{100, 100, 4, 100, 96}'),
	('float8col', 'float4',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 0, 1.98, 1.98}',
	 '{99, 100, 1, 100, 100}'),
	('float8col', 'float8',
	 '{>, >=, =, <=, <}',
	 '{0, 0, 0, 1.98, 1.98}',
	 '{99, 100, 1, 100, 100}'),
	('macaddrcol', 'macaddr',
	 '{>, >=, =, <=, <}',
	 '{00:00:01:00:00:00, 00:00:01:00:00:00, 2c:00:2d:00:16:00, ff:fe:00:00:00:00, ff:fe:00:00:00:00}',
	 '{99, 100, 2, 100, 100}'),
	('inetcol', 'inet',
	 '{&&, =, <, <=, >, >=, >>=, >>, <<=, <<}',
	 '{10/8, 10.2.14.231/24, 255.255.255.255, 255.255.255.255, 0.0.0.0, 0.0.0.0, 10.2.14.231/24, 10.2.14.231/25, 10.2.14.231/8, 0/0}',
	 '{100, 1, 100, 100, 125, 125, 2, 2, 100, 100}'),
	('inetcol', 'inet',
	 '{&&, >>=, <<=, =}',
	 '{fe80::6e40:8ff:fea9:a673/32, fe80::6e40:8ff:fea9:8c46, fe80::6e40:8ff:fea9:a673/32, fe80::6e40:8ff:fea9:8c46}',
	 '{25, 1, 25, 1}'),
	('inetcol', 'cidr',
	 '{&&, <, <=, >, >=, >>=, >>, <<=, <<}',
	 '{10/8, 255.255.255.255, 255.255.255.255, 0.0.0.0, 0.0.0.0, 10.2.14/24, 10.2.14/25, 10/8, 0/0}',
	 '{100, 100, 100, 125, 125, 2, 2, 100, 100}'),
	('inetcol', 'cidr',
	 '{&&, >>=, <<=, =}',
	 '{fe80::/32, fe80::6e40:8ff:fea9:8c46, fe80::/32, fe80::6e40:8ff:fea9:8c46}',
	 '{25, 1, 25, 1}'),
	('cidrcol', 'inet',
	 '{&&, =, <, <=, >, >=, >>=, >>, <<=, <<}',
	 '{10/8, 10.2.14/24, 255.255.255.255, 255.255.255.255, 0.0.0.0, 0.0.0.0, 10.2.14.231/24, 10.2.14.231/25, 10.2.14.231/8, 0/0}',
	 '{100, 2, 100, 100, 125, 125, 2, 2, 100, 100}'),
	('cidrcol', 'inet',
	 '{&&, >>=, <<=, =}',
	 '{fe80::6e40:8ff:fea9:a673/32, fe80::6e40:8ff:fea9:8c46, fe80::6e40:8ff:fea9:a673/32, fe80::6e40:8ff:fea9:8c46}',
	 '{25, 1, 25, 1}'),
	('cidrcol', 'cidr',
	 '{&&, =, <, <=, >, >=, >>=, >>, <<=, <<}',
	 '{10/8, 10.2.14/24, 255.255.255.255, 255.255.255.255, 0.0.0.0, 0.0.0.0, 10.2.14/24, 10.2.14/25, 10/8, 0/0}',
	 '{100, 2, 100, 100, 125, 125, 2, 2, 100, 100}'),
	('cidrcol', 'cidr',
	 '{&&, >>=, <<=, =}',
	 '{fe80::/32, fe80::6e40:8ff:fea9:8c46, fe80::/32, fe80::6e40:8ff:fea9:8c46}',
	 '{25, 1, 25, 1}'),
	('bpcharcol', 'bpchar',
	 '{>, >=, =, <=, <}',
	 '{A, A, W, Z, Z}',
	 '{97, 100, 6, 100, 98}'),
	('datecol', 'date',
	 '{>, >=, =, <=, <}',
	 '{1995-08-15, 1995-08-15, 2009-12-01, 2022-12-30, 2022-12-30}',
	 '{100, 100, 1, 100, 100}'),
	('timecol', 'time',
	 '{>, >=, =, <=, <}',
	 '{01:20:30, 01:20:30, 02:28:57, 06:28:31.5, 06:28:31.5}',
	 '{100, 100, 1, 100, 100}'),
	('timestampcol', 'timestamp',
	 '{>, >=, =, <=, <}',
	 '{1942-07-23 03:05:09, 1942-07-23 03:05:09, 1964-03-24 19:26:45, 1984-01-20 22:42:21, 1984-01-20 22:42:21}',
	 '{100, 100, 1, 100, 100}'),
	('timestampcol', 'timestamptz',
	 '{>, >=, =, <=, <}',
	 '{1942-07-23 03:05:09, 1942-07-23 03:05:09, 1964-03-24 19:26:45, 1984-01-20 22:42:21, 1984-01-20 22:42:21}',
	 '{100, 100, 1, 100, 100}'),
	('timestamptzcol', 'timestamptz',
	 '{>, >=, =, <=, <}',
	 '{1972-10-10 03:00:00-04, 1972-10-10 03:00:00-04, 1972-10-19 09:00:00-07, 1972-11-20 19:00:00-03, 1972-11-20 19:00:00-03}',
	 '{100, 100, 1, 100, 100}'),
	('intervalcol', 'interval',
	 '{>, >=, =, <=, <}',
	 '{00:00:00, 00:00:00, 1 mons 13 days 12:24, 2 mons 23 days 07:48:00, 1 year}',
	 '{100, 100, 1, 100, 100}'),
	('timetzcol', 'timetz',
	 '{>, >=, =, <=, <}',
	 '{01:30:20+02, 01:30:20+02, 01:35:50+02, 23:55:05+02, 23:55:05+02}',
	 '{99, 100, 2, 100, 100}'),
	('bitcol', 'bit(10)',
	 '{>, >=, =, <=, <}',
	 '{0000000010, 0000000010, 0011011110, 1111111000, 1111111000}',
	 '{100, 100, 1, 100, 100}'),
	('varbitcol', 'varbit(16)',
	 '{>, >=, =, <=, <}',
	 '{0000000000000100, 0000000000000100, 0001010001100110, 1111111111111000, 1111111111111000}',
	 '{100, 100, 1, 100, 100}'),
	('numericcol', 'numeric',
	 '{>, >=, =, <=, <}',
	 '{0.00, 0.01, 2268164.347826086956521739130434782609, 99470151.9, 99470151.9}',
	 '{100, 100, 1, 100, 100}'),
	('uuidcol', 'uuid',
	 '{>, >=, =, <=, <}',
	 '{00040004-0004-0004-0004-000400040004, 00040004-0004-0004-0004-000400040004, 52225222-5222-5222-5222-522252225222, 99989998-9998-9998-9998-999899989998, 99989998-9998-9998-9998-999899989998}',
	 '{100, 100, 1, 100, 100}'),
	('int4rangecol', 'int4range',
	 '{<<, &<, &&, &>, >>, @>, <@, =, <, <=, >, >=}',
	 '{"[10000,)","[10000,)","(,]","[3,4)","[36,44)","(1500,1501]","[3,4)","[222,1222)","[36,44)","[43,1043)","[367,4466)","[519,)"}',
	 '{53, 53, 53, 53, 50, 22, 72, 1, 74, 75, 34, 21}'),
	('int4rangecol', 'int4range',
	 '{@>, <@, =, <=, >, >=}',
	 '{empty, empty, empty, empty, empty, empty}',
	 '{125, 72, 72, 72, 53, 125}'),
	('int4rangecol', 'int4',
	 '{@>}',
	 '{1500}',
	 '{22}'),
	('lsncol', 'pg_lsn',
	 '{>, >=, =, <=, <, IS, IS NOT}',
	 '{0/1200, 0/1200, 44/455222, 198/1999799, 198/1999799, NULL, NULL}',
	 '{100, 100, 1, 100, 100, 25, 100}'),
	('boxcol', 'point',
	 '{@>}',
	 '{"(500,43)"}',
	 '{11}'),
	('boxcol', 'box',
	 '{<<, &<, &&, &>, >>, <<|, &<|, |&>, |>>, @>, <@, ~=}',
	 '{"((1000,2000),(3000,4000))","((1,2),(3000,4000))","((1,2),(3000,4000))","((1,2),(3000,4000))","((1,2),(3,4))","((1000,2000),(3000,4000))","((1,2000),(3,4000))","((1000,2),(3000,4))","((1,2),(3,4))","((1,2),(300,400))","((1,2),(3000,4000))","((222,1222),(44,45))"}',
	 '{100, 100, 100, 99, 96, 100, 100, 99, 96, 1, 99, 1}');

DO $x$
DECLARE
	r record;
	r2 record;
	cond text;
	idx_ctids tid[];
	ss_ctids tid[];
	count int;
	plan_ok bool;
	plan_line text;
BEGIN
	FOR r IN SELECT colname, oper, typ, value[ordinality], matches[ordinality] FROM brinopers, unnest(op) WITH ORDINALITY AS oper LOOP

		-- prepare the condition
		IF r.value IS NULL THEN
			cond := format('%I %s %L', r.colname, r.oper, r.value);
		ELSE
			cond := format('%I %s %L::%s', r.colname, r.oper, r.value, r.typ);
		END IF;

		-- run the query using the brin index
		SET enable_seqscan = 0;
		SET enable_bitmapscan = 1;

		plan_ok := false;
		FOR plan_line IN EXECUTE format($y$EXPLAIN SELECT array_agg(ctid) FROM brintest WHERE %s $y$, cond) LOOP
			IF plan_line LIKE '%Bitmap Heap Scan on brintest%' THEN
				plan_ok := true;
			END IF;
		END LOOP;
		IF NOT plan_ok THEN
			RAISE WARNING 'did not get bitmap indexscan plan for %', r;
		END IF;

		EXECUTE format($y$SELECT array_agg(ctid) FROM brintest WHERE %s $y$, cond)
			INTO idx_ctids;

		-- run the query using a seqscan
		SET enable_seqscan = 1;
		SET enable_bitmapscan = 0;

		plan_ok := false;
		FOR plan_line IN EXECUTE format($y$EXPLAIN SELECT array_agg(ctid) FROM brintest WHERE %s $y$, cond) LOOP
			IF plan_line LIKE '%Seq Scan on brintest%' THEN
				plan_ok := true;
			END IF;
		END LOOP;
		IF NOT plan_ok THEN
			RAISE WARNING 'did not get seqscan plan for %', r;
		END IF;

		EXECUTE format($y$SELECT array_agg(ctid) FROM brintest WHERE %s $y$, cond)
			INTO ss_ctids;

		-- make sure both return the same results
		count := array_length(idx_ctids, 1);

		IF NOT (count = array_length(ss_ctids, 1) AND
				idx_ctids @> ss_ctids AND
				idx_ctids <@ ss_ctids) THEN
			-- report the results of each scan to make the differences obvious
			RAISE WARNING 'something not right in %: count %', r, count;
			SET enable_seqscan = 1;
			SET enable_bitmapscan = 0;
			FOR r2 IN EXECUTE 'SELECT ' || r.colname || ' FROM brintest WHERE ' || cond LOOP
				RAISE NOTICE 'seqscan: %', r2;
			END LOOP;

			SET enable_seqscan = 0;
			SET enable_bitmapscan = 1;
			FOR r2 IN EXECUTE 'SELECT ' || r.colname || ' FROM brintest WHERE ' || cond LOOP
				RAISE NOTICE 'bitmapscan: %', r2;
			END LOOP;
		END IF;

		-- make sure we found expected number of matches
		IF count != r.matches THEN RAISE WARNING 'unexpected number of results % for %', count, r; END IF;
	END LOOP;
END;
$x$;

RESET enable_seqscan;
RESET enable_bitmapscan;

INSERT INTO brintest SELECT
	repeat(stringu1, 42)::bytea,
	substr(stringu1, 1, 1)::"char",
	stringu1::name, 142857 * tenthous,
	thousand,
	twothousand,
	repeat(stringu1, 42),
	unique1::oid,
	format('(%s,%s)', tenthous, twenty)::tid,
	(four + 1.0)/(hundred+1),
	odd::float8 / (tenthous + 1),
	format('%s:00:%s:00:%s:00', to_hex(odd), to_hex(even), to_hex(hundred))::macaddr,
	inet '10.2.3.4' + tenthous,
	cidr '10.2.3/24' + tenthous,
	substr(stringu1, 1, 1)::bpchar,
	date '1995-08-15' + tenthous,
	time '01:20:30' + thousand * interval '18.5 second',
	timestamp '1942-07-23 03:05:09' + tenthous * interval '36.38 hours',
	timestamptz '1972-10-10 03:00' + thousand * interval '1 hour',
	justify_days(justify_hours(tenthous * interval '12 minutes')),
	timetz '01:30:20' + hundred * interval '15 seconds',
	thousand::bit(10),
	tenthous::bit(16)::varbit,
	tenthous::numeric(36,30) * fivethous * even / (hundred + 1),
	format('%s%s-%s-%s-%s-%s%s%s', to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'))::uuid,
	int4range(thousand, twothousand),
	format('%s/%s%s', odd, even, tenthous)::pg_lsn,
	box(point(odd, even), point(thousand, twothousand))
FROM tenk1 ORDER BY unique2 LIMIT 5 OFFSET 5;

SELECT brin_desummarize_range('brinidx', 0);
VACUUM brintest;  -- force a summarization cycle in brinidx

UPDATE brintest SET int8col = int8col * int4col;
UPDATE brintest SET textcol = '' WHERE textcol IS NOT NULL;

-- Tests for brin_summarize_new_values
SELECT brin_summarize_new_values('brintest'); -- error, not an index
SELECT brin_summarize_new_values('tenk1_unique1'); -- error, not a BRIN index
SELECT brin_summarize_new_values('brinidx'); -- ok, no change expected

-- Tests for brin_desummarize_range
SELECT brin_desummarize_range('brinidx', -1); -- error, invalid range
SELECT brin_desummarize_range('brinidx', 0);
SELECT brin_desummarize_range('brinidx', 0);
SELECT brin_desummarize_range('brinidx', 100000000);

-- Test brin_summarize_range
CREATE TABLE brin_summarize (
    value int
) WITH (fillfactor=10, autovacuum_enabled=false);
CREATE INDEX brin_summarize_idx ON brin_summarize USING brin (value) WITH (pages_per_range=2);
-- Fill a few pages
DO $$
DECLARE curtid tid;
BEGIN
  LOOP
    INSERT INTO brin_summarize VALUES (1) RETURNING ctid INTO curtid;
    EXIT WHEN curtid > tid '(2, 0)';
  END LOOP;
END;
$$;

-- summarize one range
SELECT brin_summarize_range('brin_summarize_idx', 0);
-- nothing: already summarized
SELECT brin_summarize_range('brin_summarize_idx', 1);
-- summarize one range
SELECT brin_summarize_range('brin_summarize_idx', 2);
-- nothing: page doesn/* REPLACED */''t exist in table
SELECT brin_summarize_range('brin_summarize_idx', 4294967295);
-- invalid block number values
SELECT brin_summarize_range('brin_summarize_idx', -1);
SELECT brin_summarize_range('brin_summarize_idx', 4294967296);

-- test value merging in add_value
CREATE TABLE brintest_2 (n numrange);
CREATE INDEX brinidx_2 ON brintest_2 USING brin (n);
INSERT INTO brintest_2 VALUES ('empty');
INSERT INTO brintest_2 VALUES (numrange(0, 2^1000::numeric));
INSERT INTO brintest_2 VALUES ('(-1, 0)');

SELECT brin_desummarize_range('brinidx', 0);
SELECT brin_summarize_range('brinidx', 0);
DROP TABLE brintest_2;

-- test brin cost estimates behave sanely based on correlation of values
CREATE TABLE brin_test (a INT, b INT);
INSERT INTO brin_test SELECT x/100,x%100 FROM generate_series(1,10000) x(x);
CREATE INDEX brin_test_a_idx ON brin_test USING brin (a) WITH (pages_per_range = 2);
CREATE INDEX brin_test_b_idx ON brin_test USING brin (b) WITH (pages_per_range = 2);
VACUUM ANALYZE brin_test;

-- Ensure brin index is used when columns are perfectly correlated
EXPLAIN (COSTS OFF) SELECT * FROM brin_test WHERE a = 1;
-- Ensure brin index is not used when values are not correlated
EXPLAIN (COSTS OFF) SELECT * FROM brin_test WHERE b = 1;

-- make sure data are properly de-toasted in BRIN index
CREATE TABLE brintest_3 (a text, b text, c text, d text);

-- long random strings (~2000 chars each, so ~6kB for min/max on two
-- columns) to trigger toasting
WITH rand_value AS (SELECT string_agg(fipshash(i::text),'') AS val FROM generate_series(1,60) s(i))
INSERT INTO brintest_3
SELECT val, val, val, val FROM rand_value;

CREATE INDEX brin_test_toast_idx ON brintest_3 USING brin (b, c);
DELETE FROM brintest_3;

-- We need to wait a bit for all transactions to complete, so that the
-- vacuum actually removes the TOAST rows. Creating an index concurrently
-- is a one way to achieve that, because it does exactly such wait.
CREATE INDEX CONCURRENTLY brin_test_temp_idx ON brintest_3(a);
DROP INDEX brin_test_temp_idx;

-- vacuum the table, to discard TOAST data
VACUUM brintest_3;

-- retry insert with a different random-looking (but deterministic) value
-- the value is different, and so should replace either min or max in the
-- brin summary
WITH rand_value AS (SELECT string_agg(fipshash((-i)::text),'') AS val FROM generate_series(1,60) s(i))
INSERT INTO brintest_3
SELECT val, val, val, val FROM rand_value;

-- now try some queries, accessing the brin index
SET enable_seqscan = off;

EXPLAIN (COSTS OFF)
SELECT * FROM brintest_3 WHERE b < '0';

SELECT * FROM brintest_3 WHERE b < '0';

DROP TABLE brintest_3;
RESET enable_seqscan;

-- test an unlogged table, mostly to get coverage of brinbuildempty
CREATE UNLOGGED TABLE brintest_unlogged (n numrange);
CREATE INDEX brinidx_unlogged ON brintest_unlogged USING brin (n);
INSERT INTO brintest_unlogged VALUES (numrange(0, 2^1000::numeric));
DROP TABLE brintest_unlogged;

-- test that the insert optimization works if no rows end up inserted
CREATE TABLE brin_insert_optimization (a int);
INSERT INTO brin_insert_optimization VALUES (1);
CREATE INDEX ON brin_insert_optimization USING brin (a);
UPDATE brin_insert_optimization SET a = a;
DROP TABLE brin_insert_optimization;
-- END setup from brin 
SELECT pg_catalog.set_config('search_path', 'public', false);
