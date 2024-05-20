-- START setup from test_setup 
--
-- TEST_SETUP --- prepare environment expected by regression test scripts
--

-- directory paths and dlsuffix are passed to us in environment variables
-- \getenv abs_srcdir '/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests'
-- \getenv libdir '/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress'
-- \getenv dlsuffix '.so'

-- \set regresslib /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress' '/regress' /* REPLACED */'.so'

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

-- \set filename /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/onek.data'
COPY onek FROM /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/onek.data';
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

-- \set filename /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/tenk.data'
COPY tenk1 FROM /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/tenk.data';
VACUUM ANALYZE tenk1;

CREATE TABLE tenk2 AS SELECT * FROM tenk1;
VACUUM ANALYZE tenk2;

CREATE TABLE person (
	name 		text,
	age			int4,
	location 	point
);

-- \set filename /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/person.data'
COPY person FROM /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/person.data';
VACUUM ANALYZE person;

CREATE TABLE emp (
	salary 		int4,
	manager 	name
) INHERITS (person);

-- \set filename /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/emp.data'
COPY emp FROM /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/emp.data';
VACUUM ANALYZE emp;

CREATE TABLE student (
	gpa 		float8
) INHERITS (person);

-- \set filename /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/student.data'
COPY student FROM /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/student.data';
VACUUM ANALYZE student;

CREATE TABLE stud_emp (
	percent 	int4
) INHERITS (emp, student);

-- \set filename /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/stud_emp.data'
COPY stud_emp FROM /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/stud_emp.data';
VACUUM ANALYZE stud_emp;

CREATE TABLE road (
	name		text,
	thepath 	path
);

-- \set filename /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests' '/data/streets.data'
COPY road FROM /* REPLACED */'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests/data/streets.data';