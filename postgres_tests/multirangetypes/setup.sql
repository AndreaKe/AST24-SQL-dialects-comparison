-- START setup from test_setup 
--
-- TEST_SETUP --- prepare environment expected by regression test scripts
--

-- directory paths and dlsuffix are passed to us in environment variables
-- \getenv abs_srcdir '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests'
-- \getenv libdir '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress'
-- \getenv dlsuffix '.so'

-- \set regresslib '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress' '/regress' '.so'

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
-- (Some subsequent tests try to insert erroneous values.  That's okay
-- because the table won't actually change.  Do not change the contents
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
-- We intentionally don't vacuum point_tbl here -  geometry depends on that

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

-- \set filename '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/onek.data'
COPY onek FROM '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/onek.data';
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

-- \set filename '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/tenk.data'
COPY tenk1 FROM '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/tenk.data';
VACUUM ANALYZE tenk1;

CREATE TABLE tenk2 AS SELECT * FROM tenk1;
VACUUM ANALYZE tenk2;

CREATE TABLE person (
	name 		text,
	age			int4,
	location 	point
);

-- \set filename '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/person.data'
COPY person FROM '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/person.data';
VACUUM ANALYZE person;

CREATE TABLE emp (
	salary 		int4,
	manager 	name
) INHERITS (person);

-- \set filename '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/emp.data'
COPY emp FROM '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/emp.data';
VACUUM ANALYZE emp;

CREATE TABLE student (
	gpa 		float8
) INHERITS (person);

-- \set filename '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/student.data'
COPY student FROM '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/student.data';
VACUUM ANALYZE student;

CREATE TABLE stud_emp (
	percent 	int4
) INHERITS (emp, student);

-- \set filename '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/stud_emp.data'
COPY stud_emp FROM '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/stud_emp.data';
VACUUM ANALYZE stud_emp;

CREATE TABLE road (
	name		text,
	thepath 	path
);

-- \set filename '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/streets.data'
COPY road FROM '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/streets.data';
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
    AS '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress/regress.so', 'binary_coercible'
    LANGUAGE C STRICT STABLE PARALLEL SAFE;

CREATE FUNCTION ttdummy ()
    RETURNS trigger
    AS '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress/regress.so'
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
-- START setup from create_index 
--
-- CREATE_INDEX
-- Create ancillary data structures (i.e. indices)
--

-- directory paths are passed to us in environment variables
-- \getenv abs_srcdir '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests'

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

-- \set filename '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/rect.data'
COPY slow_emp4000 FROM '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/rect.data';

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

-- \set filename '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/array.data'
COPY array_index_op_test FROM '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/array.data';
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
-- Test GIN index's reloptions
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

-- CREATE INDEX hash_ovfl_index ON hash_ovfl_heap USING hash (x int4_ops) - 

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
-- but this shouldn't:
INSERT INTO func_index_heap VALUES('QWERTY');

-- while we're here, see that the metadata looks sane
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
-- but this shouldn't:
INSERT INTO func_index_heap VALUES('QWERTY');

-- while we're here, see that the metadata looks sane
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
-- and this shouldn't:
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
-- You can't do a concurrent index build in a transaction
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

DROP INDEX cwi_replaced_pkey;	-- Should fail; a constraint depends on it

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
-- START setup from  rangetypes
 
-- Tests for range data types.

--
-- test input parser
-- (type textrange was already made in test_setup.sql)
--

-- negative tests -  should fail
select ''::textrange;
select '-[a,z)'::textrange;
select '[a,z) - '::textrange;
select '(",a)'::textrange;
select '(,,a)'::textrange;
select '(),a)'::textrange;
select '(a,))'::textrange;
select '(],a)'::textrange;
select '(a,])'::textrange;
select '[z,a]'::textrange;

-- should succeed
select '  empty  '::textrange;
select ' ( empty, empty )  '::textrange;
select ' ( " a " " a ", " z " " z " )  '::textrange;
select '(a,)'::textrange;
select '[,z]'::textrange;
select '[a,]'::textrange;
select '(,)'::textrange;
select '[ , ]'::textrange;
select '["",""]'::textrange;
select '[",",","]'::textrange;
select '["\\","\\"]'::textrange;
select '(\\,a)'::textrange;
select '((,z)'::textrange;
select '([,z)'::textrange;
select '(!,()'::textrange;
select '(!,[)'::textrange;
select '[a,a]'::textrange;
-- these are allowed but normalize to empty:
select '[a,a)'::textrange;
select '(a,a]'::textrange;
select '(a,a)'::textrange;

-- Also try it with non-error-throwing API
select pg_input_is_valid('(1,4)', 'int4range');
select pg_input_is_valid('(1,4', 'int4range');
select * from pg_input_error_info('(1,4', 'int4range');
select pg_input_is_valid('(4,1)', 'int4range');
select * from pg_input_error_info('(4,1)', 'int4range');
select pg_input_is_valid('(4,zed)', 'int4range');
select * from pg_input_error_info('(4,zed)', 'int4range');
select pg_input_is_valid('[1,2147483647]', 'int4range');
select * from pg_input_error_info('[1,2147483647]', 'int4range');
select pg_input_is_valid('[2000-01-01,5874897-12-31]', 'daterange');
select * from pg_input_error_info('[2000-01-01,5874897-12-31]', 'daterange');

--
-- create some test data and test the operators
--

CREATE TABLE numrange_test (nr NUMRANGE);
create index numrange_test_btree on numrange_test(nr);

INSERT INTO numrange_test VALUES('[,)');
INSERT INTO numrange_test VALUES('[3,]');
INSERT INTO numrange_test VALUES('[, 5)');
INSERT INTO numrange_test VALUES(numrange(1.1, 2.2));
INSERT INTO numrange_test VALUES('empty');
INSERT INTO numrange_test VALUES(numrange(1.7, 1.7, '[]'));

SELECT nr, isempty(nr), lower(nr), upper(nr) FROM numrange_test;
SELECT nr, lower_inc(nr), lower_inf(nr), upper_inc(nr), upper_inf(nr) FROM numrange_test;

SELECT * FROM numrange_test WHERE range_contains(nr, numrange(1.9,1.91));
SELECT * FROM numrange_test WHERE nr @> numrange(1.0,10000.1);
SELECT * FROM numrange_test WHERE range_contained_by(numrange(-1e7,-10000.1), nr);
SELECT * FROM numrange_test WHERE 1.9 <@ nr;

select * from numrange_test where nr = 'empty';
select * from numrange_test where nr = '(1.1, 2.2)';
select * from numrange_test where nr = '[1.1, 2.2)';
select * from numrange_test where nr < 'empty';
select * from numrange_test where nr < numrange(-1000.0, -1000.0,'[]');
select * from numrange_test where nr < numrange(0.0, 1.0,'[]');
select * from numrange_test where nr < numrange(1000.0, 1001.0,'[]');
select * from numrange_test where nr <= 'empty';
select * from numrange_test where nr >= 'empty';
select * from numrange_test where nr > 'empty';
select * from numrange_test where nr > numrange(-1001.0, -1000.0,'[]');
select * from numrange_test where nr > numrange(0.0, 1.0,'[]');
select * from numrange_test where nr > numrange(1000.0, 1000.0,'[]');

select numrange(2.0, 1.0);

select numrange(2.0, 3.0) -|- numrange(3.0, 4.0);
select range_adjacent(numrange(2.0, 3.0), numrange(3.1, 4.0));
select range_adjacent(numrange(2.0, 3.0), numrange(3.1, null));
select numrange(2.0, 3.0, '[]') -|- numrange(3.0, 4.0, '()');
select numrange(1.0, 2.0) -|- numrange(2.0, 3.0,'[]');
select range_adjacent(numrange(2.0, 3.0, '(]'), numrange(1.0, 2.0, '(]'));

select numrange(1.1, 3.3) <@ numrange(0.1,10.1);
select numrange(0.1, 10.1) <@ numrange(1.1,3.3);

select numrange(1.1, 2.2) - numrange(2.0, 3.0);
select numrange(1.1, 2.2) - numrange(2.2, 3.0);
select numrange(1.1, 2.2,'[]') - numrange(2.0, 3.0);
select range_minus(numrange(10.1,12.2,'[]'), numrange(110.0,120.2,'(]'));
select range_minus(numrange(10.1,12.2,'[]'), numrange(0.0,120.2,'(]'));

select numrange(4.5, 5.5, '[]') && numrange(5.5, 6.5);
select numrange(1.0, 2.0) << numrange(3.0, 4.0);
select numrange(1.0, 3.0,'[]') << numrange(3.0, 4.0,'[]');
select numrange(1.0, 3.0,'()') << numrange(3.0, 4.0,'()');
select numrange(1.0, 2.0) >> numrange(3.0, 4.0);
select numrange(3.0, 70.0) &< numrange(6.6, 100.0);

select numrange(1.1, 2.2) < numrange(1.0, 200.2);
select numrange(1.1, 2.2) < numrange(1.1, 1.2);

select numrange(1.0, 2.0) + numrange(2.0, 3.0);
select numrange(1.0, 2.0) + numrange(1.5, 3.0);
select numrange(1.0, 2.0) + numrange(2.5, 3.0); -- should fail

select range_merge(numrange(1.0, 2.0), numrange(2.0, 3.0));
select range_merge(numrange(1.0, 2.0), numrange(1.5, 3.0));
select range_merge(numrange(1.0, 2.0), numrange(2.5, 3.0)); -- shouldn't fail

select numrange(1.0, 2.0) * numrange(2.0, 3.0);
select numrange(1.0, 2.0) * numrange(1.5, 3.0);
select numrange(1.0, 2.0) * numrange(2.5, 3.0);

select range_intersect_agg(nr) from numrange_test;
select range_intersect_agg(nr) from numrange_test where false;
select range_intersect_agg(nr) from numrange_test where nr @> 4.0;

analyze numrange_test;

create table numrange_test2(nr numrange);
create index numrange_test2_hash_idx on numrange_test2 using hash (nr);

INSERT INTO numrange_test2 VALUES('[, 5)');
INSERT INTO numrange_test2 VALUES(numrange(1.1, 2.2));
INSERT INTO numrange_test2 VALUES(numrange(1.1, 2.2));
INSERT INTO numrange_test2 VALUES(numrange(1.1, 2.2,'()'));
INSERT INTO numrange_test2 VALUES('empty');

select * from numrange_test2 where nr = 'empty'::numrange;
select * from numrange_test2 where nr = numrange(1.1, 2.2);
select * from numrange_test2 where nr = numrange(1.1, 2.3);

set enable_nestloop=t;
set enable_hashjoin=f;
set enable_mergejoin=f;
select * from numrange_test natural join numrange_test2 order by nr;
set enable_nestloop=f;
set enable_hashjoin=t;
set enable_mergejoin=f;
select * from numrange_test natural join numrange_test2 order by nr;
set enable_nestloop=f;
set enable_hashjoin=f;
set enable_mergejoin=t;
select * from numrange_test natural join numrange_test2 order by nr;

set enable_nestloop to default;
set enable_hashjoin to default;
set enable_mergejoin to default;

-- keep numrange_test around to help exercise dump/reload
DROP TABLE numrange_test2;

--
-- Apply a subset of the above tests on a collatable type, too
--

CREATE TABLE textrange_test (tr textrange);
create index textrange_test_btree on textrange_test(tr);

INSERT INTO textrange_test VALUES('[,)');
INSERT INTO textrange_test VALUES('["a",]');
INSERT INTO textrange_test VALUES('[,"q")');
INSERT INTO textrange_test VALUES(textrange('b', 'g'));
INSERT INTO textrange_test VALUES('empty');
INSERT INTO textrange_test VALUES(textrange('d', 'd', '[]'));

SELECT tr, isempty(tr), lower(tr), upper(tr) FROM textrange_test;
SELECT tr, lower_inc(tr), lower_inf(tr), upper_inc(tr), upper_inf(tr) FROM textrange_test;

SELECT * FROM textrange_test WHERE range_contains(tr, textrange('f', 'fx'));
SELECT * FROM textrange_test WHERE tr @> textrange('a', 'z');
SELECT * FROM textrange_test WHERE range_contained_by(textrange('0','9'), tr);
SELECT * FROM textrange_test WHERE 'e'::text <@ tr;

select * from textrange_test where tr = 'empty';
select * from textrange_test where tr = '("b","g")';
select * from textrange_test where tr = '["b","g")';
select * from textrange_test where tr < 'empty';


-- test canonical form for int4range
select int4range(1, 10, '[]');
select int4range(1, 10, '[)');
select int4range(1, 10, '(]');
select int4range(1, 10, '()');
select int4range(1, 2, '()');

-- test canonical form for daterange
select daterange('2000-01-10'::date, '2000-01-20'::date, '[]');
select daterange('2000-01-10'::date, '2000-01-20'::date, '[)');
select daterange('2000-01-10'::date, '2000-01-20'::date, '(]');
select daterange('2000-01-10'::date, '2000-01-20'::date, '()');
select daterange('2000-01-10'::date, '2000-01-11'::date, '()');
select daterange('2000-01-10'::date, '2000-01-11'::date, '(]');
select daterange('-infinity'::date, '2000-01-01'::date, '()');
select daterange('-infinity'::date, '2000-01-01'::date, '[)');
select daterange('2000-01-01'::date, 'infinity'::date, '[)');
select daterange('2000-01-01'::date, 'infinity'::date, '[]');

-- test GiST index that's been built incrementally
create table test_range_gist(ir int4range);
create index test_range_gist_idx on test_range_gist using gist (ir);

insert into test_range_gist select int4range(g, g+10) from generate_series(1,2000) g;
insert into test_range_gist select 'empty'::int4range from generate_series(1,500) g;
insert into test_range_gist select int4range(g, g+10000) from generate_series(1,1000) g;
insert into test_range_gist select 'empty'::int4range from generate_series(1,500) g;
insert into test_range_gist select int4range(NULL,g*10,'(]') from generate_series(1,100) g;
insert into test_range_gist select int4range(g*10,NULL,'(]') from generate_series(1,100) g;
insert into test_range_gist select int4range(g, g+10) from generate_series(1,2000) g;

-- test statistics and selectivity estimation as well
--
-- We don't check the accuracy of selectivity estimation, but at least check
-- it doesn't fall.
analyze test_range_gist;

-- first, verify non-indexed results
SET enable_seqscan    = t;
SET enable_indexscan  = f;
SET enable_bitmapscan = f;

select count(*) from test_range_gist where ir @> 'empty'::int4range;
select count(*) from test_range_gist where ir = int4range(10,20);
select count(*) from test_range_gist where ir @> 10;
select count(*) from test_range_gist where ir @> int4range(10,20);
select count(*) from test_range_gist where ir && int4range(10,20);
select count(*) from test_range_gist where ir <@ int4range(10,50);
select count(*) from test_range_gist where ir << int4range(100,500);
select count(*) from test_range_gist where ir >> int4range(100,500);
select count(*) from test_range_gist where ir &< int4range(100,500);
select count(*) from test_range_gist where ir &> int4range(100,500);
select count(*) from test_range_gist where ir -|- int4range(100,500);
select count(*) from test_range_gist where ir @> '{}'::int4multirange;
select count(*) from test_range_gist where ir @> int4multirange(int4range(10,20), int4range(30,40));
select count(*) from test_range_gist where ir && '{(10,20),(30,40),(50,60)}'::int4multirange;
select count(*) from test_range_gist where ir <@ '{(10,30),(40,60),(70,90)}'::int4multirange;
select count(*) from test_range_gist where ir << int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir >> int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir &< int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir &> int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir -|- int4multirange(int4range(100,200), int4range(400,500));

-- now check same queries using index
SET enable_seqscan    = f;
SET enable_indexscan  = t;
SET enable_bitmapscan = f;

select count(*) from test_range_gist where ir @> 'empty'::int4range;
select count(*) from test_range_gist where ir = int4range(10,20);
select count(*) from test_range_gist where ir @> 10;
select count(*) from test_range_gist where ir @> int4range(10,20);
select count(*) from test_range_gist where ir && int4range(10,20);
select count(*) from test_range_gist where ir <@ int4range(10,50);
select count(*) from test_range_gist where ir << int4range(100,500);
select count(*) from test_range_gist where ir >> int4range(100,500);
select count(*) from test_range_gist where ir &< int4range(100,500);
select count(*) from test_range_gist where ir &> int4range(100,500);
select count(*) from test_range_gist where ir -|- int4range(100,500);
select count(*) from test_range_gist where ir @> '{}'::int4multirange;
select count(*) from test_range_gist where ir @> int4multirange(int4range(10,20), int4range(30,40));
select count(*) from test_range_gist where ir && '{(10,20),(30,40),(50,60)}'::int4multirange;
select count(*) from test_range_gist where ir <@ '{(10,30),(40,60),(70,90)}'::int4multirange;
select count(*) from test_range_gist where ir << int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir >> int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir &< int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir &> int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir -|- int4multirange(int4range(100,200), int4range(400,500));

-- now check same queries using a bulk-loaded index
drop index test_range_gist_idx;
create index test_range_gist_idx on test_range_gist using gist (ir);

select count(*) from test_range_gist where ir @> 'empty'::int4range;
select count(*) from test_range_gist where ir = int4range(10,20);
select count(*) from test_range_gist where ir @> 10;
select count(*) from test_range_gist where ir @> int4range(10,20);
select count(*) from test_range_gist where ir && int4range(10,20);
select count(*) from test_range_gist where ir <@ int4range(10,50);
select count(*) from test_range_gist where ir << int4range(100,500);
select count(*) from test_range_gist where ir >> int4range(100,500);
select count(*) from test_range_gist where ir &< int4range(100,500);
select count(*) from test_range_gist where ir &> int4range(100,500);
select count(*) from test_range_gist where ir -|- int4range(100,500);
select count(*) from test_range_gist where ir @> '{}'::int4multirange;
select count(*) from test_range_gist where ir @> int4multirange(int4range(10,20), int4range(30,40));
select count(*) from test_range_gist where ir && '{(10,20),(30,40),(50,60)}'::int4multirange;
select count(*) from test_range_gist where ir <@ '{(10,30),(40,60),(70,90)}'::int4multirange;
select count(*) from test_range_gist where ir << int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir >> int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir &< int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir &> int4multirange(int4range(100,200), int4range(400,500));
select count(*) from test_range_gist where ir -|- int4multirange(int4range(100,200), int4range(400,500));

-- test SP-GiST index that's been built incrementally
create table test_range_spgist(ir int4range);
create index test_range_spgist_idx on test_range_spgist using spgist (ir);

insert into test_range_spgist select int4range(g, g+10) from generate_series(1,2000) g;
insert into test_range_spgist select 'empty'::int4range from generate_series(1,500) g;
insert into test_range_spgist select int4range(g, g+10000) from generate_series(1,1000) g;
insert into test_range_spgist select 'empty'::int4range from generate_series(1,500) g;
insert into test_range_spgist select int4range(NULL,g*10,'(]') from generate_series(1,100) g;
insert into test_range_spgist select int4range(g*10,NULL,'(]') from generate_series(1,100) g;
insert into test_range_spgist select int4range(g, g+10) from generate_series(1,2000) g;

-- first, verify non-indexed results
SET enable_seqscan    = t;
SET enable_indexscan  = f;
SET enable_bitmapscan = f;

select count(*) from test_range_spgist where ir @> 'empty'::int4range;
select count(*) from test_range_spgist where ir = int4range(10,20);
select count(*) from test_range_spgist where ir @> 10;
select count(*) from test_range_spgist where ir @> int4range(10,20);
select count(*) from test_range_spgist where ir && int4range(10,20);
select count(*) from test_range_spgist where ir <@ int4range(10,50);
select count(*) from test_range_spgist where ir << int4range(100,500);
select count(*) from test_range_spgist where ir >> int4range(100,500);
select count(*) from test_range_spgist where ir &< int4range(100,500);
select count(*) from test_range_spgist where ir &> int4range(100,500);
select count(*) from test_range_spgist where ir -|- int4range(100,500);

-- now check same queries using index
SET enable_seqscan    = f;
SET enable_indexscan  = t;
SET enable_bitmapscan = f;

select count(*) from test_range_spgist where ir @> 'empty'::int4range;
select count(*) from test_range_spgist where ir = int4range(10,20);
select count(*) from test_range_spgist where ir @> 10;
select count(*) from test_range_spgist where ir @> int4range(10,20);
select count(*) from test_range_spgist where ir && int4range(10,20);
select count(*) from test_range_spgist where ir <@ int4range(10,50);
select count(*) from test_range_spgist where ir << int4range(100,500);
select count(*) from test_range_spgist where ir >> int4range(100,500);
select count(*) from test_range_spgist where ir &< int4range(100,500);
select count(*) from test_range_spgist where ir &> int4range(100,500);
select count(*) from test_range_spgist where ir -|- int4range(100,500);

-- now check same queries using a bulk-loaded index
drop index test_range_spgist_idx;
create index test_range_spgist_idx on test_range_spgist using spgist (ir);

select count(*) from test_range_spgist where ir @> 'empty'::int4range;
select count(*) from test_range_spgist where ir = int4range(10,20);
select count(*) from test_range_spgist where ir @> 10;
select count(*) from test_range_spgist where ir @> int4range(10,20);
select count(*) from test_range_spgist where ir && int4range(10,20);
select count(*) from test_range_spgist where ir <@ int4range(10,50);
select count(*) from test_range_spgist where ir << int4range(100,500);
select count(*) from test_range_spgist where ir >> int4range(100,500);
select count(*) from test_range_spgist where ir &< int4range(100,500);
select count(*) from test_range_spgist where ir &> int4range(100,500);
select count(*) from test_range_spgist where ir -|- int4range(100,500);

-- test index-only scans
explain (costs off)
select ir from test_range_spgist where ir -|- int4range(10,20) order by ir;
select ir from test_range_spgist where ir -|- int4range(10,20) order by ir;

RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;

-- test elem <@ range operator
create table test_range_elem(i int4);
create index test_range_elem_idx on test_range_elem (i);
insert into test_range_elem select i from generate_series(1,100) i;

SET enable_seqscan    = f;

select count(*) from test_range_elem where i <@ int4range(10,50);

-- also test spgist index on anyrange expression
create index on test_range_elem using spgist(int4range(i,i+10));
explain (costs off)
select count(*) from test_range_elem where int4range(i,i+10) <@ int4range(10,30);
select count(*) from test_range_elem where int4range(i,i+10) <@ int4range(10,30);

RESET enable_seqscan;

drop table test_range_elem;

--
-- Btree_gist is not included by default, so to test exclusion
-- constraints with range types, use singleton int ranges for the "="
-- portion of the constraint.
--

create table test_range_excl(
  room int4range,
  speaker int4range,
  during tsrange,
  exclude using gist (room with =, during with &&),
  exclude using gist (speaker with =, during with &&)
);

insert into test_range_excl
  values(int4range(123, 123, '[]'), int4range(1, 1, '[]'), '[2010-01-02 10:00, 2010-01-02 11:00)');
insert into test_range_excl
  values(int4range(123, 123, '[]'), int4range(2, 2, '[]'), '[2010-01-02 11:00, 2010-01-02 12:00)');
insert into test_range_excl
  values(int4range(123, 123, '[]'), int4range(3, 3, '[]'), '[2010-01-02 10:10, 2010-01-02 11:00)');
insert into test_range_excl
  values(int4range(124, 124, '[]'), int4range(3, 3, '[]'), '[2010-01-02 10:10, 2010-01-02 11:10)');
insert into test_range_excl
  values(int4range(125, 125, '[]'), int4range(1, 1, '[]'), '[2010-01-02 10:10, 2010-01-02 11:00)');

-- test bigint ranges
select int8range(10000000000::int8, 20000000000::int8,'(]');
-- test tstz ranges
set timezone to '-08';
select '[2010-01-01 01:00:00 -05, 2010-01-01 02:00:00 -08)'::tstzrange;
-- should fail
select '[2010-01-01 01:00:00 -08, 2010-01-01 02:00:00 -05)'::tstzrange;
set timezone to default;

--
-- Test user-defined range of floats
-- (type float8range was already made in test_setup.sql)
--

--should fail
create type bogus_float8range as range (subtype=float8, subtype_diff=float4mi);

select '[123.001, 5.e9)'::float8range @> 888.882::float8;
create table float8range_test(f8r float8range, i int);
insert into float8range_test values(float8range(-100.00007, '1.111113e9'), 42);
select * from float8range_test;
drop table float8range_test;

--
-- Test range types over domains
--

create domain mydomain as int4;
create type mydomainrange as range(subtype=mydomain);
select '[4,50)'::mydomainrange @> 7::mydomain;
drop domain mydomain;  -- fail
drop domain mydomain cascade;

--
-- Test domains over range types
--

create domain restrictedrange as int4range check (upper(value) < 10);
select '[4,5)'::restrictedrange @> 7;
select '[4,50)'::restrictedrange @> 7; -- should fail
drop domain restrictedrange;

--
-- Test multiple range types over the same subtype
--

create type textrange1 as range(subtype=text, collation="C");
create type textrange2 as range(subtype=text, collation="C");

select textrange1('a','Z') @> 'b'::text;
select textrange2('a','z') @> 'b'::text;

drop type textrange1;
drop type textrange2;

--
-- Test polymorphic type system
--

create function anyarray_anyrange_func(a anyarray, r anyrange)
  returns anyelement as 'select $1[1] + lower($2);' language sql;

select anyarray_anyrange_func(ARRAY[1,2], int4range(10,20));

-- should fail
select anyarray_anyrange_func(ARRAY[1,2], numrange(10,20));

drop function anyarray_anyrange_func(anyarray, anyrange);

-- should fail
create function bogus_func(anyelement)
  returns anyrange as 'select int4range(1,10)' language sql;

-- should fail
create function bogus_func(int)
  returns anyrange as 'select int4range(1,10)' language sql;

create function range_add_bounds(anyrange)
  returns anyelement as 'select lower($1) + upper($1)' language sql;

select range_add_bounds(int4range(1, 17));
select range_add_bounds(numrange(1.0001, 123.123));

create function rangetypes_sql(q anyrange, b anyarray, out c anyelement)
  as $$ select upper($1) + $2[1] $$
  language sql;

select rangetypes_sql(int4range(1,10), ARRAY[2,20]);
select rangetypes_sql(numrange(1,10), ARRAY[2,20]);  -- match failure

create function anycompatiblearray_anycompatiblerange_func(a anycompatiblearray, r anycompatiblerange)
  returns anycompatible as 'select $1[1] + lower($2);' language sql;

select anycompatiblearray_anycompatiblerange_func(ARRAY[1,2], int4range(10,20));

select anycompatiblearray_anycompatiblerange_func(ARRAY[1,2], numrange(10,20));

-- should fail
select anycompatiblearray_anycompatiblerange_func(ARRAY[1.1,2], int4range(10,20));

drop function anycompatiblearray_anycompatiblerange_func(anycompatiblearray, anycompatiblerange);

-- should fail
create function bogus_func(anycompatible)
  returns anycompatiblerange as 'select int4range(1,10)' language sql;

--
-- Arrays of ranges
--

select ARRAY[numrange(1.1, 1.2), numrange(12.3, 155.5)];

create table i8r_array (f1 int, f2 int8range[]);
insert into i8r_array values (42, array[int8range(1,10), int8range(2,20)]);
select * from i8r_array;
drop table i8r_array;

--
-- Ranges of arrays
--

create type arrayrange as range (subtype=int4[]);

select arrayrange(ARRAY[1,2], ARRAY[2,1]);
select arrayrange(ARRAY[2,1], ARRAY[1,2]);  -- fail

select array[1,1] <@ arrayrange(array[1,2], array[2,1]);
select array[1,3] <@ arrayrange(array[1,2], array[2,1]);

--
-- Ranges of composites
--

create type two_ints as (a int, b int);
create type two_ints_range as range (subtype = two_ints);

-- with debug_parallel_query on, this exercises tqueue.c's range remapping
select *, row_to_json(upper(t)) as u from
  (values (two_ints_range(row(1,2), row(3,4))),
          (two_ints_range(row(5,6), row(7,8)))) v(t);

-- this must be rejected to avoid self-inclusion issues:
alter type two_ints add attribute c two_ints_range;

drop type two_ints cascade;

--
-- Check behavior when subtype lacks a hash function
--

create type varbitrange as range (subtype = varbit);

set enable_sort = off;  -- try to make it pick a hash setop implementation

select '(01,10)'::varbitrange except select '(10,11)'::varbitrange;

reset enable_sort;

--
-- OUT/INOUT/TABLE functions
--

-- infer anyrange from anyrange
create function outparam_succeed(i anyrange, out r anyrange, out t text)
  as $$ select $1, 'foo'::text $$ language sql;

select * from outparam_succeed(int4range(1,2));

create function outparam2_succeed(r anyrange, out lu anyarray, out ul anyarray)
  as $$ select array[lower($1), upper($1)], array[upper($1), lower($1)] $$
  language sql;

select * from outparam2_succeed(int4range(1,11));

-- infer anyarray from anyrange
create function outparam_succeed2(i anyrange, out r anyarray, out t text)
  as $$ select ARRAY[upper($1)], 'foo'::text $$ language sql;

select * from outparam_succeed2(int4range(int4range(1,2)));

-- infer anyelement from anyrange
create function inoutparam_succeed(out i anyelement, inout r anyrange)
  as $$ select upper($1), $1 $$ language sql;

select * from inoutparam_succeed(int4range(1,2));

create function table_succeed(r anyrange)
  returns table(l anyelement, u anyelement)
  as $$ select lower($1), upper($1) $$
  language sql;

select * from table_succeed(int4range(1,11));

-- should fail
create function outparam_fail(i anyelement, out r anyrange, out t text)
  as $$ select '[1,10]', 'foo' $$ language sql;

--should fail
create function inoutparam_fail(inout i anyelement, out r anyrange)
  as $$ select $1, '[1,10]' $$ language sql;

--should fail
create function table_fail(i anyelement) returns table(i anyelement, r anyrange)
  as $$ select $1, '[1,10]' $$ language sql;

--
-- Test support functions
--

-- empty range
explain (verbose, costs off)
select current_date <@ daterange 'empty';

-- unbounded range
explain (verbose, costs off)
select current_date <@ daterange(NULL, NULL);

-- only lower bound present
explain (verbose, costs off)
select current_date <@ daterange('2000-01-01', NULL, '[)');

-- only upper bound present
explain (verbose, costs off)
select current_date <@ daterange(NULL, '2000-01-01', '(]');

-- lower range "-Infinity" excluded
explain (verbose, costs off)
select current_date <@ daterange('-Infinity', '1997-04-10'::date, '()');

-- lower range "-Infinity" included
explain (verbose, costs off)
select current_date <@ daterange('-Infinity', '1997-04-10'::date, '[)');

-- upper range "Infinity" excluded
explain (verbose, costs off)
select current_date <@ daterange('2002-09-25'::date, 'Infinity', '[)');

-- upper range "Infinity" included
explain (verbose, costs off)
select current_date <@ daterange('2002-09-25'::date, 'Infinity', '[]');

-- should also work if we use "@>"
explain (verbose, costs off)
select daterange('-Infinity', '1997-04-10'::date, '()') @> current_date;

explain (verbose, costs off)
select daterange('2002-09-25'::date, 'Infinity', '[]') @> current_date;

-- Check that volatile cases are not optimized
explain (verbose, costs off)
select now() <@ tstzrange('2024-01-20 00:00', '2024-01-21 00:00');
explain (verbose, costs off)  -- unsafe!
select clock_timestamp() <@ tstzrange('2024-01-20 00:00', '2024-01-21 00:00');
explain (verbose, costs off)
select clock_timestamp() <@ tstzrange('2024-01-20 00:00', NULL);

-- test a custom range type with a non-default operator class
create type textrange_supp as range (
   subtype = text,
   subtype_opclass = text_pattern_ops
);

create temp table text_support_test (t text collate "C");

insert into text_support_test values ('a'), ('c'), ('d'), ('ch');

explain (costs off)
select * from text_support_test where t <@ textrange_supp('a', 'd');
select * from text_support_test where t <@ textrange_supp('a', 'd');

drop table text_support_test;

drop type textrange_supp;
-- END setup from  rangetypes
 
