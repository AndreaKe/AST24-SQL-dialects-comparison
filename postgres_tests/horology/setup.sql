-- START setup from test_setup 
--
-- TEST_SETUP --- prepare environment expected by regression test scripts
--

-- directory paths and dlsuffix are passed to us in environment variables
-- \getenv abs_srcdir /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
-- \getenv libdir /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
-- \getenv dlsuffix /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''.so/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''

-- \set regresslib /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/regress/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''.so/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''

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
-- (Some subsequent tests try to insert erroneous values.  That/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''s okay
-- because the table won/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t actually change.  Do not change the contents
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
-- We intentionally don/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t vacuum point_tbl here /* REPLACED */, geometry depends on that

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

-- \set filename /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/data/onek.data/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
COPY onek FROM /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/onek.data';
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

-- \set filename /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/data/tenk.data/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
COPY tenk1 FROM /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/tenk.data';
VACUUM ANALYZE tenk1;

CREATE TABLE tenk2 AS SELECT * FROM tenk1;
VACUUM ANALYZE tenk2;

CREATE TABLE person (
	name 		text,
	age			int4,
	location 	point
);

-- \set filename /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/data/person.data/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
COPY person FROM /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/person.data';
VACUUM ANALYZE person;

CREATE TABLE emp (
	salary 		int4,
	manager 	name
) INHERITS (person);

-- \set filename /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/data/emp.data/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
COPY emp FROM /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/emp.data';
VACUUM ANALYZE emp;

CREATE TABLE student (
	gpa 		float8
) INHERITS (person);

-- \set filename /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/data/student.data/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
COPY student FROM /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/student.data';
VACUUM ANALYZE student;

CREATE TABLE stud_emp (
	percent 	int4
) INHERITS (emp, student);

-- \set filename /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/data/stud_emp.data/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
COPY stud_emp FROM /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/stud_emp.data';
VACUUM ANALYZE stud_emp;

CREATE TABLE road (
	name		text,
	thepath 	path
);

-- \set filename /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/data/streets.data/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
COPY road FROM /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/streets.data';
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
    AS /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress/regress.so', 'binary_coercible'
    LANGUAGE C STRICT STABLE PARALLEL SAFE;

CREATE FUNCTION ttdummy ()
    RETURNS trigger
    AS /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress/regress.so'
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
-- \getenv abs_srcdir /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''

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

-- \set filename /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/data/rect.data/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
COPY slow_emp4000 FROM /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/rect.data';

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

-- \set filename /* REPLACED */ /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/data/array.data/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
COPY array_index_op_test FROM /* REPLACED */ '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/array.data';
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
-- Test GIN index/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''s reloptions
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
-- but this shouldn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t:
INSERT INTO func_index_heap VALUES('QWERTY');

-- while we/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''re here, see that the metadata looks sane
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
-- but this shouldn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t:
INSERT INTO func_index_heap VALUES('QWERTY');

-- while we/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''re here, see that the metadata looks sane
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
-- and this shouldn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t:
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
-- You can/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t do a concurrent index build in a transaction
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
-- START setup from date 
--
-- DATE
--

CREATE TABLE DATE_TBL (f1 date);

INSERT INTO DATE_TBL VALUES ('1957-04-09');
INSERT INTO DATE_TBL VALUES ('1957-06-13');
INSERT INTO DATE_TBL VALUES ('1996-02-28');
INSERT INTO DATE_TBL VALUES ('1996-02-29');
INSERT INTO DATE_TBL VALUES ('1996-03-01');
INSERT INTO DATE_TBL VALUES ('1996-03-02');
INSERT INTO DATE_TBL VALUES ('1997-02-28');
INSERT INTO DATE_TBL VALUES ('1997-02-29');
INSERT INTO DATE_TBL VALUES ('1997-03-01');
INSERT INTO DATE_TBL VALUES ('1997-03-02');
INSERT INTO DATE_TBL VALUES ('2000-04-01');
INSERT INTO DATE_TBL VALUES ('2000-04-02');
INSERT INTO DATE_TBL VALUES ('2000-04-03');
INSERT INTO DATE_TBL VALUES ('2038-04-08');
INSERT INTO DATE_TBL VALUES ('2039-04-09');
INSERT INTO DATE_TBL VALUES ('2040-04-10');
INSERT INTO DATE_TBL VALUES ('2040-04-10 BC');

SELECT f1 FROM DATE_TBL;

SELECT f1 FROM DATE_TBL WHERE f1 < '2000-01-01';

SELECT f1 FROM DATE_TBL
  WHERE f1 BETWEEN '2000-01-01' AND '2001-01-01';

--
-- Check all the documented input formats
--
SET datestyle TO iso;  -- display results in ISO

SET datestyle TO ymd;

SELECT date 'January 8, 1999';
SELECT date '1999-01-08';
SELECT date '1999-01-18';
SELECT date '1/8/1999';
SELECT date '1/18/1999';
SELECT date '18/1/1999';
SELECT date '01/02/03';
SELECT date '19990108';
SELECT date '990108';
SELECT date '1999.008';
SELECT date 'J2451187';
SELECT date 'January 8, 99 BC';

SELECT date '99-Jan-08';
SELECT date '1999-Jan-08';
SELECT date '08-Jan-99';
SELECT date '08-Jan-1999';
SELECT date 'Jan-08-99';
SELECT date 'Jan-08-1999';
SELECT date '99-08-Jan';
SELECT date '1999-08-Jan';

SELECT date '99 Jan 08';
SELECT date '1999 Jan 08';
SELECT date '08 Jan 99';
SELECT date '08 Jan 1999';
SELECT date 'Jan 08 99';
SELECT date 'Jan 08 1999';
SELECT date '99 08 Jan';
SELECT date '1999 08 Jan';

SELECT date '99-01-08';
SELECT date '1999-01-08';
SELECT date '08-01-99';
SELECT date '08-01-1999';
SELECT date '01-08-99';
SELECT date '01-08-1999';
SELECT date '99-08-01';
SELECT date '1999-08-01';

SELECT date '99 01 08';
SELECT date '1999 01 08';
SELECT date '08 01 99';
SELECT date '08 01 1999';
SELECT date '01 08 99';
SELECT date '01 08 1999';
SELECT date '99 08 01';
SELECT date '1999 08 01';

SET datestyle TO dmy;

SELECT date 'January 8, 1999';
SELECT date '1999-01-08';
SELECT date '1999-01-18';
SELECT date '1/8/1999';
SELECT date '1/18/1999';
SELECT date '18/1/1999';
SELECT date '01/02/03';
SELECT date '19990108';
SELECT date '990108';
SELECT date '1999.008';
SELECT date 'J2451187';
SELECT date 'January 8, 99 BC';

SELECT date '99-Jan-08';
SELECT date '1999-Jan-08';
SELECT date '08-Jan-99';
SELECT date '08-Jan-1999';
SELECT date 'Jan-08-99';
SELECT date 'Jan-08-1999';
SELECT date '99-08-Jan';
SELECT date '1999-08-Jan';

SELECT date '99 Jan 08';
SELECT date '1999 Jan 08';
SELECT date '08 Jan 99';
SELECT date '08 Jan 1999';
SELECT date 'Jan 08 99';
SELECT date 'Jan 08 1999';
SELECT date '99 08 Jan';
SELECT date '1999 08 Jan';

SELECT date '99-01-08';
SELECT date '1999-01-08';
SELECT date '08-01-99';
SELECT date '08-01-1999';
SELECT date '01-08-99';
SELECT date '01-08-1999';
SELECT date '99-08-01';
SELECT date '1999-08-01';

SELECT date '99 01 08';
SELECT date '1999 01 08';
SELECT date '08 01 99';
SELECT date '08 01 1999';
SELECT date '01 08 99';
SELECT date '01 08 1999';
SELECT date '99 08 01';
SELECT date '1999 08 01';

SET datestyle TO mdy;

SELECT date 'January 8, 1999';
SELECT date '1999-01-08';
SELECT date '1999-01-18';
SELECT date '1/8/1999';
SELECT date '1/18/1999';
SELECT date '18/1/1999';
SELECT date '01/02/03';
SELECT date '19990108';
SELECT date '990108';
SELECT date '1999.008';
SELECT date 'J2451187';
SELECT date 'January 8, 99 BC';

SELECT date '99-Jan-08';
SELECT date '1999-Jan-08';
SELECT date '08-Jan-99';
SELECT date '08-Jan-1999';
SELECT date 'Jan-08-99';
SELECT date 'Jan-08-1999';
SELECT date '99-08-Jan';
SELECT date '1999-08-Jan';

SELECT date '99 Jan 08';
SELECT date '1999 Jan 08';
SELECT date '08 Jan 99';
SELECT date '08 Jan 1999';
SELECT date 'Jan 08 99';
SELECT date 'Jan 08 1999';
SELECT date '99 08 Jan';
SELECT date '1999 08 Jan';

SELECT date '99-01-08';
SELECT date '1999-01-08';
SELECT date '08-01-99';
SELECT date '08-01-1999';
SELECT date '01-08-99';
SELECT date '01-08-1999';
SELECT date '99-08-01';
SELECT date '1999-08-01';

SELECT date '99 01 08';
SELECT date '1999 01 08';
SELECT date '08 01 99';
SELECT date '08 01 1999';
SELECT date '01 08 99';
SELECT date '01 08 1999';
SELECT date '99 08 01';
SELECT date '1999 08 01';

-- Check upper and lower limits of date range
SELECT date '4714-11-24 BC';
SELECT date '4714-11-23 BC';  -- out of range
SELECT date '5874897-12-31';
SELECT date '5874898-01-01';  -- out of range

-- Test non-error-throwing API
SELECT pg_input_is_valid('now', 'date');
SELECT pg_input_is_valid('garbage', 'date');
SELECT pg_input_is_valid('6874898-01-01', 'date');
SELECT * FROM pg_input_error_info('garbage', 'date');
SELECT * FROM pg_input_error_info('6874898-01-01', 'date');

RESET datestyle;

--
-- Simple math
-- Leave most of it for the horology tests
--

SELECT f1 - date '2000-01-01' AS "Days From 2K" FROM DATE_TBL;

SELECT f1 - date 'epoch' AS "Days From Epoch" FROM DATE_TBL;

SELECT date 'yesterday' - date 'today' AS "One day";

SELECT date 'today' - date 'tomorrow' AS "One day";

SELECT date 'yesterday' - date 'tomorrow' AS "Two days";

SELECT date 'tomorrow' - date 'today' AS "One day";

SELECT date 'today' - date 'yesterday' AS "One day";

SELECT date 'tomorrow' - date 'yesterday' AS "Two days";

--
-- test extract!
--
SELECT f1 as "date",
    date_part('year', f1) AS year,
    date_part('month', f1) AS month,
    date_part('day', f1) AS day,
    date_part('quarter', f1) AS quarter,
    date_part('decade', f1) AS decade,
    date_part('century', f1) AS century,
    date_part('millennium', f1) AS millennium,
    date_part('isoyear', f1) AS isoyear,
    date_part('week', f1) AS week,
    date_part('dow', f1) AS dow,
    date_part('isodow', f1) AS isodow,
    date_part('doy', f1) AS doy,
    date_part('julian', f1) AS julian,
    date_part('epoch', f1) AS epoch
    FROM date_tbl;
--
-- epoch
--
SELECT EXTRACT(EPOCH FROM DATE        '1970-01-01');     --  0
--
-- century
--
SELECT EXTRACT(CENTURY FROM DATE '0101-12-31 BC'); -- -2
SELECT EXTRACT(CENTURY FROM DATE '0100-12-31 BC'); -- -1
SELECT EXTRACT(CENTURY FROM DATE '0001-12-31 BC'); -- -1
SELECT EXTRACT(CENTURY FROM DATE '0001-01-01');    --  1
SELECT EXTRACT(CENTURY FROM DATE '0001-01-01 AD'); --  1
SELECT EXTRACT(CENTURY FROM DATE '1900-12-31');    -- 19
SELECT EXTRACT(CENTURY FROM DATE '1901-01-01');    -- 20
SELECT EXTRACT(CENTURY FROM DATE '2000-12-31');    -- 20
SELECT EXTRACT(CENTURY FROM DATE '2001-01-01');    -- 21
SELECT EXTRACT(CENTURY FROM CURRENT_DATE)>=21 AS True;     -- true
--
-- millennium
--
SELECT EXTRACT(MILLENNIUM FROM DATE '0001-12-31 BC'); -- -1
SELECT EXTRACT(MILLENNIUM FROM DATE '0001-01-01 AD'); --  1
SELECT EXTRACT(MILLENNIUM FROM DATE '1000-12-31');    --  1
SELECT EXTRACT(MILLENNIUM FROM DATE '1001-01-01');    --  2
SELECT EXTRACT(MILLENNIUM FROM DATE '2000-12-31');    --  2
SELECT EXTRACT(MILLENNIUM FROM DATE '2001-01-01');    --  3
-- next test to be fixed on the turn of the next millennium /* REPLACED */,-)
SELECT EXTRACT(MILLENNIUM FROM CURRENT_DATE);         --  3
--
-- decade
--
SELECT EXTRACT(DECADE FROM DATE '1994-12-25');    -- 199
SELECT EXTRACT(DECADE FROM DATE '0010-01-01');    --   1
SELECT EXTRACT(DECADE FROM DATE '0009-12-31');    --   0
SELECT EXTRACT(DECADE FROM DATE '0001-01-01 BC'); --   0
SELECT EXTRACT(DECADE FROM DATE '0002-12-31 BC'); --  -1
SELECT EXTRACT(DECADE FROM DATE '0011-01-01 BC'); --  -1
SELECT EXTRACT(DECADE FROM DATE '0012-12-31 BC'); --  -2
--
-- all possible fields
--
SELECT EXTRACT(MICROSECONDS  FROM DATE '2020-08-11');
SELECT EXTRACT(MILLISECONDS  FROM DATE '2020-08-11');
SELECT EXTRACT(SECOND        FROM DATE '2020-08-11');
SELECT EXTRACT(MINUTE        FROM DATE '2020-08-11');
SELECT EXTRACT(HOUR          FROM DATE '2020-08-11');
SELECT EXTRACT(DAY           FROM DATE '2020-08-11');
SELECT EXTRACT(MONTH         FROM DATE '2020-08-11');
SELECT EXTRACT(YEAR          FROM DATE '2020-08-11');
SELECT EXTRACT(YEAR          FROM DATE '2020-08-11 BC');
SELECT EXTRACT(DECADE        FROM DATE '2020-08-11');
SELECT EXTRACT(CENTURY       FROM DATE '2020-08-11');
SELECT EXTRACT(MILLENNIUM    FROM DATE '2020-08-11');
SELECT EXTRACT(ISOYEAR       FROM DATE '2020-08-11');
SELECT EXTRACT(ISOYEAR       FROM DATE '2020-08-11 BC');
SELECT EXTRACT(QUARTER       FROM DATE '2020-08-11');
SELECT EXTRACT(WEEK          FROM DATE '2020-08-11');
SELECT EXTRACT(DOW           FROM DATE '2020-08-11');
SELECT EXTRACT(DOW           FROM DATE '2020-08-16');
SELECT EXTRACT(ISODOW        FROM DATE '2020-08-11');
SELECT EXTRACT(ISODOW        FROM DATE '2020-08-16');
SELECT EXTRACT(DOY           FROM DATE '2020-08-11');
SELECT EXTRACT(TIMEZONE      FROM DATE '2020-08-11');
SELECT EXTRACT(TIMEZONE_M    FROM DATE '2020-08-11');
SELECT EXTRACT(TIMEZONE_H    FROM DATE '2020-08-11');
SELECT EXTRACT(EPOCH         FROM DATE '2020-08-11');
SELECT EXTRACT(JULIAN        FROM DATE '2020-08-11');
--
-- test trunc function!
--
SELECT DATE_TRUNC('MILLENNIUM', TIMESTAMP '1970-03-20 04:30:00.00000'); -- 1001
SELECT DATE_TRUNC('MILLENNIUM', DATE '1970-03-20'); -- 1001-01-01
SELECT DATE_TRUNC('CENTURY', TIMESTAMP '1970-03-20 04:30:00.00000'); -- 1901
SELECT DATE_TRUNC('CENTURY', DATE '1970-03-20'); -- 1901
SELECT DATE_TRUNC('CENTURY', DATE '2004-08-10'); -- 2001-01-01
SELECT DATE_TRUNC('CENTURY', DATE '0002-02-04'); -- 0001-01-01
SELECT DATE_TRUNC('CENTURY', DATE '0055-08-10 BC'); -- 0100-01-01 BC
SELECT DATE_TRUNC('DECADE', DATE '1993-12-25'); -- 1990-01-01
SELECT DATE_TRUNC('DECADE', DATE '0004-12-25'); -- 0001-01-01 BC
SELECT DATE_TRUNC('DECADE', DATE '0002-12-31 BC'); -- 0011-01-01 BC
--
-- test infinity
--
select 'infinity'::date, '-infinity'::date;
select 'infinity'::date > 'today'::date as t;
select '-infinity'::date < 'today'::date as t;
select isfinite('infinity'::date), isfinite('-infinity'::date), isfinite('today'::date);
select 'infinity'::date = '+infinity'::date as t;

--
-- oscillating fields from non-finite date:
--
SELECT EXTRACT(DAY FROM DATE 'infinity');      -- NULL
SELECT EXTRACT(DAY FROM DATE '-infinity');     -- NULL
-- all supported fields
SELECT EXTRACT(DAY           FROM DATE 'infinity');    -- NULL
SELECT EXTRACT(MONTH         FROM DATE 'infinity');    -- NULL
SELECT EXTRACT(QUARTER       FROM DATE 'infinity');    -- NULL
SELECT EXTRACT(WEEK          FROM DATE 'infinity');    -- NULL
SELECT EXTRACT(DOW           FROM DATE 'infinity');    -- NULL
SELECT EXTRACT(ISODOW        FROM DATE 'infinity');    -- NULL
SELECT EXTRACT(DOY           FROM DATE 'infinity');    -- NULL
--
-- monotonic fields from non-finite date:
--
SELECT EXTRACT(EPOCH FROM DATE 'infinity');         --  Infinity
SELECT EXTRACT(EPOCH FROM DATE '-infinity');        -- -Infinity
-- all supported fields
SELECT EXTRACT(YEAR       FROM DATE 'infinity');    --  Infinity
SELECT EXTRACT(DECADE     FROM DATE 'infinity');    --  Infinity
SELECT EXTRACT(CENTURY    FROM DATE 'infinity');    --  Infinity
SELECT EXTRACT(MILLENNIUM FROM DATE 'infinity');    --  Infinity
SELECT EXTRACT(JULIAN     FROM DATE 'infinity');    --  Infinity
SELECT EXTRACT(ISOYEAR    FROM DATE 'infinity');    --  Infinity
SELECT EXTRACT(EPOCH      FROM DATE 'infinity');    --  Infinity
--
-- wrong fields from non-finite date:
--
SELECT EXTRACT(MICROSEC  FROM DATE 'infinity');     -- error

-- test constructors
select make_date(2013, 7, 15);
select make_date(-44, 3, 15);
select make_time(8, 20, 0.0);
-- should fail
select make_date(0, 7, 15);
select make_date(2013, 2, 30);
select make_date(2013, 13, 1);
select make_date(2013, 11, -1);
select make_time(10, 55, 100.1);
select make_time(24, 0, 2.1);
-- END setup from date 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from time 
--
-- TIME
--

CREATE TABLE TIME_TBL (f1 time(2));

INSERT INTO TIME_TBL VALUES ('00:00');
INSERT INTO TIME_TBL VALUES ('01:00');
-- as of 7.4, timezone spec should be accepted and ignored
INSERT INTO TIME_TBL VALUES ('02:03 PST');
INSERT INTO TIME_TBL VALUES ('11:59 EDT');
INSERT INTO TIME_TBL VALUES ('12:00');
INSERT INTO TIME_TBL VALUES ('12:01');
INSERT INTO TIME_TBL VALUES ('23:59');
INSERT INTO TIME_TBL VALUES ('11:59:59.99 PM');

INSERT INTO TIME_TBL VALUES ('2003-03-07 15:36:39 America/New_York');
INSERT INTO TIME_TBL VALUES ('2003-07-07 15:36:39 America/New_York');
-- this should fail (the timezone offset is not known)
INSERT INTO TIME_TBL VALUES ('15:36:39 America/New_York');


SELECT f1 AS "Time" FROM TIME_TBL;

SELECT f1 AS "Three" FROM TIME_TBL WHERE f1 < '05:06:07';

SELECT f1 AS "Five" FROM TIME_TBL WHERE f1 > '05:06:07';

SELECT f1 AS "None" FROM TIME_TBL WHERE f1 < '00:00';

SELECT f1 AS "Eight" FROM TIME_TBL WHERE f1 >= '00:00';

-- Check edge cases
SELECT '23:59:59.999999'::time;
SELECT '23:59:59.9999999'::time;  -- rounds up
SELECT '23:59:60'::time;  -- rounds up
SELECT '24:00:00'::time;  -- allowed
SELECT '24:00:00.01'::time;  -- not allowed
SELECT '23:59:60.01'::time;  -- not allowed
SELECT '24:01:00'::time;  -- not allowed
SELECT '25:00:00'::time;  -- not allowed

-- Test non-error-throwing API
SELECT pg_input_is_valid('12:00:00', 'time');
SELECT pg_input_is_valid('25:00:00', 'time');
SELECT pg_input_is_valid('15:36:39 America/New_York', 'time');
SELECT * FROM pg_input_error_info('25:00:00', 'time');
SELECT * FROM pg_input_error_info('15:36:39 America/New_York', 'time');

--
-- TIME simple math
--
-- We now make a distinction between time and intervals,
-- and adding two times together makes no sense at all.
-- Leave in one query to show that it is rejected,
-- and do the rest of the testing in horology.sql
-- where we do mixed-type arithmetic. - thomas 2000-12-02

SELECT f1 + time '00:01' AS "Illegal" FROM TIME_TBL;

--
-- test EXTRACT
--
SELECT EXTRACT(MICROSECOND FROM TIME '2020-05-26 13:30:25.575401');
SELECT EXTRACT(MILLISECOND FROM TIME '2020-05-26 13:30:25.575401');
SELECT EXTRACT(SECOND      FROM TIME '2020-05-26 13:30:25.575401');
SELECT EXTRACT(MINUTE      FROM TIME '2020-05-26 13:30:25.575401');
SELECT EXTRACT(HOUR        FROM TIME '2020-05-26 13:30:25.575401');
SELECT EXTRACT(DAY         FROM TIME '2020-05-26 13:30:25.575401');  -- error
SELECT EXTRACT(FORTNIGHT   FROM TIME '2020-05-26 13:30:25.575401');  -- error
SELECT EXTRACT(TIMEZONE    FROM TIME '2020-05-26 13:30:25.575401');  -- error
SELECT EXTRACT(EPOCH       FROM TIME '2020-05-26 13:30:25.575401');

-- date_part implementation is mostly the same as extract, so only
-- test a few cases for additional coverage.
SELECT date_part('microsecond', TIME '2020-05-26 13:30:25.575401');
SELECT date_part('millisecond', TIME '2020-05-26 13:30:25.575401');
SELECT date_part('second',      TIME '2020-05-26 13:30:25.575401');
SELECT date_part('epoch',       TIME '2020-05-26 13:30:25.575401');
-- END setup from time 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from timetz 
--
-- TIMETZ
--

CREATE TABLE TIMETZ_TBL (f1 time(2) with time zone);

INSERT INTO TIMETZ_TBL VALUES ('00:01 PDT');
INSERT INTO TIMETZ_TBL VALUES ('01:00 PDT');
INSERT INTO TIMETZ_TBL VALUES ('02:03 PDT');
INSERT INTO TIMETZ_TBL VALUES ('07:07 PST');
INSERT INTO TIMETZ_TBL VALUES ('08:08 EDT');
INSERT INTO TIMETZ_TBL VALUES ('11:59 PDT');
INSERT INTO TIMETZ_TBL VALUES ('12:00 PDT');
INSERT INTO TIMETZ_TBL VALUES ('12:01 PDT');
INSERT INTO TIMETZ_TBL VALUES ('23:59 PDT');
INSERT INTO TIMETZ_TBL VALUES ('11:59:59.99 PM PDT');

INSERT INTO TIMETZ_TBL VALUES ('2003-03-07 15:36:39 America/New_York');
INSERT INTO TIMETZ_TBL VALUES ('2003-07-07 15:36:39 America/New_York');
-- this should fail (the timezone offset is not known)
INSERT INTO TIMETZ_TBL VALUES ('15:36:39 America/New_York');
-- this should fail (timezone not specified without a date)
INSERT INTO TIMETZ_TBL VALUES ('15:36:39 m2');
-- this should fail (dynamic timezone abbreviation without a date)
INSERT INTO TIMETZ_TBL VALUES ('15:36:39 MSK m2');


SELECT f1 AS "Time TZ" FROM TIMETZ_TBL;

SELECT f1 AS "Three" FROM TIMETZ_TBL WHERE f1 < '05:06:07-07';

SELECT f1 AS "Seven" FROM TIMETZ_TBL WHERE f1 > '05:06:07-07';

SELECT f1 AS "None" FROM TIMETZ_TBL WHERE f1 < '00:00-07';

SELECT f1 AS "Ten" FROM TIMETZ_TBL WHERE f1 >= '00:00-07';

-- Check edge cases
SELECT '23:59:59.999999 PDT'::timetz;
SELECT '23:59:59.9999999 PDT'::timetz;  -- rounds up
SELECT '23:59:60 PDT'::timetz;  -- rounds up
SELECT '24:00:00 PDT'::timetz;  -- allowed
SELECT '24:00:00.01 PDT'::timetz;  -- not allowed
SELECT '23:59:60.01 PDT'::timetz;  -- not allowed
SELECT '24:01:00 PDT'::timetz;  -- not allowed
SELECT '25:00:00 PDT'::timetz;  -- not allowed

-- Test non-error-throwing API
SELECT pg_input_is_valid('12:00:00 PDT', 'timetz');
SELECT pg_input_is_valid('25:00:00 PDT', 'timetz');
SELECT pg_input_is_valid('15:36:39 America/New_York', 'timetz');
SELECT * FROM pg_input_error_info('25:00:00 PDT', 'timetz');
SELECT * FROM pg_input_error_info('15:36:39 America/New_York', 'timetz');

--
-- TIME simple math
--
-- We now make a distinction between time and intervals,
-- and adding two times together makes no sense at all.
-- Leave in one query to show that it is rejected,
-- and do the rest of the testing in horology.sql
-- where we do mixed-type arithmetic. - thomas 2000-12-02

SELECT f1 + time with time zone '00:01' AS "Illegal" FROM TIMETZ_TBL;

--
-- test EXTRACT
--
SELECT EXTRACT(MICROSECOND FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');
SELECT EXTRACT(MILLISECOND FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');
SELECT EXTRACT(SECOND      FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');
SELECT EXTRACT(MINUTE      FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');
SELECT EXTRACT(HOUR        FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');
SELECT EXTRACT(DAY         FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');  -- error
SELECT EXTRACT(FORTNIGHT   FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');  -- error
SELECT EXTRACT(TIMEZONE    FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04:30');
SELECT EXTRACT(TIMEZONE_HOUR   FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04:30');
SELECT EXTRACT(TIMEZONE_MINUTE FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04:30');
SELECT EXTRACT(EPOCH       FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');

-- date_part implementation is mostly the same as extract, so only
-- test a few cases for additional coverage.
SELECT date_part('microsecond', TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');
SELECT date_part('millisecond', TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');
SELECT date_part('second',      TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');
SELECT date_part('epoch',       TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04');

--
-- Test timetz_zone, timetz_izone, AT LOCAL
--
BEGIN;
SET LOCAL TimeZone TO 'UTC';
CREATE VIEW timetz_local_view AS
  SELECT f1 AS dat,
       timezone(f1) AS dat_func,
       f1 AT LOCAL AS dat_at_local,
       f1 AT TIME ZONE current_setting('TimeZone') AS dat_at_tz,
       f1 AT TIME ZONE INTERVAL '00:00' AS dat_at_int
  FROM TIMETZ_TBL
  ORDER BY f1;
SELECT pg_get_viewdef('timetz_local_view', true);
TABLE timetz_local_view;
SELECT f1 AS dat,
       f1 AT TIME ZONE 'UTC+10' AS dat_at_tz,
       f1 AT TIME ZONE INTERVAL '-10:00' AS dat_at_int
  FROM TIMETZ_TBL
  ORDER BY f1;
ROLLBACK;
-- END setup from timetz 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from timestamp 
--
-- TIMESTAMP
--

CREATE TABLE TIMESTAMP_TBL (d1 timestamp(2) without time zone);

-- Test shorthand input values
-- We can/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t just /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''select/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' the results since they aren/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t constants /* REPLACED */, test for
-- equality instead.  We can do that by running the test inside a transaction
-- block, within which the value of /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''now/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' shouldn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t change, and so these
-- related values shouldn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t either.

BEGIN;

INSERT INTO TIMESTAMP_TBL VALUES ('today');
INSERT INTO TIMESTAMP_TBL VALUES ('yesterday');
INSERT INTO TIMESTAMP_TBL VALUES ('tomorrow');
-- time zone should be ignored by this data type
INSERT INTO TIMESTAMP_TBL VALUES ('tomorrow EST');
INSERT INTO TIMESTAMP_TBL VALUES ('tomorrow zulu');

SELECT count(*) AS One FROM TIMESTAMP_TBL WHERE d1 = timestamp without time zone 'today';
SELECT count(*) AS Three FROM TIMESTAMP_TBL WHERE d1 = timestamp without time zone 'tomorrow';
SELECT count(*) AS One FROM TIMESTAMP_TBL WHERE d1 = timestamp without time zone 'yesterday';

COMMIT;

DELETE FROM TIMESTAMP_TBL;

-- Verify that /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''now/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' *does* change over a reasonable interval such as 100 msec,
-- and that it doesn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t change over the same interval within a transaction block

INSERT INTO TIMESTAMP_TBL VALUES ('now');
SELECT pg_sleep(0.1);

BEGIN;
INSERT INTO TIMESTAMP_TBL VALUES ('now');
SELECT pg_sleep(0.1);
INSERT INTO TIMESTAMP_TBL VALUES ('now');
SELECT pg_sleep(0.1);
SELECT count(*) AS two FROM TIMESTAMP_TBL WHERE d1 = timestamp(2) without time zone 'now';
SELECT count(d1) AS three, count(DISTINCT d1) AS two FROM TIMESTAMP_TBL;
COMMIT;

TRUNCATE TIMESTAMP_TBL;

-- Special values
INSERT INTO TIMESTAMP_TBL VALUES ('-infinity');
INSERT INTO TIMESTAMP_TBL VALUES ('infinity');
INSERT INTO TIMESTAMP_TBL VALUES ('epoch');

SELECT timestamp 'infinity' = timestamp '+infinity' AS t;

-- Postgres v6.0 standard output format
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01 1997 PST');

-- Variations on Postgres v6.1 standard output format
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01.000001 1997 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01.999999 1997 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01.4 1997 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01.5 1997 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Mon Feb 10 17:32:01.6 1997 PST');

-- ISO 8601 format
INSERT INTO TIMESTAMP_TBL VALUES ('1997-01-02');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-01-02 03:04:05');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-02-10 17:32:01-08');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-02-10 17:32:01-0800');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-02-10 17:32:01 -08:00');
INSERT INTO TIMESTAMP_TBL VALUES ('19970210 173201 -0800');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-06-10 17:32:01 -07:00');
INSERT INTO TIMESTAMP_TBL VALUES ('2001-09-22T18:19:20');

-- POSIX format (note that the timezone abbrev is just decoration here)
INSERT INTO TIMESTAMP_TBL VALUES ('2000-03-15 08:14:01 GMT+8');
INSERT INTO TIMESTAMP_TBL VALUES ('2000-03-15 13:14:02 GMT-1');
INSERT INTO TIMESTAMP_TBL VALUES ('2000-03-15 12:14:03 GMT-2');
INSERT INTO TIMESTAMP_TBL VALUES ('2000-03-15 03:14:04 PST+8');
INSERT INTO TIMESTAMP_TBL VALUES ('2000-03-15 02:14:05 MST+7:00');

-- Variations for acceptable input formats
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 10 17:32:01 1997 -0800');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 10 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 10 5:32PM 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('1997/02/10 17:32:01-0800');
INSERT INTO TIMESTAMP_TBL VALUES ('1997-02-10 17:32:01 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb-10-1997 17:32:01 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('02-10-1997 17:32:01 PST');
INSERT INTO TIMESTAMP_TBL VALUES ('19970210 173201 PST');
set datestyle to ymd;
INSERT INTO TIMESTAMP_TBL VALUES ('97FEB10 5:32:01PM UTC');
INSERT INTO TIMESTAMP_TBL VALUES ('97/02/10 17:32:01 UTC');
reset datestyle;
INSERT INTO TIMESTAMP_TBL VALUES ('1997.041 17:32:01 UTC');
INSERT INTO TIMESTAMP_TBL VALUES ('19970210 173201 America/New_York');
-- this fails (even though TZ is a no-op, we still look it up)
INSERT INTO TIMESTAMP_TBL VALUES ('19970710 173201 America/Does_not_exist');

-- Test non-error-throwing API
SELECT pg_input_is_valid('now', 'timestamp');
SELECT pg_input_is_valid('garbage', 'timestamp');
SELECT pg_input_is_valid('2001-01-01 00:00 Nehwon/Lankhmar', 'timestamp');
SELECT * FROM pg_input_error_info('garbage', 'timestamp');
SELECT * FROM pg_input_error_info('2001-01-01 00:00 Nehwon/Lankhmar', 'timestamp');

-- Check date conversion and date arithmetic
INSERT INTO TIMESTAMP_TBL VALUES ('1997-06-10 18:32:01 PDT');

INSERT INTO TIMESTAMP_TBL VALUES ('Feb 10 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 11 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 12 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 13 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 14 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 15 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1997');

INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 0097 BC');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 0097');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 0597');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1097');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1697');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1797');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1897');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 2097');

INSERT INTO TIMESTAMP_TBL VALUES ('Feb 28 17:32:01 1996');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 29 17:32:01 1996');
INSERT INTO TIMESTAMP_TBL VALUES ('Mar 01 17:32:01 1996');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 30 17:32:01 1996');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 31 17:32:01 1996');
INSERT INTO TIMESTAMP_TBL VALUES ('Jan 01 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 28 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 29 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Mar 01 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 30 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 31 17:32:01 1997');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 31 17:32:01 1999');
INSERT INTO TIMESTAMP_TBL VALUES ('Jan 01 17:32:01 2000');
INSERT INTO TIMESTAMP_TBL VALUES ('Dec 31 17:32:01 2000');
INSERT INTO TIMESTAMP_TBL VALUES ('Jan 01 17:32:01 2001');

-- Currently unsupported syntax and ranges
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 -0097');
INSERT INTO TIMESTAMP_TBL VALUES ('Feb 16 17:32:01 5097 BC');

SELECT d1 FROM TIMESTAMP_TBL;

-- Check behavior at the boundaries of the timestamp range
SELECT '4714-11-24 00:00:00 BC'::timestamp;
SELECT '4714-11-23 23:59:59 BC'::timestamp;  -- out of range
SELECT '294276-12-31 23:59:59'::timestamp;
SELECT '294277-01-01 00:00:00'::timestamp;  -- out of range

-- Demonstrate functions and operators
SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 > timestamp without time zone '1997-01-02';

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 < timestamp without time zone '1997-01-02';

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 = timestamp without time zone '1997-01-02';

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 != timestamp without time zone '1997-01-02';

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 <= timestamp without time zone '1997-01-02';

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 >= timestamp without time zone '1997-01-02';

SELECT d1 - timestamp without time zone '1997-01-02' AS diff
   FROM TIMESTAMP_TBL WHERE d1 BETWEEN '1902-01-01' AND '2038-01-01';

SELECT date_trunc( 'week', timestamp '2004-02-29 15:44:17.71393' ) AS week_trunc;

-- verify date_bin behaves the same as date_trunc for relevant intervals

-- case 1: AD dates, origin < input
SELECT
  str,
  interval,
  date_trunc(str, ts) = date_bin(interval::interval, ts, timestamp '2001-01-01') AS equal
FROM (
  VALUES
  ('week', '7 d'),
  ('day', '1 d'),
  ('hour', '1 h'),
  ('minute', '1 m'),
  ('second', '1 s'),
  ('millisecond', '1 ms'),
  ('microsecond', '1 us')
) intervals (str, interval),
(VALUES (timestamp '2020-02-29 15:44:17.71393')) ts (ts);

-- case 2: BC dates, origin < input
SELECT
  str,
  interval,
  date_trunc(str, ts) = date_bin(interval::interval, ts, timestamp '2000-01-01 BC') AS equal
FROM (
  VALUES
  ('week', '7 d'),
  ('day', '1 d'),
  ('hour', '1 h'),
  ('minute', '1 m'),
  ('second', '1 s'),
  ('millisecond', '1 ms'),
  ('microsecond', '1 us')
) intervals (str, interval),
(VALUES (timestamp '0055-6-10 15:44:17.71393 BC')) ts (ts);

-- case 3: AD dates, origin > input
SELECT
  str,
  interval,
  date_trunc(str, ts) = date_bin(interval::interval, ts, timestamp '2020-03-02') AS equal
FROM (
  VALUES
  ('week', '7 d'),
  ('day', '1 d'),
  ('hour', '1 h'),
  ('minute', '1 m'),
  ('second', '1 s'),
  ('millisecond', '1 ms'),
  ('microsecond', '1 us')
) intervals (str, interval),
(VALUES (timestamp '2020-02-29 15:44:17.71393')) ts (ts);

-- case 4: BC dates, origin > input
SELECT
  str,
  interval,
  date_trunc(str, ts) = date_bin(interval::interval, ts, timestamp '0055-06-17 BC') AS equal
FROM (
  VALUES
  ('week', '7 d'),
  ('day', '1 d'),
  ('hour', '1 h'),
  ('minute', '1 m'),
  ('second', '1 s'),
  ('millisecond', '1 ms'),
  ('microsecond', '1 us')
) intervals (str, interval),
(VALUES (timestamp '0055-6-10 15:44:17.71393 BC')) ts (ts);

-- bin timestamps into arbitrary intervals
SELECT
  interval,
  ts,
  origin,
  date_bin(interval::interval, ts, origin)
FROM (
  VALUES
  ('15 days'),
  ('2 hours'),
  ('1 hour 30 minutes'),
  ('15 minutes'),
  ('10 seconds'),
  ('100 milliseconds'),
  ('250 microseconds')
) intervals (interval),
(VALUES (timestamp '2020-02-11 15:44:17.71393')) ts (ts),
(VALUES (timestamp '2001-01-01')) origin (origin);

-- shift bins using the origin parameter:
SELECT date_bin('5 min'::interval, timestamp '2020-02-01 01:01:01', timestamp '2020-02-01 00:02:30');

-- test roundoff edge case when source < origin
SELECT date_bin('30 minutes'::interval, timestamp '2024-02-01 15:00:00', timestamp '2024-02-01 17:00:00');

-- disallow intervals with months or years
SELECT date_bin('5 months'::interval, timestamp '2020-02-01 01:01:01', timestamp '2001-01-01');
SELECT date_bin('5 years'::interval,  timestamp '2020-02-01 01:01:01', timestamp '2001-01-01');

-- disallow zero intervals
SELECT date_bin('0 days'::interval, timestamp '1970-01-01 01:00:00' , timestamp '1970-01-01 00:00:00');

-- disallow negative intervals
SELECT date_bin('-2 days'::interval, timestamp '1970-01-01 01:00:00' , timestamp '1970-01-01 00:00:00');

-- test overflow cases
select date_bin('15 minutes'::interval, timestamp '294276-12-30', timestamp '4000-12-20 BC');
select date_bin('200000000 days'::interval, '2024-02-01'::timestamp, '2024-01-01'::timestamp);
select date_bin('365000 days'::interval, '4400-01-01 BC'::timestamp, '4000-01-01 BC'::timestamp);

-- Test casting within a BETWEEN qualifier
SELECT d1 - timestamp without time zone '1997-01-02' AS diff
  FROM TIMESTAMP_TBL
  WHERE d1 BETWEEN timestamp without time zone '1902-01-01'
   AND timestamp without time zone '2038-01-01';

-- DATE_PART (timestamp_part)
SELECT d1 as "timestamp",
   date_part( 'year', d1) AS year, date_part( 'month', d1) AS month,
   date_part( 'day', d1) AS day, date_part( 'hour', d1) AS hour,
   date_part( 'minute', d1) AS minute, date_part( 'second', d1) AS second
   FROM TIMESTAMP_TBL;

SELECT d1 as "timestamp",
   date_part( 'quarter', d1) AS quarter, date_part( 'msec', d1) AS msec,
   date_part( 'usec', d1) AS usec
   FROM TIMESTAMP_TBL;

SELECT d1 as "timestamp",
   date_part( 'isoyear', d1) AS isoyear, date_part( 'week', d1) AS week,
   date_part( 'isodow', d1) AS isodow, date_part( 'dow', d1) AS dow,
   date_part( 'doy', d1) AS doy
   FROM TIMESTAMP_TBL;

SELECT d1 as "timestamp",
   date_part( 'decade', d1) AS decade,
   date_part( 'century', d1) AS century,
   date_part( 'millennium', d1) AS millennium,
   round(date_part( 'julian', d1)) AS julian,
   date_part( 'epoch', d1) AS epoch
   FROM TIMESTAMP_TBL;

-- extract implementation is mostly the same as date_part, so only
-- test a few cases for additional coverage.
SELECT d1 as "timestamp",
   extract(microseconds from d1) AS microseconds,
   extract(milliseconds from d1) AS milliseconds,
   extract(seconds from d1) AS seconds,
   round(extract(julian from d1)) AS julian,
   extract(epoch from d1) AS epoch
   FROM TIMESTAMP_TBL;

-- value near upper bound uses special case in code
SELECT date_part('epoch', '294270-01-01 00:00:00'::timestamp);
SELECT extract(epoch from '294270-01-01 00:00:00'::timestamp);
-- another internal overflow test case
SELECT extract(epoch from '5000-01-01 00:00:00'::timestamp);

-- test edge-case overflow in timestamp subtraction
SELECT timestamp '294276-12-31 23:59:59' - timestamp '1999-12-23 19:59:04.224193' AS ok;
SELECT timestamp '294276-12-31 23:59:59' - timestamp '1999-12-23 19:59:04.224192' AS overflows;

-- TO_CHAR()
SELECT to_char(d1, 'DAY Day day DY Dy dy MONTH Month month RM MON Mon mon')
   FROM TIMESTAMP_TBL;

SELECT to_char(d1, 'FMDAY FMDay FMday FMMONTH FMMonth FMmonth FMRM')
   FROM TIMESTAMP_TBL;

SELECT to_char(d1, 'Y,YYY YYYY YYY YY Y CC Q MM WW DDD DD D J')
   FROM TIMESTAMP_TBL;

SELECT to_char(d1, 'FMY,YYY FMYYYY FMYYY FMYY FMY FMCC FMQ FMMM FMWW FMDDD FMDD FMD FMJ')
   FROM TIMESTAMP_TBL;

SELECT to_char(d1, 'HH HH12 HH24 MI SS SSSS')
   FROM TIMESTAMP_TBL;

SELECT to_char(d1, E'"HH:MI:SS is" HH:MI:SS "\\"text between quote marks\\""')
   FROM TIMESTAMP_TBL;

SELECT to_char(d1, 'HH24--text--MI--text--SS/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'')
   FROM TIMESTAMP_TBL;

SELECT to_char(d1, 'YYYYTH YYYYth Jth')
   FROM TIMESTAMP_TBL;

SELECT to_char(d1, 'YYYY A.D. YYYY a.d. YYYY bc HH:MI:SS P.M. HH:MI:SS p.m. HH:MI:SS pm')
   FROM TIMESTAMP_TBL;

SELECT to_char(d1, 'IYYY IYY IY I IW IDDD ID')
   FROM TIMESTAMP_TBL;

SELECT to_char(d1, 'FMIYYY FMIYY FMIY FMI FMIW FMIDDD FMID')
   FROM TIMESTAMP_TBL;

SELECT to_char(d, 'FF1 FF2 FF3 FF4 FF5 FF6  ff1 ff2 ff3 ff4 ff5 ff6  MS US')
   FROM (VALUES
       ('2018-11-02 12:34:56'::timestamp),
       ('2018-11-02 12:34:56.78'),
       ('2018-11-02 12:34:56.78901'),
       ('2018-11-02 12:34:56.78901234')
   ) d(d);

-- Roman months, with upper and lower case.
SELECT i,
       to_char(i * interval '1mon', 'rm'),
       to_char(i * interval '1mon', 'RM')
    FROM generate_series(-13, 13) i;

-- timestamp numeric fields constructor
SELECT make_timestamp(2014, 12, 28, 6, 30, 45.887);
SELECT make_timestamp(-44, 3, 15, 12, 30, 15);
-- should fail
select make_timestamp(0, 7, 15, 12, 30, 15);

-- generate_series for timestamp
select * from generate_series('2020-01-01 00:00'::timestamp,
                              '2020-01-02 03:00'::timestamp,
                              '1 hour'::interval);
-- the LIMIT should allow this to terminate in a reasonable amount of time
-- (but that unfortunately doesn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t work yet for SELECT * FROM ...)
select generate_series('2022-01-01 00:00'::timestamp,
                       'infinity'::timestamp,
                       '1 month'::interval) limit 10;
-- errors
select * from generate_series('2020-01-01 00:00'::timestamp,
                              '2020-01-02 03:00'::timestamp,
                              '0 hour'::interval);
select generate_series(timestamp '1995-08-06 12:12:12', timestamp '1996-08-06 12:12:12', interval 'infinity');
select generate_series(timestamp '1995-08-06 12:12:12', timestamp '1996-08-06 12:12:12', interval '-infinity');


-- test arithmetic with infinite timestamps
select timestamp 'infinity' - timestamp 'infinity';
select timestamp 'infinity' - timestamp '-infinity';
select timestamp '-infinity' - timestamp 'infinity';
select timestamp '-infinity' - timestamp '-infinity';
select timestamp 'infinity' - timestamp '1995-08-06 12:12:12';
select timestamp '-infinity' - timestamp '1995-08-06 12:12:12';

-- test age() with infinite timestamps
select age(timestamp 'infinity');
select age(timestamp '-infinity');
select age(timestamp 'infinity', timestamp 'infinity');
select age(timestamp 'infinity', timestamp '-infinity');
select age(timestamp '-infinity', timestamp 'infinity');
select age(timestamp '-infinity', timestamp '-infinity');
-- END setup from timestamp 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from timestamptz 
--
-- TIMESTAMPTZ
--

CREATE TABLE TIMESTAMPTZ_TBL (d1 timestamp(2) with time zone);

-- Test shorthand input values
-- We can/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t just /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''select/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' the results since they aren/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t constants /* REPLACED */, test for
-- equality instead.  We can do that by running the test inside a transaction
-- block, within which the value of /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''now/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' shouldn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t change, and so these
-- related values shouldn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t either.

BEGIN;

INSERT INTO TIMESTAMPTZ_TBL VALUES ('today');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('yesterday');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('tomorrow');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('tomorrow EST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('tomorrow zulu');

SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'today';
SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'tomorrow';
SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'yesterday';
SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'tomorrow EST';
SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'tomorrow zulu';

COMMIT;

DELETE FROM TIMESTAMPTZ_TBL;

-- Verify that /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''now/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' *does* change over a reasonable interval such as 100 msec,
-- and that it doesn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t change over the same interval within a transaction block

INSERT INTO TIMESTAMPTZ_TBL VALUES ('now');
SELECT pg_sleep(0.1);

BEGIN;
INSERT INTO TIMESTAMPTZ_TBL VALUES ('now');
SELECT pg_sleep(0.1);
INSERT INTO TIMESTAMPTZ_TBL VALUES ('now');
SELECT pg_sleep(0.1);
SELECT count(*) AS two FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp(2) with time zone 'now';
SELECT count(d1) AS three, count(DISTINCT d1) AS two FROM TIMESTAMPTZ_TBL;
COMMIT;

TRUNCATE TIMESTAMPTZ_TBL;

-- Special values
INSERT INTO TIMESTAMPTZ_TBL VALUES ('-infinity');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('infinity');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('epoch');

SELECT timestamptz 'infinity' = timestamptz '+infinity' AS t;

-- Postgres v6.0 standard output format
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01 1997 PST');

-- Variations on Postgres v6.1 standard output format
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01.000001 1997 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01.999999 1997 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01.4 1997 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01.5 1997 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mon Feb 10 17:32:01.6 1997 PST');

-- ISO 8601 format
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-01-02');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-01-02 03:04:05');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-02-10 17:32:01-08');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-02-10 17:32:01-0800');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-02-10 17:32:01 -08:00');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('19970210 173201 -0800');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-06-10 17:32:01 -07:00');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2001-09-22T18:19:20');

-- POSIX format (note that the timezone abbrev is just decoration here)
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2000-03-15 08:14:01 GMT+8');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2000-03-15 13:14:02 GMT-1');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2000-03-15 12:14:03 GMT-2');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2000-03-15 03:14:04 PST+8');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('2000-03-15 02:14:05 MST+7:00');

-- Variations for acceptable input formats
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 10 17:32:01 1997 -0800');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 10 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 10 5:32PM 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997/02/10 17:32:01-0800');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-02-10 17:32:01 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb-10-1997 17:32:01 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('02-10-1997 17:32:01 PST');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('19970210 173201 PST');
set datestyle to ymd;
INSERT INTO TIMESTAMPTZ_TBL VALUES ('97FEB10 5:32:01PM UTC');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('97/02/10 17:32:01 UTC');
reset datestyle;
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997.041 17:32:01 UTC');

-- timestamps at different timezones
INSERT INTO TIMESTAMPTZ_TBL VALUES ('19970210 173201 America/New_York');
SELECT '19970210 173201' AT TIME ZONE 'America/New_York';
INSERT INTO TIMESTAMPTZ_TBL VALUES ('19970710 173201 America/New_York');
SELECT '19970710 173201' AT TIME ZONE 'America/New_York';
INSERT INTO TIMESTAMPTZ_TBL VALUES ('19970710 173201 America/Does_not_exist');
SELECT '19970710 173201' AT TIME ZONE 'America/Does_not_exist';

-- Daylight saving time for timestamps beyond 32-bit time_t range.
SELECT '20500710 173201 Europe/Helsinki'::timestamptz; -- DST
SELECT '20500110 173201 Europe/Helsinki'::timestamptz; -- non-DST

SELECT '205000-07-10 17:32:01 Europe/Helsinki'::timestamptz; -- DST
SELECT '205000-01-10 17:32:01 Europe/Helsinki'::timestamptz; -- non-DST

-- Test non-error-throwing API
SELECT pg_input_is_valid('now', 'timestamptz');
SELECT pg_input_is_valid('garbage', 'timestamptz');
SELECT pg_input_is_valid('2001-01-01 00:00 Nehwon/Lankhmar', 'timestamptz');
SELECT * FROM pg_input_error_info('garbage', 'timestamptz');
SELECT * FROM pg_input_error_info('2001-01-01 00:00 Nehwon/Lankhmar', 'timestamptz');

-- Check date conversion and date arithmetic
INSERT INTO TIMESTAMPTZ_TBL VALUES ('1997-06-10 18:32:01 PDT');

INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 10 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 11 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 12 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 13 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 14 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 15 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1997');

INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 0097 BC');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 0097');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 0597');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1097');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1697');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1797');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1897');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 2097');

INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 28 17:32:01 1996');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 29 17:32:01 1996');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mar 01 17:32:01 1996');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 30 17:32:01 1996');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 31 17:32:01 1996');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Jan 01 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 28 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 29 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Mar 01 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 30 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 31 17:32:01 1997');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 31 17:32:01 1999');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Jan 01 17:32:01 2000');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Dec 31 17:32:01 2000');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Jan 01 17:32:01 2001');

-- Currently unsupported syntax and ranges
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 -0097');
INSERT INTO TIMESTAMPTZ_TBL VALUES ('Feb 16 17:32:01 5097 BC');

-- Alternative field order that we/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''ve historically supported (sort of)
-- with regular and POSIXy timezone specs
SELECT 'Wed Jul 11 10:51:14 America/New_York 2001'::timestamptz;
SELECT 'Wed Jul 11 10:51:14 GMT-4 2001'::timestamptz;
SELECT 'Wed Jul 11 10:51:14 GMT+4 2001'::timestamptz;
SELECT 'Wed Jul 11 10:51:14 PST-03:00 2001'::timestamptz;
SELECT 'Wed Jul 11 10:51:14 PST+03:00 2001'::timestamptz;

SELECT d1 FROM TIMESTAMPTZ_TBL;

-- Check behavior at the boundaries of the timestamp range
SELECT '4714-11-24 00:00:00+00 BC'::timestamptz;
SELECT '4714-11-23 16:00:00-08 BC'::timestamptz;
SELECT 'Sun Nov 23 16:00:00 4714 PST BC'::timestamptz;
SELECT '4714-11-23 23:59:59+00 BC'::timestamptz;  -- out of range
SELECT '294276-12-31 23:59:59+00'::timestamptz;
SELECT '294276-12-31 15:59:59-08'::timestamptz;
SELECT '294277-01-01 00:00:00+00'::timestamptz;  -- out of range
SELECT '294277-12-31 16:00:00-08'::timestamptz;  -- out of range

-- Demonstrate functions and operators
SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 > timestamp with time zone '1997-01-02';

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 < timestamp with time zone '1997-01-02';

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 = timestamp with time zone '1997-01-02';

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 != timestamp with time zone '1997-01-02';

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 <= timestamp with time zone '1997-01-02';

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 >= timestamp with time zone '1997-01-02';

SELECT d1 - timestamp with time zone '1997-01-02' AS diff
   FROM TIMESTAMPTZ_TBL WHERE d1 BETWEEN '1902-01-01' AND '2038-01-01';

SELECT date_trunc( 'week', timestamp with time zone '2004-02-29 15:44:17.71393' ) AS week_trunc;

SELECT date_trunc('day', timestamp with time zone '2001-02-16 20:38:40+00', 'Australia/Sydney') as sydney_trunc;  -- zone name
SELECT date_trunc('day', timestamp with time zone '2001-02-16 20:38:40+00', 'GMT') as gmt_trunc;  -- fixed-offset abbreviation
SELECT date_trunc('day', timestamp with time zone '2001-02-16 20:38:40+00', 'VET') as vet_trunc;  -- variable-offset abbreviation

-- verify date_bin behaves the same as date_trunc for relevant intervals
SELECT
  str,
  interval,
  date_trunc(str, ts, 'Australia/Sydney') = date_bin(interval::interval, ts, timestamp with time zone '2001-01-01+11') AS equal
FROM (
  VALUES
  ('day', '1 d'),
  ('hour', '1 h'),
  ('minute', '1 m'),
  ('second', '1 s'),
  ('millisecond', '1 ms'),
  ('microsecond', '1 us')
) intervals (str, interval),
(VALUES (timestamptz '2020-02-29 15:44:17.71393+00')) ts (ts);

-- bin timestamps into arbitrary intervals
SELECT
  interval,
  ts,
  origin,
  date_bin(interval::interval, ts, origin)
FROM (
  VALUES
  ('15 days'),
  ('2 hours'),
  ('1 hour 30 minutes'),
  ('15 minutes'),
  ('10 seconds'),
  ('100 milliseconds'),
  ('250 microseconds')
) intervals (interval),
(VALUES (timestamptz '2020-02-11 15:44:17.71393')) ts (ts),
(VALUES (timestamptz '2001-01-01')) origin (origin);

-- shift bins using the origin parameter:
SELECT date_bin('5 min'::interval, timestamptz '2020-02-01 01:01:01+00', timestamptz '2020-02-01 00:02:30+00');

-- test roundoff edge case when source < origin
SELECT date_bin('30 minutes'::interval, timestamptz '2024-02-01 15:00:00', timestamptz '2024-02-01 17:00:00');

-- disallow intervals with months or years
SELECT date_bin('5 months'::interval, timestamp with time zone '2020-02-01 01:01:01+00', timestamp with time zone '2001-01-01+00');
SELECT date_bin('5 years'::interval,  timestamp with time zone '2020-02-01 01:01:01+00', timestamp with time zone '2001-01-01+00');

-- disallow zero intervals
SELECT date_bin('0 days'::interval, timestamp with time zone '1970-01-01 01:00:00+00' , timestamp with time zone '1970-01-01 00:00:00+00');

-- disallow negative intervals
SELECT date_bin('-2 days'::interval, timestamp with time zone '1970-01-01 01:00:00+00' , timestamp with time zone '1970-01-01 00:00:00+00');

-- test overflow cases
select date_bin('15 minutes'::interval, timestamptz '294276-12-30', timestamptz '4000-12-20 BC');
select date_bin('200000000 days'::interval, '2024-02-01'::timestamptz, '2024-01-01'::timestamptz);
select date_bin('365000 days'::interval, '4400-01-01 BC'::timestamptz, '4000-01-01 BC'::timestamptz);

-- Test casting within a BETWEEN qualifier
SELECT d1 - timestamp with time zone '1997-01-02' AS diff
  FROM TIMESTAMPTZ_TBL
  WHERE d1 BETWEEN timestamp with time zone '1902-01-01' AND timestamp with time zone '2038-01-01';

-- DATE_PART (timestamptz_part)
SELECT d1 as timestamptz,
   date_part( 'year', d1) AS year, date_part( 'month', d1) AS month,
   date_part( 'day', d1) AS day, date_part( 'hour', d1) AS hour,
   date_part( 'minute', d1) AS minute, date_part( 'second', d1) AS second
   FROM TIMESTAMPTZ_TBL;

SELECT d1 as timestamptz,
   date_part( 'quarter', d1) AS quarter, date_part( 'msec', d1) AS msec,
   date_part( 'usec', d1) AS usec
   FROM TIMESTAMPTZ_TBL;

SELECT d1 as timestamptz,
   date_part( 'isoyear', d1) AS isoyear, date_part( 'week', d1) AS week,
   date_part( 'isodow', d1) AS isodow, date_part( 'dow', d1) AS dow,
   date_part( 'doy', d1) AS doy
   FROM TIMESTAMPTZ_TBL;

SELECT d1 as timestamptz,
   date_part( 'decade', d1) AS decade,
   date_part( 'century', d1) AS century,
   date_part( 'millennium', d1) AS millennium,
   round(date_part( 'julian', d1)) AS julian,
   date_part( 'epoch', d1) AS epoch
   FROM TIMESTAMPTZ_TBL;

SELECT d1 as timestamptz,
   date_part( 'timezone', d1) AS timezone,
   date_part( 'timezone_hour', d1) AS timezone_hour,
   date_part( 'timezone_minute', d1) AS timezone_minute
   FROM TIMESTAMPTZ_TBL;

-- extract implementation is mostly the same as date_part, so only
-- test a few cases for additional coverage.
SELECT d1 as "timestamp",
   extract(microseconds from d1) AS microseconds,
   extract(milliseconds from d1) AS milliseconds,
   extract(seconds from d1) AS seconds,
   round(extract(julian from d1)) AS julian,
   extract(epoch from d1) AS epoch
   FROM TIMESTAMPTZ_TBL;

-- value near upper bound uses special case in code
SELECT date_part('epoch', '294270-01-01 00:00:00+00'::timestamptz);
SELECT extract(epoch from '294270-01-01 00:00:00+00'::timestamptz);
-- another internal overflow test case
SELECT extract(epoch from '5000-01-01 00:00:00+00'::timestamptz);

-- test edge-case overflow in timestamp subtraction
SELECT timestamptz '294276-12-31 23:59:59 UTC' - timestamptz '1999-12-23 19:59:04.224193 UTC' AS ok;
SELECT timestamptz '294276-12-31 23:59:59 UTC' - timestamptz '1999-12-23 19:59:04.224192 UTC' AS overflows;

-- TO_CHAR()
SELECT to_char(d1, 'DAY Day day DY Dy dy MONTH Month month RM MON Mon mon')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d1, 'FMDAY FMDay FMday FMMONTH FMMonth FMmonth FMRM')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d1, 'Y,YYY YYYY YYY YY Y CC Q MM WW DDD DD D J')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d1, 'FMY,YYY FMYYYY FMYYY FMYY FMY FMCC FMQ FMMM FMWW FMDDD FMDD FMD FMJ')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d1, 'HH HH12 HH24 MI SS SSSS')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d1, E'"HH:MI:SS is" HH:MI:SS "\\"text between quote marks\\""')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d1, 'HH24--text--MI--text--SS/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d1, 'YYYYTH YYYYth Jth')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d1, 'YYYY A.D. YYYY a.d. YYYY bc HH:MI:SS P.M. HH:MI:SS p.m. HH:MI:SS pm')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d1, 'IYYY IYY IY I IW IDDD ID')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d1, 'FMIYYY FMIYY FMIY FMI FMIW FMIDDD FMID')
   FROM TIMESTAMPTZ_TBL;

SELECT to_char(d, 'FF1 FF2 FF3 FF4 FF5 FF6  ff1 ff2 ff3 ff4 ff5 ff6  MS US')
   FROM (VALUES
       ('2018-11-02 12:34:56'::timestamptz),
       ('2018-11-02 12:34:56.78'),
       ('2018-11-02 12:34:56.78901'),
       ('2018-11-02 12:34:56.78901234')
   ) d(d);

-- Check OF, TZH, TZM with various zone offsets, particularly fractional hours
SET timezone = '00:00';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '+02:00';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '-13:00';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '-00:30';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '00:30';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '-04:30';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '04:30';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '-04:15';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
SET timezone = '04:15';
SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM";
RESET timezone;

-- Check of, tzh, tzm with various zone offsets.
SET timezone = '00:00';
SELECT to_char(now(), 'of') as "Of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '+02:00';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '-13:00';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '-00:30';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '00:30';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '-04:30';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '04:30';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '-04:15';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
SET timezone = '04:15';
SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm";
RESET timezone;


CREATE TABLE TIMESTAMPTZ_TST (a int , b timestamptz);

-- Test year field value with len > 4
INSERT INTO TIMESTAMPTZ_TST VALUES(1, 'Sat Mar 12 23:58:48 1000 IST');
INSERT INTO TIMESTAMPTZ_TST VALUES(2, 'Sat Mar 12 23:58:48 10000 IST');
INSERT INTO TIMESTAMPTZ_TST VALUES(3, 'Sat Mar 12 23:58:48 100000 IST');
INSERT INTO TIMESTAMPTZ_TST VALUES(3, '10000 Mar 12 23:58:48 IST');
INSERT INTO TIMESTAMPTZ_TST VALUES(4, '100000312 23:58:48 IST');
INSERT INTO TIMESTAMPTZ_TST VALUES(4, '1000000312 23:58:48 IST');
--Verify data
SELECT * FROM TIMESTAMPTZ_TST ORDER BY a;
--Cleanup
DROP TABLE TIMESTAMPTZ_TST;

-- test timestamptz constructors
set TimeZone to 'America/New_York';

-- numeric timezone
SELECT make_timestamptz(1973, 07, 15, 08, 15, 55.33);
SELECT make_timestamptz(1973, 07, 15, 08, 15, 55.33, '+2');
SELECT make_timestamptz(1973, 07, 15, 08, 15, 55.33, '-2');
WITH tzs (tz) AS (VALUES
    ('+1'), ('+1:'), ('+1:0'), ('+100'), ('+1:00'), ('+01:00'),
    ('+10'), ('+1000'), ('+10:'), ('+10:0'), ('+10:00'), ('+10:00:'),
    ('+10:00:1'), ('+10:00:01'),
    ('+10:00:10'))
     SELECT make_timestamptz(2010, 2, 27, 3, 45, 00, tz), tz FROM tzs;

-- these should fail
SELECT make_timestamptz(1973, 07, 15, 08, 15, 55.33, '2');
SELECT make_timestamptz(2014, 12, 10, 10, 10, 10, '+16');
SELECT make_timestamptz(2014, 12, 10, 10, 10, 10, '-16');

-- should be true
SELECT make_timestamptz(1973, 07, 15, 08, 15, 55.33, '+2') = '1973-07-15 08:15:55.33+02'::timestamptz;

-- full timezone names
SELECT make_timestamptz(2014, 12, 10, 0, 0, 0, 'Europe/Prague') = timestamptz '2014-12-10 00:00:00 Europe/Prague';
SELECT make_timestamptz(2014, 12, 10, 0, 0, 0, 'Europe/Prague') AT TIME ZONE 'UTC';
SELECT make_timestamptz(1846, 12, 10, 0, 0, 0, 'Asia/Manila') AT TIME ZONE 'UTC';
SELECT make_timestamptz(1881, 12, 10, 0, 0, 0, 'Europe/Paris') AT TIME ZONE 'UTC';
SELECT make_timestamptz(1910, 12, 24, 0, 0, 0, 'Nehwon/Lankhmar');

-- abbreviations
SELECT make_timestamptz(2008, 12, 10, 10, 10, 10, 'EST');
SELECT make_timestamptz(2008, 12, 10, 10, 10, 10, 'EDT');
SELECT make_timestamptz(2014, 12, 10, 10, 10, 10, 'PST8PDT');

RESET TimeZone;

-- generate_series for timestamptz
select * from generate_series('2020-01-01 00:00'::timestamptz,
                              '2020-01-02 03:00'::timestamptz,
                              '1 hour'::interval);
-- the LIMIT should allow this to terminate in a reasonable amount of time
-- (but that unfortunately doesn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t work yet for SELECT * FROM ...)
select generate_series('2022-01-01 00:00'::timestamptz,
                       'infinity'::timestamptz,
                       '1 month'::interval) limit 10;
-- errors
select * from generate_series('2020-01-01 00:00'::timestamptz,
                              '2020-01-02 03:00'::timestamptz,
                              '0 hour'::interval);
select generate_series(timestamptz '1995-08-06 12:12:12', timestamptz '1996-08-06 12:12:12', interval 'infinity');
select generate_series(timestamptz '1995-08-06 12:12:12', timestamptz '1996-08-06 12:12:12', interval '-infinity');

-- Interval crossing time shift for Europe/Warsaw timezone (with DST)
SET TimeZone to 'UTC';

SELECT date_add('2022-10-30 00:00:00+01'::timestamptz,
                '1 day'::interval);
SELECT date_add('2021-10-31 00:00:00+02'::timestamptz,
                '1 day'::interval,
                'Europe/Warsaw');
SELECT date_subtract('2022-10-30 00:00:00+01'::timestamptz,
                     '1 day'::interval);
SELECT date_subtract('2021-10-31 00:00:00+02'::timestamptz,
                     '1 day'::interval,
                     'Europe/Warsaw');
SELECT * FROM generate_series('2021-12-31 23:00:00+00'::timestamptz,
                              '2020-12-31 23:00:00+00'::timestamptz,
                              '-1 month'::interval,
                              'Europe/Warsaw');
RESET TimeZone;

--
-- Test behavior with a dynamic (time-varying) timezone abbreviation.
-- These tests rely on the knowledge that MSK (Europe/Moscow standard time)
-- moved forwards in Mar 2011 and backwards again in Oct 2014.
--

SET TimeZone to 'UTC';

SELECT '2011-03-27 00:00:00 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 01:00:00 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 01:59:59 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 02:00:00 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 02:00:01 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 02:59:59 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 03:00:00 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 03:00:01 Europe/Moscow'::timestamptz;
SELECT '2011-03-27 04:00:00 Europe/Moscow'::timestamptz;

SELECT '2011-03-27 00:00:00 MSK'::timestamptz;
SELECT '2011-03-27 01:00:00 MSK'::timestamptz;
SELECT '2011-03-27 01:59:59 MSK'::timestamptz;
SELECT '2011-03-27 02:00:00 MSK'::timestamptz;
SELECT '2011-03-27 02:00:01 MSK'::timestamptz;
SELECT '2011-03-27 02:59:59 MSK'::timestamptz;
SELECT '2011-03-27 03:00:00 MSK'::timestamptz;
SELECT '2011-03-27 03:00:01 MSK'::timestamptz;
SELECT '2011-03-27 04:00:00 MSK'::timestamptz;

SELECT '2014-10-26 00:00:00 Europe/Moscow'::timestamptz;
SELECT '2014-10-26 00:59:59 Europe/Moscow'::timestamptz;
SELECT '2014-10-26 01:00:00 Europe/Moscow'::timestamptz;
SELECT '2014-10-26 01:00:01 Europe/Moscow'::timestamptz;
SELECT '2014-10-26 02:00:00 Europe/Moscow'::timestamptz;

SELECT '2014-10-26 00:00:00 MSK'::timestamptz;
SELECT '2014-10-26 00:59:59 MSK'::timestamptz;
SELECT '2014-10-26 01:00:00 MSK'::timestamptz;
SELECT '2014-10-26 01:00:01 MSK'::timestamptz;
SELECT '2014-10-26 02:00:00 MSK'::timestamptz;

SELECT '2011-03-27 00:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 01:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 01:59:59'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 02:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 02:00:01'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 02:59:59'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 03:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 03:00:01'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 04:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';

SELECT '2011-03-27 00:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 01:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 01:59:59'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 02:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 02:00:01'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 02:59:59'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 03:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 03:00:01'::timestamp AT TIME ZONE 'MSK';
SELECT '2011-03-27 04:00:00'::timestamp AT TIME ZONE 'MSK';

SELECT '2014-10-26 00:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-26 00:59:59'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-26 01:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-26 01:00:01'::timestamp AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-26 02:00:00'::timestamp AT TIME ZONE 'Europe/Moscow';

SELECT '2014-10-26 00:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2014-10-26 00:59:59'::timestamp AT TIME ZONE 'MSK';
SELECT '2014-10-26 01:00:00'::timestamp AT TIME ZONE 'MSK';
SELECT '2014-10-26 01:00:01'::timestamp AT TIME ZONE 'MSK';
SELECT '2014-10-26 02:00:00'::timestamp AT TIME ZONE 'MSK';

SELECT make_timestamptz(2014, 10, 26, 0, 0, 0, 'MSK');
SELECT make_timestamptz(2014, 10, 26, 1, 0, 0, 'MSK');

SELECT to_timestamp(         0);          -- 1970-01-01 00:00:00+00
SELECT to_timestamp( 946684800);          -- 2000-01-01 00:00:00+00
SELECT to_timestamp(1262349296.7890123);  -- 2010-01-01 12:34:56.789012+00
-- edge cases
SELECT to_timestamp(-210866803200);       --   4714-11-24 00:00:00+00 BC
-- upper limit varies between integer and float timestamps, so hard to test
-- nonfinite values
SELECT to_timestamp(' Infinity'::float);
SELECT to_timestamp('-Infinity'::float);
SELECT to_timestamp('NaN'::float);


SET TimeZone to 'Europe/Moscow';

SELECT '2011-03-26 21:00:00 UTC'::timestamptz;
SELECT '2011-03-26 22:00:00 UTC'::timestamptz;
SELECT '2011-03-26 22:59:59 UTC'::timestamptz;
SELECT '2011-03-26 23:00:00 UTC'::timestamptz;
SELECT '2011-03-26 23:00:01 UTC'::timestamptz;
SELECT '2011-03-26 23:59:59 UTC'::timestamptz;
SELECT '2011-03-27 00:00:00 UTC'::timestamptz;

SELECT '2014-10-25 21:00:00 UTC'::timestamptz;
SELECT '2014-10-25 21:59:59 UTC'::timestamptz;
SELECT '2014-10-25 22:00:00 UTC'::timestamptz;
SELECT '2014-10-25 22:00:01 UTC'::timestamptz;
SELECT '2014-10-25 23:00:00 UTC'::timestamptz;

RESET TimeZone;

SELECT '2011-03-26 21:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 22:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 22:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 23:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 23:00:01 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-26 23:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2011-03-27 00:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';

SELECT '2014-10-25 21:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-25 21:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-25 22:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-25 22:00:01 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';
SELECT '2014-10-25 23:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow';

SELECT '2011-03-26 21:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-26 22:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-26 22:59:59 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-26 23:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-26 23:00:01 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-26 23:59:59 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2011-03-27 00:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';

SELECT '2014-10-25 21:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2014-10-25 21:59:59 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2014-10-25 22:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2014-10-25 22:00:01 UTC'::timestamptz AT TIME ZONE 'MSK';
SELECT '2014-10-25 23:00:00 UTC'::timestamptz AT TIME ZONE 'MSK';

--
-- Test LOCAL time zone
--
BEGIN;
SET LOCAL TIME ZONE 'Europe/Paris';
VALUES (CAST('1978-07-07 19:38 America/New_York' AS TIMESTAMP WITH TIME ZONE) AT LOCAL);
VALUES (TIMESTAMP '1978-07-07 19:38' AT LOCAL);
SET LOCAL TIME ZONE 'Australia/Sydney';
VALUES (CAST('1978-07-07 19:38 America/New_York' AS TIMESTAMP WITH TIME ZONE) AT LOCAL);
VALUES (TIMESTAMP '1978-07-07 19:38' AT LOCAL);
SET LOCAL TimeZone TO 'UTC';
CREATE VIEW timestamp_local_view AS
  SELECT CAST('1978-07-07 19:38 America/New_York' AS TIMESTAMP WITH TIME ZONE) AT LOCAL AS ttz_at_local,
         timezone(CAST('1978-07-07 19:38 America/New_York' AS TIMESTAMP WITH TIME ZONE)) AS ttz_func,
         TIMESTAMP '1978-07-07 19:38' AT LOCAL AS t_at_local,
         timezone(TIMESTAMP '1978-07-07 19:38') AS t_func;
SELECT pg_get_viewdef('timestamp_local_view', true);
\x
TABLE timestamp_local_view;
\x
DROP VIEW timestamp_local_view;
COMMIT;

--
-- Test that AT TIME ZONE isn/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''t misoptimized when using an index (bug #14504)
--
create temp table tmptz (f1 timestamptz primary key);
insert into tmptz values ('2017-01-18 00:00+00');
explain (costs off)
select * from tmptz where f1 at time zone 'utc' = '2017-01-18 00:00';
select * from tmptz where f1 at time zone 'utc' = '2017-01-18 00:00';

-- test arithmetic with infinite timestamps
SELECT timestamptz 'infinity' - timestamptz 'infinity';
SELECT timestamptz 'infinity' - timestamptz '-infinity';
SELECT timestamptz '-infinity' - timestamptz 'infinity';
SELECT timestamptz '-infinity' - timestamptz '-infinity';
SELECT timestamptz 'infinity' - timestamptz '1995-08-06 12:12:12';
SELECT timestamptz '-infinity' - timestamptz '1995-08-06 12:12:12';

-- test age() with infinite timestamps
SELECT age(timestamptz 'infinity');
SELECT age(timestamptz '-infinity');
SELECT age(timestamptz 'infinity', timestamptz 'infinity');
SELECT age(timestamptz 'infinity', timestamptz '-infinity');
SELECT age(timestamptz '-infinity', timestamptz 'infinity');
SELECT age(timestamptz '-infinity', timestamptz '-infinity');
-- END setup from timestamptz 
SELECT pg_catalog.set_config('search_path', 'public', false);
-- START setup from interval 
--
-- INTERVAL
--

SET DATESTYLE = 'ISO';
SET IntervalStyle to postgres;

-- check acceptance of /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''time zone style/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
SELECT INTERVAL '01:00' AS "One hour";
SELECT INTERVAL '+02:00' AS "Two hours";
SELECT INTERVAL '-08:00' AS "Eight hours";
SELECT INTERVAL '-1 +02:03' AS "22 hours ago...";
SELECT INTERVAL '-1 days +02:03' AS "22 hours ago...";
SELECT INTERVAL '1.5 weeks' AS "Ten days twelve hours";
SELECT INTERVAL '1.5 months' AS "One month 15 days";
SELECT INTERVAL '10 years -11 month -12 days +13:14' AS "9 years...";
SELECT INTERVAL 'infinity' AS "eternity";
SELECT INTERVAL '-infinity' AS "beginning of time";

CREATE TABLE INTERVAL_TBL (f1 interval);

INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 1 minute');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 5 hour');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 10 day');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 34 year');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 3 months');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 14 seconds ago');
INSERT INTO INTERVAL_TBL (f1) VALUES ('1 day 2 hours 3 minutes 4 seconds');
INSERT INTO INTERVAL_TBL (f1) VALUES ('6 years');
INSERT INTO INTERVAL_TBL (f1) VALUES ('5 months');
INSERT INTO INTERVAL_TBL (f1) VALUES ('5 months 12 hours');
INSERT INTO INTERVAL_TBL (f1) VALUES ('infinity');
INSERT INTO INTERVAL_TBL (f1) VALUES ('-infinity');

-- badly formatted interval
INSERT INTO INTERVAL_TBL (f1) VALUES ('badly formatted interval');
INSERT INTO INTERVAL_TBL (f1) VALUES ('@ 30 eons ago');

-- Test non-error-throwing API
SELECT pg_input_is_valid('1.5 weeks', 'interval');
SELECT pg_input_is_valid('garbage', 'interval');
SELECT pg_input_is_valid('@ 30 eons ago', 'interval');
SELECT * FROM pg_input_error_info('garbage', 'interval');
SELECT * FROM pg_input_error_info('@ 30 eons ago', 'interval');

-- test interval operators

SELECT * FROM INTERVAL_TBL;

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 <> interval '@ 10 days';

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 <= interval '@ 5 hours';

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 < interval '@ 1 day';

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 = interval '@ 34 years';

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 >= interval '@ 1 month';

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 > interval '@ 3 seconds ago';

SELECT r1.*, r2.*
   FROM INTERVAL_TBL r1, INTERVAL_TBL r2
   WHERE r1.f1 > r2.f1
   ORDER BY r1.f1, r2.f1;

-- test unary minus

SELECT f1, -f1 FROM INTERVAL_TBL;
SELECT -('-2147483648 months'::interval); -- should fail
SELECT -('-2147483647 months'::interval); -- ok
SELECT -('-2147483648 days'::interval); -- should fail
SELECT -('-2147483647 days'::interval); -- ok
SELECT -('-9223372036854775808 us'::interval); -- should fail
SELECT -('-9223372036854775807 us'::interval); -- ok
SELECT -('-2147483647 months -2147483647 days -9223372036854775807 us'::interval); -- should fail

-- Test intervals that are large enough to overflow 64 bits in comparisons
CREATE TEMP TABLE INTERVAL_TBL_OF (f1 interval);
INSERT INTO INTERVAL_TBL_OF (f1) VALUES
  ('2147483647 days 2147483647 months'),
  ('2147483647 days -2147483648 months'),
  ('1 year'),
  ('-2147483648 days 2147483647 months'),
  ('-2147483648 days -2147483648 months');
-- these should fail as out-of-range
INSERT INTO INTERVAL_TBL_OF (f1) VALUES ('2147483648 days');
INSERT INTO INTERVAL_TBL_OF (f1) VALUES ('-2147483649 days');
INSERT INTO INTERVAL_TBL_OF (f1) VALUES ('2147483647 years');
INSERT INTO INTERVAL_TBL_OF (f1) VALUES ('-2147483648 years');

-- Test edge-case overflow detection in interval multiplication
select extract(epoch from '256 microseconds'::interval * (2^55)::float8);

SELECT r1.*, r2.*
   FROM INTERVAL_TBL_OF r1, INTERVAL_TBL_OF r2
   WHERE r1.f1 > r2.f1
   ORDER BY r1.f1, r2.f1;

CREATE INDEX ON INTERVAL_TBL_OF USING btree (f1);
SET enable_seqscan TO false;
EXPLAIN (COSTS OFF)
SELECT f1 FROM INTERVAL_TBL_OF r1 ORDER BY f1;
SELECT f1 FROM INTERVAL_TBL_OF r1 ORDER BY f1;
RESET enable_seqscan;

-- subtracting about-to-overflow values should result in 0
SELECT f1 - f1 FROM INTERVAL_TBL_OF;

DROP TABLE INTERVAL_TBL_OF;

-- Test multiplication and division with intervals.
-- Floating point arithmetic rounding errors can lead to unexpected results,
-- though the code attempts to do the right thing and round up to days and
-- minutes to avoid results such as /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''3 days 24:00 hours/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' or /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''14:20:60/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''.
-- Note that it is expected for some day components to be greater than 29 and
-- some time components be greater than 23:59:59 due to how intervals are
-- stored internally.

CREATE TABLE INTERVAL_MULDIV_TBL (span interval);
COPY INTERVAL_MULDIV_TBL FROM STDIN;
41 mon 12 days 360:00
-41 mon -12 days +360:00
-12 days
9 mon -27 days 12:34:56
-3 years 482 days 76:54:32.189
4 mon
14 mon
999 mon 999 days
\.

SELECT span * 0.3 AS product
FROM INTERVAL_MULDIV_TBL;

SELECT span * 8.2 AS product
FROM INTERVAL_MULDIV_TBL;

SELECT span / 10 AS quotient
FROM INTERVAL_MULDIV_TBL;

SELECT span / 100 AS quotient
FROM INTERVAL_MULDIV_TBL;

DROP TABLE INTERVAL_MULDIV_TBL;

SET DATESTYLE = 'postgres';
SET IntervalStyle to postgres_verbose;

SELECT * FROM INTERVAL_TBL;

-- multiplication and division overflow test cases
SELECT '3000000 months'::interval * 1000;
SELECT '3000000 months'::interval / 0.001;
SELECT '3000000 days'::interval * 1000;
SELECT '3000000 days'::interval / 0.001;
SELECT '1 month 2146410 days'::interval * 1000.5002;
SELECT '4611686018427387904 usec'::interval / 0.1;

-- test avg(interval), which is somewhat fragile since people have been
-- known to change the allowed input syntax for type interval without
-- updating pg_aggregate.agginitval

select avg(f1) from interval_tbl where isfinite(f1);

-- test long interval input
select '4 millenniums 5 centuries 4 decades 1 year 4 months 4 days 17 minutes 31 seconds'::interval;

-- test long interval output
-- Note: the actual maximum length of the interval output is longer,
-- but we need the test to work for both integer and floating-point
-- timestamps.
select '100000000y 10mon -1000000000d -100000h -10min -10.000001s ago'::interval;

-- test justify_hours() and justify_days()

SELECT justify_hours(interval '6 months 3 days 52 hours 3 minutes 2 seconds') as "6 mons 5 days 4 hours 3 mins 2 seconds";
SELECT justify_days(interval '6 months 36 days 5 hours 4 minutes 3 seconds') as "7 mons 6 days 5 hours 4 mins 3 seconds";

SELECT justify_hours(interval '2147483647 days 24 hrs');
SELECT justify_days(interval '2147483647 months 30 days');

-- test justify_interval()

SELECT justify_interval(interval '1 month -1 hour') as "1 month -1 hour";

SELECT justify_interval(interval '2147483647 days 24 hrs');
SELECT justify_interval(interval '-2147483648 days -24 hrs');
SELECT justify_interval(interval '2147483647 months 30 days');
SELECT justify_interval(interval '-2147483648 months -30 days');
SELECT justify_interval(interval '2147483647 months 30 days -24 hrs');
SELECT justify_interval(interval '-2147483648 months -30 days 24 hrs');
SELECT justify_interval(interval '2147483647 months -30 days 1440 hrs');
SELECT justify_interval(interval '-2147483648 months 30 days -1440 hrs');

-- test fractional second input, and detection of duplicate units
SET DATESTYLE = 'ISO';
SET IntervalStyle TO postgres;

SELECT '1 millisecond'::interval, '1 microsecond'::interval,
       '500 seconds 99 milliseconds 51 microseconds'::interval;
SELECT '3 days 5 milliseconds'::interval;

SELECT '1 second 2 seconds'::interval;              -- error
SELECT '10 milliseconds 20 milliseconds'::interval; -- error
SELECT '5.5 seconds 3 milliseconds'::interval;      -- error
SELECT '1:20:05 5 microseconds'::interval;          -- error
SELECT '1 day 1 day'::interval;                     -- error
SELECT interval '1-2';  -- SQL year-month literal
SELECT interval '999' second;  -- oversize leading field is ok
SELECT interval '999' minute;
SELECT interval '999' hour;
SELECT interval '999' day;
SELECT interval '999' month;

-- test SQL-spec syntaxes for restricted field sets
SELECT interval '1' year;
SELECT interval '2' month;
SELECT interval '3' day;
SELECT interval '4' hour;
SELECT interval '5' minute;
SELECT interval '6' second;
SELECT interval '1' year to month;
SELECT interval '1-2' year to month;
SELECT interval '1 2' day to hour;
SELECT interval '1 2:03' day to hour;
SELECT interval '1 2:03:04' day to hour;
SELECT interval '1 2' day to minute;
SELECT interval '1 2:03' day to minute;
SELECT interval '1 2:03:04' day to minute;
SELECT interval '1 2' day to second;
SELECT interval '1 2:03' day to second;
SELECT interval '1 2:03:04' day to second;
SELECT interval '1 2' hour to minute;
SELECT interval '1 2:03' hour to minute;
SELECT interval '1 2:03:04' hour to minute;
SELECT interval '1 2' hour to second;
SELECT interval '1 2:03' hour to second;
SELECT interval '1 2:03:04' hour to second;
SELECT interval '1 2' minute to second;
SELECT interval '1 2:03' minute to second;
SELECT interval '1 2:03:04' minute to second;
SELECT interval '1 +2:03' minute to second;
SELECT interval '1 +2:03:04' minute to second;
SELECT interval '1 -2:03' minute to second;
SELECT interval '1 -2:03:04' minute to second;
SELECT interval '123 11' day to hour; -- ok
SELECT interval '123 11' day; -- not ok
SELECT interval '123 11'; -- not ok, too ambiguous
SELECT interval '123 2:03 -2:04'; -- not ok, redundant hh:mm fields

-- test syntaxes for restricted precision
SELECT interval(0) '1 day 01:23:45.6789';
SELECT interval(2) '1 day 01:23:45.6789';
SELECT interval '12:34.5678' minute to second(2);  -- per SQL spec
SELECT interval '1.234' second;
SELECT interval '1.234' second(2);
SELECT interval '1 2.345' day to second(2);
SELECT interval '1 2:03' day to second(2);
SELECT interval '1 2:03.4567' day to second(2);
SELECT interval '1 2:03:04.5678' day to second(2);
SELECT interval '1 2.345' hour to second(2);
SELECT interval '1 2:03.45678' hour to second(2);
SELECT interval '1 2:03:04.5678' hour to second(2);
SELECT interval '1 2.3456' minute to second(2);
SELECT interval '1 2:03.5678' minute to second(2);
SELECT interval '1 2:03:04.5678' minute to second(2);
SELECT interval '2562047788:00:54.775807' second(2);  -- out of range
SELECT interval '-2562047788:00:54.775807' second(2);  -- out of range

-- test casting to restricted precision (bug #14479)
SELECT f1, f1::INTERVAL DAY TO MINUTE AS "minutes",
  (f1 + INTERVAL '1 month')::INTERVAL MONTH::INTERVAL YEAR AS "years"
  FROM interval_tbl;

-- test inputting and outputting SQL standard interval literals
SET IntervalStyle TO sql_standard;
SELECT  interval '0'                       AS "zero",
        interval '1-2' year to month       AS "year-month",
        interval '1 2:03:04' day to second AS "day-time",
        - interval '1-2'                   AS "negative year-month",
        - interval '1 2:03:04'             AS "negative day-time";

-- test input of some not-quite-standard interval values in the sql style
SET IntervalStyle TO postgres;
SELECT  interval '+1 -1:00:00',
        interval '-1 +1:00:00',
        interval '+1-2 -3 +4:05:06.789',
        interval '-1-2 +3 -4:05:06.789';

-- cases that trigger sign-matching rules in the sql style
SELECT  interval '-23 hours 45 min 12.34 sec',
        interval '-1 day 23 hours 45 min 12.34 sec',
        interval '-1 year 2 months 1 day 23 hours 45 min 12.34 sec',
        interval '-1 year 2 months 1 day 23 hours 45 min +12.34 sec';

-- test output of couple non-standard interval values in the sql style
SET IntervalStyle TO sql_standard;
SELECT  interval '1 day -1 hours',
        interval '-1 days +1 hours',
        interval '1 years 2 months -3 days 4 hours 5 minutes 6.789 seconds',
        - interval '1 years 2 months -3 days 4 hours 5 minutes 6.789 seconds';

-- cases that trigger sign-matching rules in the sql style
SELECT  interval '-23 hours 45 min 12.34 sec',
        interval '-1 day 23 hours 45 min 12.34 sec',
        interval '-1 year 2 months 1 day 23 hours 45 min 12.34 sec',
        interval '-1 year 2 months 1 day 23 hours 45 min +12.34 sec';

-- edge case for sign-matching rules
SELECT  interval '';  -- error

-- test outputting iso8601 intervals
SET IntervalStyle to iso_8601;
select  interval '0'                                AS "zero",
        interval '1-2'                              AS "a year 2 months",
        interval '1 2:03:04'                        AS "a bit over a day",
        interval '2:03:04.45679'                    AS "a bit over 2 hours",
        (interval '1-2' + interval '3 4:05:06.7')   AS "all fields",
        (interval '1-2' - interval '3 4:05:06.7')   AS "mixed sign",
        (- interval '1-2' + interval '3 4:05:06.7') AS "negative";

-- test inputting ISO 8601 4.4.2.1 /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''Format With Time Unit Designators/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
SET IntervalStyle to sql_standard;
select  interval 'P0Y'                    AS "zero",
        interval 'P1Y2M'                  AS "a year 2 months",
        interval 'P1W'                    AS "a week",
        interval 'P1DT2H3M4S'             AS "a bit over a day",
        interval 'P1Y2M3DT4H5M6.7S'       AS "all fields",
        interval 'P-1Y-2M-3DT-4H-5M-6.7S' AS "negative",
        interval 'PT-0.1S'                AS "fractional second";

-- test inputting ISO 8601 4.4.2.2 /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''Alternative Format/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''
SET IntervalStyle to postgres;
select  interval 'P00021015T103020'       AS "ISO8601 Basic Format",
        interval 'P0002-10-15T10:30:20'   AS "ISO8601 Extended Format";

-- Make sure optional ISO8601 alternative format fields are optional.
select  interval 'P0002'                  AS "year only",
        interval 'P0002-10'               AS "year month",
        interval 'P0002-10-15'            AS "year month day",
        interval 'P0002T1S'               AS "year only plus time",
        interval 'P0002-10T1S'            AS "year month plus time",
        interval 'P0002-10-15T1S'         AS "year month day plus time",
        interval 'PT10'                   AS "hour only",
        interval 'PT10:30'                AS "hour minute";

-- Check handling of fractional fields in ISO8601 format.
select interval 'P1Y0M3DT4H5M6S';
select interval 'P1.0Y0M3DT4H5M6S';
select interval 'P1.1Y0M3DT4H5M6S';
select interval 'P1.Y0M3DT4H5M6S';
select interval 'P.1Y0M3DT4H5M6S';
select interval 'P10.5e4Y';  -- not per spec, but we/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''ve historically taken it
select interval 'P.Y0M3DT4H5M6S';  -- error

-- test a couple rounding cases that changed since 8.3 w/ HAVE_INT64_TIMESTAMP.
SET IntervalStyle to postgres_verbose;
select interval '-10 mons -3 days +03:55:06.70';
select interval '1 year 2 mons 3 days 04:05:06.699999';
select interval '0:0:0.7', interval '@ 0.70 secs', interval '0.7 seconds';

-- test time fields using entire 64 bit microseconds range
select interval '2562047788.01521550194 hours';
select interval '-2562047788.01521550222 hours';
select interval '153722867280.912930117 minutes';
select interval '-153722867280.912930133 minutes';
select interval '9223372036854.775807 seconds';
select interval '-9223372036854.775808 seconds';
select interval '9223372036854775.807 milliseconds';
select interval '-9223372036854775.808 milliseconds';
select interval '9223372036854775807 microseconds';
select interval '-9223372036854775808 microseconds';

select interval 'PT2562047788H54.775807S';
select interval 'PT-2562047788H-54.775808S';

select interval 'PT2562047788:00:54.775807';

select interval 'PT2562047788.0152155019444';
select interval 'PT-2562047788.0152155022222';

-- overflow each date/time field
select interval '2147483648 years';
select interval '-2147483649 years';
select interval '2147483648 months';
select interval '-2147483649 months';
select interval '2147483648 days';
select interval '-2147483649 days';
select interval '2562047789 hours';
select interval '-2562047789 hours';
select interval '153722867281 minutes';
select interval '-153722867281 minutes';
select interval '9223372036855 seconds';
select interval '-9223372036855 seconds';
select interval '9223372036854777 millisecond';
select interval '-9223372036854777 millisecond';
select interval '9223372036854775808 microsecond';
select interval '-9223372036854775809 microsecond';

select interval 'P2147483648';
select interval 'P-2147483649';
select interval 'P1-2147483647-2147483647';
select interval 'PT2562047789';
select interval 'PT-2562047789';

-- overflow with date/time unit aliases
select interval '2147483647 weeks';
select interval '-2147483648 weeks';
select interval '2147483647 decades';
select interval '-2147483648 decades';
select interval '2147483647 centuries';
select interval '-2147483648 centuries';
select interval '2147483647 millennium';
select interval '-2147483648 millennium';

select interval '1 week 2147483647 days';
select interval '-1 week -2147483648 days';
select interval '2147483647 days 1 week';
select interval '-2147483648 days -1 week';

select interval 'P1W2147483647D';
select interval 'P-1W-2147483648D';
select interval 'P2147483647D1W';
select interval 'P-2147483648D-1W';

select interval '1 decade 2147483647 years';
select interval '1 century 2147483647 years';
select interval '1 millennium 2147483647 years';
select interval '-1 decade -2147483648 years';
select interval '-1 century -2147483648 years';
select interval '-1 millennium -2147483648 years';

select interval '2147483647 years 1 decade';
select interval '2147483647 years 1 century';
select interval '2147483647 years 1 millennium';
select interval '-2147483648 years -1 decade';
select interval '-2147483648 years -1 century';
select interval '-2147483648 years -1 millennium';

-- overflowing with fractional fields - postgres format
select interval '0.1 millennium 2147483647 months';
select interval '0.1 centuries 2147483647 months';
select interval '0.1 decades 2147483647 months';
select interval '0.1 yrs 2147483647 months';
select interval '-0.1 millennium -2147483648 months';
select interval '-0.1 centuries -2147483648 months';
select interval '-0.1 decades -2147483648 months';
select interval '-0.1 yrs -2147483648 months';

select interval '2147483647 months 0.1 millennium';
select interval '2147483647 months 0.1 centuries';
select interval '2147483647 months 0.1 decades';
select interval '2147483647 months 0.1 yrs';
select interval '-2147483648 months -0.1 millennium';
select interval '-2147483648 months -0.1 centuries';
select interval '-2147483648 months -0.1 decades';
select interval '-2147483648 months -0.1 yrs';

select interval '0.1 months 2147483647 days';
select interval '-0.1 months -2147483648 days';
select interval '2147483647 days 0.1 months';
select interval '-2147483648 days -0.1 months';

select interval '0.5 weeks 2147483647 days';
select interval '-0.5 weeks -2147483648 days';
select interval '2147483647 days 0.5 weeks';
select interval '-2147483648 days -0.5 weeks';

select interval '0.01 months 9223372036854775807 microseconds';
select interval '-0.01 months -9223372036854775808 microseconds';
select interval '9223372036854775807 microseconds 0.01 months';
select interval '-9223372036854775808 microseconds -0.01 months';

select interval '0.1 weeks 9223372036854775807 microseconds';
select interval '-0.1 weeks -9223372036854775808 microseconds';
select interval '9223372036854775807 microseconds 0.1 weeks';
select interval '-9223372036854775808 microseconds -0.1 weeks';

select interval '0.1 days 9223372036854775807 microseconds';
select interval '-0.1 days -9223372036854775808 microseconds';
select interval '9223372036854775807 microseconds 0.1 days';
select interval '-9223372036854775808 microseconds -0.1 days';

-- overflowing with fractional fields - ISO8601 format
select interval 'P0.1Y2147483647M';
select interval 'P-0.1Y-2147483648M';
select interval 'P2147483647M0.1Y';
select interval 'P-2147483648M-0.1Y';

select interval 'P0.1M2147483647D';
select interval 'P-0.1M-2147483648D';
select interval 'P2147483647D0.1M';
select interval 'P-2147483648D-0.1M';

select interval 'P0.5W2147483647D';
select interval 'P-0.5W-2147483648D';
select interval 'P2147483647D0.5W';
select interval 'P-2147483648D-0.5W';

select interval 'P0.01MT2562047788H54.775807S';
select interval 'P-0.01MT-2562047788H-54.775808S';

select interval 'P0.1DT2562047788H54.775807S';
select interval 'P-0.1DT-2562047788H-54.775808S';

select interval 'PT2562047788.1H54.775807S';
select interval 'PT-2562047788.1H-54.775808S';

select interval 'PT2562047788H0.1M54.775807S';
select interval 'PT-2562047788H-0.1M-54.775808S';

-- overflowing with fractional fields - ISO8601 alternative format
select interval 'P0.1-2147483647-00';
select interval 'P00-0.1-2147483647';
select interval 'P00-0.01-00T2562047788:00:54.775807';
select interval 'P00-00-0.1T2562047788:00:54.775807';
select interval 'PT2562047788.1:00:54.775807';
select interval 'PT2562047788:01.:54.775807';

-- overflowing with fractional fields - SQL standard format
select interval '0.1 2562047788:0:54.775807';
select interval '0.1 2562047788:0:54.775808 ago';

select interval '2562047788.1:0:54.775807';
select interval '2562047788.1:0:54.775808 ago';

select interval '2562047788:0.1:54.775807';
select interval '2562047788:0.1:54.775808 ago';

-- overflowing using AGO with INT_MIN
select interval '-2147483648 months ago';
select interval '-2147483648 days ago';
select interval '-9223372036854775808 microseconds ago';
select interval '-2147483648 months -2147483648 days -9223372036854775808 microseconds ago';

-- overflowing using make_interval
select make_interval(years := 178956971);
select make_interval(years := -178956971);
select make_interval(years := 1, months := 2147483647);
select make_interval(years := -1, months := -2147483648);
select make_interval(weeks := 306783379);
select make_interval(weeks := -306783379);
select make_interval(weeks := 1, days := 2147483647);
select make_interval(weeks := -1, days := -2147483648);
select make_interval(secs := 1e308);
select make_interval(secs := 1e18);
select make_interval(secs := -1e18);
select make_interval(mins := 1, secs := 9223372036800.0);
select make_interval(mins := -1, secs := -9223372036800.0);

-- test that INT_MIN number is formatted properly
SET IntervalStyle to postgres;
select interval '-2147483647 months -2147483648 days -9223372036854775808 us';
SET IntervalStyle to sql_standard;
select interval '-2147483647 months -2147483648 days -9223372036854775808 us';
SET IntervalStyle to iso_8601;
select interval '-2147483647 months -2147483648 days -9223372036854775808 us';
SET IntervalStyle to postgres_verbose;
select interval '-2147483647 months -2147483648 days -9223372036854775808 us';

-- check that /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''30 days/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' equals /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''1 month/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' according to the hash function
select '30 days'::interval = '1 month'::interval as t;
select interval_hash('30 days'::interval) = interval_hash('1 month'::interval) as t;

-- numeric constructor
select make_interval(years := 2);
select make_interval(years := 1, months := 6);
select make_interval(years := 1, months := -1, weeks := 5, days := -7, hours := 25, mins := -180);

select make_interval() = make_interval(years := 0, months := 0, weeks := 0, days := 0, mins := 0, secs := 0.0);
select make_interval(hours := -2, mins := -10, secs := -25.3);

select make_interval(years := 'inf'::float::int);
select make_interval(months := 'NaN'::float::int);
select make_interval(secs := 'inf');
select make_interval(secs := 'NaN');
select make_interval(secs := 7e12);

--
-- test EXTRACT
--
SELECT f1,
    EXTRACT(MICROSECOND FROM f1) AS MICROSECOND,
    EXTRACT(MILLISECOND FROM f1) AS MILLISECOND,
    EXTRACT(SECOND FROM f1) AS SECOND,
    EXTRACT(MINUTE FROM f1) AS MINUTE,
    EXTRACT(HOUR FROM f1) AS HOUR,
    EXTRACT(DAY FROM f1) AS DAY,
    EXTRACT(MONTH FROM f1) AS MONTH,
    EXTRACT(QUARTER FROM f1) AS QUARTER,
    EXTRACT(YEAR FROM f1) AS YEAR,
    EXTRACT(DECADE FROM f1) AS DECADE,
    EXTRACT(CENTURY FROM f1) AS CENTURY,
    EXTRACT(MILLENNIUM FROM f1) AS MILLENNIUM,
    EXTRACT(EPOCH FROM f1) AS EPOCH
    FROM INTERVAL_TBL;

SELECT EXTRACT(FORTNIGHT FROM INTERVAL '2 days');  -- error
SELECT EXTRACT(TIMEZONE FROM INTERVAL '2 days');  -- error

SELECT EXTRACT(DECADE FROM INTERVAL '100 y');
SELECT EXTRACT(DECADE FROM INTERVAL '99 y');
SELECT EXTRACT(DECADE FROM INTERVAL '-99 y');
SELECT EXTRACT(DECADE FROM INTERVAL '-100 y');

SELECT EXTRACT(CENTURY FROM INTERVAL '100 y');
SELECT EXTRACT(CENTURY FROM INTERVAL '99 y');
SELECT EXTRACT(CENTURY FROM INTERVAL '-99 y');
SELECT EXTRACT(CENTURY FROM INTERVAL '-100 y');

-- date_part implementation is mostly the same as extract, so only
-- test a few cases for additional coverage.
SELECT f1,
    date_part('microsecond', f1) AS microsecond,
    date_part('millisecond', f1) AS millisecond,
    date_part('second', f1) AS second,
    date_part('epoch', f1) AS epoch
    FROM INTERVAL_TBL;

-- internal overflow test case
SELECT extract(epoch from interval '1000000000 days');

--
-- test infinite intervals
--

-- largest finite intervals
SELECT interval '-2147483648 months -2147483648 days -9223372036854775807 us';
SELECT interval '2147483647 months 2147483647 days 9223372036854775806 us';

-- infinite intervals
SELECT interval '-2147483648 months -2147483648 days -9223372036854775808 us';
SELECT interval '2147483647 months 2147483647 days 9223372036854775807 us';

CREATE TABLE INFINITE_INTERVAL_TBL (i interval);
INSERT INTO INFINITE_INTERVAL_TBL VALUES ('infinity'), ('-infinity'), ('1 year 2 days 3 hours');

SELECT i, isfinite(i) FROM INFINITE_INTERVAL_TBL;

-- test basic arithmetic
CREATE FUNCTION eval(expr text)
RETURNS text AS
$$
DECLARE
  result text;
BEGIN
  EXECUTE 'select '||expr INTO result;
  RETURN result;
EXCEPTION WHEN OTHERS THEN
  RETURN SQLERRM;
END
$$
LANGUAGE plpgsql;

SELECT d AS date, i AS interval,
       eval(format('date %L + interval %L', d, i)) AS plus,
       eval(format('date %L - interval %L', d, i)) AS minus
FROM (VALUES (date '-infinity'),
             (date '1995-08-06'),
             (date 'infinity')) AS t1(d),
     (VALUES (interval '-infinity'),
             (interval 'infinity')) AS t2(i);

SELECT i1 AS interval1, i2 AS interval2,
       eval(format('interval %L + interval %L', i1, i2)) AS plus,
       eval(format('interval %L - interval %L', i1, i2)) AS minus
FROM (VALUES (interval '-infinity'),
             (interval '2 months'),
             (interval 'infinity')) AS t1(i1),
     (VALUES (interval '-infinity'),
             (interval '10 days'),
             (interval 'infinity')) AS t2(i2);

SELECT interval '2147483646 months 2147483646 days 9223372036854775806 us' + interval '1 month 1 day 1 us';
SELECT interval '-2147483647 months -2147483647 days -9223372036854775807 us' + interval '-1 month -1 day -1 us';
SELECT interval '2147483646 months 2147483646 days 9223372036854775806 us' - interval '-1 month -1 day -1 us';
SELECT interval '-2147483647 months -2147483647 days -9223372036854775807 us' - interval '1 month 1 day 1 us';

SELECT t AS timestamp, i AS interval,
       eval(format('timestamp %L + interval %L', t, i)) AS plus,
       eval(format('timestamp %L - interval %L', t, i)) AS minus
FROM (VALUES (timestamp '-infinity'),
             (timestamp '1995-08-06 12:30:15'),
             (timestamp 'infinity')) AS t1(t),
     (VALUES (interval '-infinity'),
             (interval 'infinity')) AS t2(i);

SELECT t AT TIME ZONE 'GMT' AS timestamptz, i AS interval,
       eval(format('timestamptz %L + interval %L', t, i)) AS plus,
       eval(format('timestamptz %L - interval %L', t, i)) AS minus
FROM (VALUES (timestamptz '-infinity'),
             (timestamptz '1995-08-06 12:30:15 GMT'),
             (timestamptz 'infinity')) AS t1(t),
     (VALUES (interval '-infinity'),
             (interval 'infinity')) AS t2(i);

-- time +/- infinite interval not supported
SELECT time '11:27:42' + interval 'infinity';
SELECT time '11:27:42' + interval '-infinity';
SELECT time '11:27:42' - interval 'infinity';
SELECT time '11:27:42' - interval '-infinity';
SELECT timetz '11:27:42' + interval 'infinity';
SELECT timetz '11:27:42' + interval '-infinity';
SELECT timetz '11:27:42' - interval 'infinity';
SELECT timetz '11:27:42' - interval '-infinity';

SELECT lhst.i lhs,
    rhst.i rhs,
    lhst.i < rhst.i AS lt,
    lhst.i <= rhst.i AS le,
    lhst.i = rhst.i AS eq,
    lhst.i > rhst.i AS gt,
    lhst.i >= rhst.i AS ge,
    lhst.i <> rhst.i AS ne
    FROM INFINITE_INTERVAL_TBL lhst CROSS JOIN INFINITE_INTERVAL_TBL rhst
    WHERE NOT isfinite(lhst.i);

SELECT i AS interval,
    -i AS um,
    i * 2.0 AS mul,
    i * -2.0 AS mul_neg,
    i * 'infinity' AS mul_inf,
    i * '-infinity' AS mul_inf_neg,
    i / 3.0 AS div,
    i / -3.0 AS div_neg
    FROM INFINITE_INTERVAL_TBL
    WHERE NOT isfinite(i);

SELECT -interval '-2147483647 months -2147483647 days -9223372036854775807 us';
SELECT interval 'infinity' * 'nan';
SELECT interval '-infinity' * 'nan';
SELECT interval '-1073741824 months -1073741824 days -4611686018427387904 us' * 2;
SELECT interval 'infinity' * 0;
SELECT interval '-infinity' * 0;
SELECT interval '0 days' * 'infinity'::float;
SELECT interval '0 days' * '-infinity'::float;
SELECT interval '5 days' * 'infinity'::float;
SELECT interval '5 days' * '-infinity'::float;

SELECT interval 'infinity' / 'infinity';
SELECT interval 'infinity' / '-infinity';
SELECT interval 'infinity' / 'nan';
SELECT interval '-infinity' / 'infinity';
SELECT interval '-infinity' / '-infinity';
SELECT interval '-infinity' / 'nan';
SELECT interval '-1073741824 months -1073741824 days -4611686018427387904 us' / 0.5;

SELECT date_bin('infinity', timestamp '2001-02-16 20:38:40', timestamp '2001-02-16 20:05:00');
SELECT date_bin('-infinity', timestamp '2001-02-16 20:38:40', timestamp '2001-02-16 20:05:00');

SELECT i AS interval, date_trunc('hour', i)
    FROM INFINITE_INTERVAL_TBL
    WHERE NOT isfinite(i);

SELECT i AS interval, justify_days(i), justify_hours(i), justify_interval(i)
    FROM INFINITE_INTERVAL_TBL
    WHERE NOT isfinite(i);

SELECT timezone('infinity'::interval, '1995-08-06 12:12:12'::timestamp);
SELECT timezone('-infinity'::interval, '1995-08-06 12:12:12'::timestamp);
SELECT timezone('infinity'::interval, '1995-08-06 12:12:12'::timestamptz);
SELECT timezone('-infinity'::interval, '1995-08-06 12:12:12'::timestamptz);
SELECT timezone('infinity'::interval, '12:12:12'::time);
SELECT timezone('-infinity'::interval, '12:12:12'::time);
SELECT timezone('infinity'::interval, '12:12:12'::timetz);
SELECT timezone('-infinity'::interval, '12:12:12'::timetz);

SELECT 'infinity'::interval::time;
SELECT '-infinity'::interval::time;

SELECT to_char('infinity'::interval, 'YYYY');
SELECT to_char('-infinity'::interval, 'YYYY');

-- /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''ago/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' can only appear once at the end of an interval.
SELECT INTERVAL '42 days 2 seconds ago ago';
SELECT INTERVAL '2 minutes ago 5 days';

-- consecutive and dangling units are not allowed.
SELECT INTERVAL 'hour 5 months';
SELECT INTERVAL '1 year months days 5 hours';

-- unacceptable reserved words in interval. Only /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''infinity/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'', /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''+infinity/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' and
-- /* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''-infinity/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED *//* REPLACED */''/* REPLACED */''/* REPLACED *//* REPLACED */''/* REPLACED */'' are allowed.
SELECT INTERVAL 'now';
SELECT INTERVAL 'today';
SELECT INTERVAL 'tomorrow';
SELECT INTERVAL 'allballs';
SELECT INTERVAL 'epoch';
SELECT INTERVAL 'yesterday';

-- infinity specification should be the only thing
SELECT INTERVAL 'infinity years';
SELECT INTERVAL 'infinity ago';
SELECT INTERVAL '+infinity -infinity';
-- END setup from interval 
SELECT pg_catalog.set_config('search_path', 'public', false);
