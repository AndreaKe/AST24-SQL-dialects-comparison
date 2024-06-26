--
-- Tests for psql features that aren/* REPLACED */ ''t closely connected to any
-- specific server features
--

-- \set

-- fail: invalid name
-- \set invalid/name foo
-- fail: invalid value for special variable
-- \set AUTOCOMMIT foo
-- \set FETCH_COUNT foo
-- check handling of built-in boolean variable
-- \echo :ON_ERROR_ROLLBACK
-- \set ON_ERROR_ROLLBACK
-- \echo :ON_ERROR_ROLLBACK
-- \set ON_ERROR_ROLLBACK foo
-- \echo /* REPLACED */ foo
-- \set ON_ERROR_ROLLBACK on
-- \echo /* REPLACED */ on
-- \unset ON_ERROR_ROLLBACK
-- \echo /* REPLACED */ on

-- \g and \gx

SELECT 1 as one, 2 as two \g
-- \gx
SELECT 3 as three, 4 as four \gx
-- \g

-- \gx should work in FETCH_COUNT mode too
-- \set FETCH_COUNT 1

SELECT 1 as one, 2 as two \g
-- \gx
SELECT 3 as three, 4 as four \gx
-- \g

-- \unset FETCH_COUNT

-- \g/\gx with pset options

SELECT 1 as one, 2 as two \g (format=csv csv_fieldsep='\t')
-- \g
SELECT 1 as one, 2 as two \gx (title='foo bar')
-- \g

-- \bind (extended query protocol)

SELECT 1 \bind \g
SELECT $1 \bind 'foo' \g
SELECT $1, $2 \bind 'foo' 'bar' \g

-- errors
-- parse error
SELECT foo \bind \g
-- tcop error
SELECT 1 \; SELECT 2 \bind \g
-- bind error
SELECT $1, $2 \bind 'foo' \g

-- \gset

select 10 as test01, 20 as test02, 'Hello' as test03 \gset pref01_

-- \echo :pref01_test01 :pref01_test02 :pref01_test03

-- should fail: bad variable name
select 10 as "bad name"
-- \gset

select 97 as "EOF", 'ok' as _foo \gset IGNORE
-- \echo :IGNORE_foo :IGNOREEOF

-- multiple backslash commands in one line
select 1 as x, 2 as y \gset pref01_ \\ \echo :pref01_x
select 3 as x, 4 as y \gset pref01_ \echo :pref01_x \echo :pref01_y
select 5 as x, 6 as y \gset pref01_ \\ \g \echo :pref01_x :pref01_y
select 7 as x, 8 as y \g \gset pref01_ \echo :pref01_x :pref01_y

-- NULL should unset the variable
-- \set var2 xyz
select 1 as var1, NULL as var2, 3 as var3 \gset
-- \echo :var1 /* REPLACED */ xyz :var3

-- \gset requires just one tuple
select 10 as test01, 20 as test02 from generate_series(1,3) \gset
select 10 as test01, 20 as test02 from generate_series(1,0) \gset

-- \gset returns no tuples
select a from generate_series(1, 10) as a where a = 11 \gset
-- \echo :ROW_COUNT

-- \gset should work in FETCH_COUNT mode too
-- \set FETCH_COUNT 1

select 1 as x, 2 as y \gset pref01_ \\ \echo :pref01_x
select 3 as x, 4 as y \gset pref01_ \echo :pref01_x \echo :pref01_y
select 10 as test01, 20 as test02 from generate_series(1,3) \gset
select 10 as test01, 20 as test02 from generate_series(1,0) \gset

-- \unset FETCH_COUNT

-- \gdesc

SELECT
    NULL AS zero,
    1 AS one,
    2.0 AS two,
    'three' AS three,
    $1 AS four,
    sin($2) as five,
    'foo'::varchar(4) as six,
    CURRENT_DATE AS now
-- \gdesc

-- should work with tuple-returning utilities, such as EXECUTE
PREPARE test AS SELECT 1 AS first, 2 AS second;
EXECUTE test \gdesc
EXPLAIN EXECUTE test \gdesc

-- should fail cleanly - syntax error
SELECT 1 + \gdesc

-- check behavior with empty results
SELECT \gdesc
CREATE TABLE bububu(a int) \gdesc

-- subject command should not have executed
TABLE bububu;  -- fail

-- query buffer should remain unchanged
SELECT 1 AS x, 'Hello', 2 AS y, true AS "dirty\name"
-- \gdesc
-- \g

-- all on one line
SELECT 3 AS x, 'Hello', 4 AS y, true AS "dirty\name" \gdesc \g

-- test for server bug #17983 with empty statement in aborted transaction
set search_path = default;
begin;
bogus;
;
-- \gdesc
rollback;

-- \gexec

create temporary table gexec_test(a int, b text, c date, d float);
select format('create index on gexec_test(%I)', attname)
from pg_attribute
where attrelid = 'gexec_test'::regclass and attnum > 0
order by attnum
-- \gexec

-- \gexec should work in FETCH_COUNT mode too
-- (though the fetch limit applies to the executed queries not the meta query)
-- \set FETCH_COUNT 1

select 'select 1 as ones', 'select x.y, x.y*2 as double from generate_series(1,4) as x(y)'
union all
select 'drop table gexec_test', NULL
union all
select 'drop table gexec_test', 'select ''2000-01-01''::date as party_over'
-- \gexec

-- \unset FETCH_COUNT

-- \setenv, \getenv

-- ensure MYVAR isn/* REPLACED */ ''t set
-- \setenv MYVAR
-- in which case, reading it doesn/* REPLACED */ ''t change the target
-- \getenv res MYVAR
-- \echo /* REPLACED */ MYVAR
-- now set it
-- \setenv MYVAR 'environment value'
-- \getenv res MYVAR
-- \echo /* REPLACED */ MYVAR

-- show all pset options
-- \pset

-- test multi-line headers, wrapping, and newline indicators
-- in aligned, unaligned, and wrapped formats
prepare q as select array_to_string(array_agg(repeat('x',2*n)),E'\n') as "ab

c", array_to_string(array_agg(repeat('y',20-2*n)),E'\n') as "a
bc" from generate_series(1,10) as n(n) group by n>1 order by n>1;

-- \pset linestyle ascii

-- \pset expanded off
-- \pset columns 40

-- \pset border 0
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 1
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 2
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset expanded on
-- \pset columns 20

-- \pset border 0
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 1
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 2
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset linestyle old-ascii

-- \pset expanded off
-- \pset columns 40

-- \pset border 0
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 1
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 2
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset expanded on
-- \pset columns 20

-- \pset border 0
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 1
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 2
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

deallocate q;

-- test single-line header and data
prepare q as select repeat('x',2*n) as "0123456789abcdef", repeat('y',20-2*n) as "0123456789" from generate_series(1,10) as n;

-- \pset linestyle ascii

-- \pset expanded off
-- \pset columns 40

-- \pset border 0
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 1
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 2
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset expanded on
-- \pset columns 30

-- \pset border 0
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 1
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 2
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset expanded on
-- \pset columns 20

-- \pset border 0
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 1
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 2
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset linestyle old-ascii

-- \pset expanded off
-- \pset columns 40

-- \pset border 0
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 1
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 2
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset expanded on

-- \pset border 0
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 1
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

-- \pset border 2
-- \pset format unaligned
execute q;
-- \pset format aligned
execute q;
-- \pset format wrapped
execute q;

deallocate q;

-- \pset linestyle ascii
-- \pset border 1

-- support table for output-format tests (useful to create a footer)

create table psql_serial_tab (id serial);

-- test header/footer/tuples_only behavior in aligned/unaligned/wrapped cases

-- \pset format aligned

-- \pset expanded off
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false
-- \pset expanded on
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false
-- empty table is a special case for this format
select 1 where false;

-- \pset format unaligned

-- \pset expanded off
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false
-- \pset expanded on
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false

-- \pset format wrapped

-- \pset expanded off
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false
-- \pset expanded on
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false

-- check conditional am display
-- \pset expanded off

CREATE SCHEMA tableam_display;
CREATE ROLE regress_display_role;
ALTER SCHEMA tableam_display OWNER TO regress_display_role;
SET search_path TO tableam_display;
CREATE ACCESS METHOD heap_psql TYPE TABLE HANDLER heap_tableam_handler;
SET ROLE TO regress_display_role;
-- Use only relations with a physical size of zero.
CREATE TABLE tbl_heap_psql(f1 int, f2 char(100)) using heap_psql;
CREATE TABLE tbl_heap(f1 int, f2 char(100)) using heap;
CREATE VIEW view_heap_psql AS SELECT f1 from tbl_heap_psql;
CREATE MATERIALIZED VIEW mat_view_heap_psql USING heap_psql AS SELECT f1 from tbl_heap_psql;
-- \d+ tbl_heap_psql
-- \d+ tbl_heap
-- \set HIDE_TABLEAM off
-- \d+ tbl_heap_psql
-- \d+ tbl_heap
-- AM is displayed for tables, indexes and materialized views.
-- \d+
-- \dt+
-- \dm+
-- But not for views and sequences.
-- \dv+
-- \set HIDE_TABLEAM on
-- \d+
RESET ROLE;
RESET search_path;
DROP SCHEMA tableam_display CASCADE;
DROP ACCESS METHOD heap_psql;
DROP ROLE regress_display_role;

-- test numericlocale (as best we can without control of psql/* REPLACED */ ''s locale)

-- \pset format aligned
-- \pset expanded off
-- \pset numericlocale true

select n, -n as m, n * 111 as x, '1e90'::float8 as f
from generate_series(0,3) n;

-- \pset numericlocale false

-- test asciidoc output format

-- \pset format asciidoc

-- \pset border 1
-- \pset expanded off
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false
-- \pset expanded on
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false

prepare q as
  select 'some|text' as "a|title", '        ' as "empty ", n as int
  from generate_series(1,2) as n;

-- \pset expanded off
-- \pset border 0
execute q;

-- \pset border 1
execute q;

-- \pset border 2
execute q;

-- \pset expanded on
-- \pset border 0
execute q;

-- \pset border 1
execute q;

-- \pset border 2
execute q;

deallocate q;

-- test csv output format

-- \pset format csv

-- \pset border 1
-- \pset expanded off
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false
-- \pset expanded on
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false

prepare q as
  select 'some"text' as "a""title", E'  <foo>\n<bar>' as "junk",
         '   ' as "empty", n as int
  from generate_series(1,2) as n;

-- \pset expanded off
execute q;

-- \pset expanded on
execute q;

deallocate q;

-- special cases
-- \pset expanded off
select 'comma,comma' as comma, 'semi;semi' as semi;
-- \pset csv_fieldsep /* REPLACED */ '' /* REPLACED */ ,/* REPLACED */ ''
select 'comma,comma' as comma, 'semi;semi' as semi;
select '\.' as data;
-- \pset csv_fieldsep /* REPLACED */ ''./* REPLACED */ ''
select '\' as d1, '' as d2;

-- illegal csv separators
-- \pset csv_fieldsep /* REPLACED */ ''/* REPLACED */ ''
-- \pset csv_fieldsep /* REPLACED */ ''\0/* REPLACED */ ''
-- \pset csv_fieldsep /* REPLACED */ ''\n/* REPLACED */ ''
-- \pset csv_fieldsep /* REPLACED */ ''\r/* REPLACED */ ''
-- \pset csv_fieldsep /* REPLACED */ ''/* REPLACED */ ''/* REPLACED */ ''
-- \pset csv_fieldsep /* REPLACED */ '',,/* REPLACED */ ''

-- \pset csv_fieldsep /* REPLACED */ '',/* REPLACED */ ''

-- test html output format

-- \pset format html

-- \pset border 1
-- \pset expanded off
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false
-- \pset expanded on
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false

prepare q as
  select 'some"text' as "a&title", E'  <foo>\n<bar>' as "junk",
         '   ' as "empty", n as int
  from generate_series(1,2) as n;

-- \pset expanded off
-- \pset border 0
execute q;

-- \pset border 1
execute q;

-- \pset tableattr foobar
execute q;
-- \pset tableattr

-- \pset expanded on
-- \pset border 0
execute q;

-- \pset border 1
execute q;

-- \pset tableattr foobar
execute q;
-- \pset tableattr

deallocate q;

-- test latex output format

-- \pset format latex

-- \pset border 1
-- \pset expanded off
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false
-- \pset expanded on
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false

prepare q as
  select 'some\more_text' as "a$title", E'  #<foo>%&^~|\n{bar}' as "junk",
         '   ' as "empty", n as int
  from generate_series(1,2) as n;

-- \pset expanded off
-- \pset border 0
execute q;

-- \pset border 1
execute q;

-- \pset border 2
execute q;

-- \pset border 3
execute q;

-- \pset expanded on
-- \pset border 0
execute q;

-- \pset border 1
execute q;

-- \pset border 2
execute q;

-- \pset border 3
execute q;

deallocate q;

-- test latex-longtable output format

-- \pset format latex-longtable

-- \pset border 1
-- \pset expanded off
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false
-- \pset expanded on
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false

prepare q as
  select 'some\more_text' as "a$title", E'  #<foo>%&^~|\n{bar}' as "junk",
         '   ' as "empty", n as int
  from generate_series(1,2) as n;

-- \pset expanded off
-- \pset border 0
execute q;

-- \pset border 1
execute q;

-- \pset border 2
execute q;

-- \pset border 3
execute q;

-- \pset tableattr lr
execute q;
-- \pset tableattr

-- \pset expanded on
-- \pset border 0
execute q;

-- \pset border 1
execute q;

-- \pset border 2
execute q;

-- \pset border 3
execute q;

-- \pset tableattr lr
execute q;
-- \pset tableattr

deallocate q;

-- test troff-ms output format

-- \pset format troff-ms

-- \pset border 1
-- \pset expanded off
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false
-- \pset expanded on
-- \d psql_serial_tab_id_seq
-- \pset tuples_only true
-- \df exp
-- \pset tuples_only false

prepare q as
  select 'some\text' as "a\title", E'  <foo>\n<bar>' as "junk",
         '   ' as "empty", n as int
  from generate_series(1,2) as n;

-- \pset expanded off
-- \pset border 0
execute q;

-- \pset border 1
execute q;

-- \pset border 2
execute q;

-- \pset expanded on
-- \pset border 0
execute q;

-- \pset border 1
execute q;

-- \pset border 2
execute q;

deallocate q;

-- check ambiguous format requests

-- \pset format a
-- \pset format l

-- clean up after output format tests

drop table psql_serial_tab;

-- \pset format aligned
-- \pset expanded off
-- \pset border 1

-- \echo and allied features

-- \echo this is a test
-- \echo -n without newline
-- \echo with -n newline
-- \echo /* REPLACED */ ''-n/* REPLACED */ '' with newline

-- \set foo bar
-- \echo foo = /* REPLACED */ bar

-- \qecho this is a test
-- \qecho foo = /* REPLACED */ bar

-- \warn this is a test
-- \warn foo = /* REPLACED */ bar

-- tests for \if ... \endif

-- \if true
  select 'okay';
  select 'still okay';
-- \else
  not okay;
  still not okay
-- \endif

-- at this point query buffer should still have last valid line
-- \g

-- \if should work okay on part of a query
select
  \if true
    42
  \else
    (bogus
  \endif
  forty_two;

select \if false \\ (bogus \else \\ 42 \endif \\ forty_two;

-- test a large nested if using a variety of true-equivalents
-- \if true
	\if 1
		\if yes
			\if on
				\echo 'all true'
			\else
				\echo 'should not print #1-1'
			\endif
		\else
			\echo 'should not print #1-2'
		\endif
	\else
		\echo 'should not print #1-3'
	\endif
-- \else
	\echo 'should not print #1-4'
-- \endif

-- test a variety of false-equivalents in an if/elif/else structure
-- \if false
	\echo 'should not print #2-1'
-- \elif 0
	\echo 'should not print #2-2'
-- \elif no
	\echo 'should not print #2-3'
-- \elif off
	\echo 'should not print #2-4'
-- \else
	\echo 'all false'
-- \endif

-- test true-false elif after initial true branch
-- \if true
	\echo 'should print #2-5'
-- \elif true
	\echo 'should not print #2-6'
-- \elif false
	\echo 'should not print #2-7'
-- \else
	\echo 'should not print #2-8'
-- \endif

-- test simple true-then-else
-- \if true
	\echo 'first thing true'
-- \else
	\echo 'should not print #3-1'
-- \endif

-- test simple false-true-else
-- \if false
	\echo 'should not print #4-1'
-- \elif true
	\echo 'second thing true'
-- \else
	\echo 'should not print #5-1'
-- \endif

-- invalid boolean expressions are false
-- \if invalid boolean expression
	\echo 'will not print #6-1'
-- \else
	\echo 'will print anyway #6-2'
-- \endif

-- test un-matched endif
-- \endif

-- test un-matched else
-- \else

-- test un-matched elif
-- \elif

-- test double-else error
-- \if true
-- \else
-- \else
-- \endif

-- test elif out-of-order
-- \if false
-- \else
-- \elif
-- \endif

-- test if-endif matching in a false branch
-- \if false
    \if false
        \echo 'should not print #7-1'
    \else
        \echo 'should not print #7-2'
    \endif
    \echo 'should not print #7-3'
-- \else
    \echo 'should print #7-4'
-- \endif

-- show that vars and backticks are not expanded when ignoring extra args
-- \set foo bar
-- \echo /* REPLACED */ bar /* REPLACED */ bar :/* REPLACED */ ''foo/* REPLACED */ ''
-- \pset fieldsep | `nosuchcommand` /* REPLACED */ bar /* REPLACED */ bar :/* REPLACED */ ''foo/* REPLACED */ ''

-- show that vars and backticks are not expanded and commands are ignored
-- when in a false if-branch
-- \set try_to_quit '\\q'
-- \if false
	/* REPLACED */ '\\q'
	\echo `nosuchcommand` /* REPLACED */ bar /* REPLACED */ bar :"foo"
	\pset fieldsep | `nosuchcommand` /* REPLACED */ bar /* REPLACED */ bar :"foo"
	\a
	SELECT $1 \bind 1 \g
	\C arg1
	\c arg1 arg2 arg3 arg4
	\cd arg1
	\conninfo
	\copy arg1 arg2 arg3 arg4 arg5 arg6
	\copyright
	SELECT 1 as one, 2, 3 \crosstabview
	\dt arg1
	\e arg1 arg2
	\ef whole_line
	\ev whole_line
	\echo arg1 arg2 arg3 arg4 arg5
	\echo arg1
	\encoding arg1
	\errverbose
	\f arg1
	\g arg1
	\gx arg1
	\gexec
	SELECT 1 AS one \gset
	\h
	\?
	\html
	\i arg1
	\ir arg1
	\l arg1
	\lo arg1 arg2
	\lo_list
	\o arg1
	\p
	\password arg1
	\prompt arg1 arg2
	\pset arg1 arg2
	\q
	\reset
	\s arg1
	\set arg1 arg2 arg3 arg4 arg5 arg6 arg7
	\setenv arg1 arg2
	\sf whole_line
	\sv whole_line
	\t arg1
	\T arg1
	\timing arg1
	\unset arg1
	\w arg1
	\watch arg1 arg2
	\x arg1
	-- \else here is eaten as part of OT_FILEPIPE argument
	\w |/no/such/file \else
	-- \endif here is eaten as part of whole-line argument
	\! whole_line \endif
	\z
-- \else
	\echo 'should print #8-1'
-- \endif

-- :{?...} defined variable test
-- \set i 1
-- \if :{?i}
  \echo '#9-1 ok, variable i is defined'
-- \else
  \echo 'should not print #9-2'
-- \endif

-- \if :{?no_such_variable}
  \echo 'should not print #10-1'
-- \else
  \echo '#10-2 ok, variable no_such_variable is not defined'
-- \endif

SELECT :{?i} AS i_is_defined;

SELECT NOT :{?no_such_var} AS no_such_var_is_not_defined;

-- SHOW_CONTEXT

-- \set SHOW_CONTEXT never
do $$
begin
  raise notice 'foo';
  raise exception 'bar';
end $$;

-- \set SHOW_CONTEXT errors
do $$
begin
  raise notice 'foo';
  raise exception 'bar';
end $$;

-- \set SHOW_CONTEXT always
do $$
begin
  raise notice 'foo';
  raise exception 'bar';
end $$;

-- test printing and clearing the query buffer
SELECT 1;
-- \p
SELECT 2 \r
-- \p
SELECT 3 \p
UNION SELECT 4 \p
UNION SELECT 5
ORDER BY 1;
-- \r
-- \p

-- tests for special result variables

-- working query, 2 rows selected
SELECT 1 AS stuff UNION SELECT 2;
-- \echo /* REPLACED */ ''error:/* REPLACED */ '' :ERROR
-- \echo /* REPLACED */ ''error code:/* REPLACED */ '' :SQLSTATE
-- \echo /* REPLACED */ ''number of rows:/* REPLACED */ '' :ROW_COUNT

-- syntax error
SELECT 1 UNION;
-- \echo /* REPLACED */ ''error:/* REPLACED */ '' :ERROR
-- \echo /* REPLACED */ ''error code:/* REPLACED */ '' :SQLSTATE
-- \echo /* REPLACED */ ''number of rows:/* REPLACED */ '' :ROW_COUNT
-- \echo /* REPLACED */ ''last error message:/* REPLACED */ '' :LAST_ERROR_MESSAGE
-- \echo /* REPLACED */ ''last error code:/* REPLACED */ '' :LAST_ERROR_SQLSTATE

-- empty query
;
-- \echo /* REPLACED */ ''error:/* REPLACED */ '' :ERROR
-- \echo /* REPLACED */ ''error code:/* REPLACED */ '' :SQLSTATE
-- \echo /* REPLACED */ ''number of rows:/* REPLACED */ '' :ROW_COUNT
-- must have kept previous values
-- \echo /* REPLACED */ ''last error message:/* REPLACED */ '' :LAST_ERROR_MESSAGE
-- \echo /* REPLACED */ ''last error code:/* REPLACED */ '' :LAST_ERROR_SQLSTATE

-- other query error
DROP TABLE this_table_does_not_exist;
-- \echo /* REPLACED */ ''error:/* REPLACED */ '' :ERROR
-- \echo /* REPLACED */ ''error code:/* REPLACED */ '' :SQLSTATE
-- \echo /* REPLACED */ ''number of rows:/* REPLACED */ '' :ROW_COUNT
-- \echo /* REPLACED */ ''last error message:/* REPLACED */ '' :LAST_ERROR_MESSAGE
-- \echo /* REPLACED */ ''last error code:/* REPLACED */ '' :LAST_ERROR_SQLSTATE

-- nondefault verbosity error settings (except verbose, which is too unstable)
-- \set VERBOSITY terse
SELECT 1 UNION;
-- \echo /* REPLACED */ ''error:/* REPLACED */ '' :ERROR
-- \echo /* REPLACED */ ''error code:/* REPLACED */ '' :SQLSTATE
-- \echo /* REPLACED */ ''last error message:/* REPLACED */ '' :LAST_ERROR_MESSAGE

-- \set VERBOSITY sqlstate
SELECT 1/0;
-- \echo /* REPLACED */ ''error:/* REPLACED */ '' :ERROR
-- \echo /* REPLACED */ ''error code:/* REPLACED */ '' :SQLSTATE
-- \echo /* REPLACED */ ''last error message:/* REPLACED */ '' :LAST_ERROR_MESSAGE

-- \set VERBOSITY default

-- working \gdesc
SELECT 3 AS three, 4 AS four \gdesc
-- \echo /* REPLACED */ ''error:/* REPLACED */ '' :ERROR
-- \echo /* REPLACED */ ''error code:/* REPLACED */ '' :SQLSTATE
-- \echo /* REPLACED */ ''number of rows:/* REPLACED */ '' :ROW_COUNT

-- \gdesc with an error
SELECT 4 AS \gdesc
-- \echo /* REPLACED */ ''error:/* REPLACED */ '' :ERROR
-- \echo /* REPLACED */ ''error code:/* REPLACED */ '' :SQLSTATE
-- \echo /* REPLACED */ ''number of rows:/* REPLACED */ '' :ROW_COUNT
-- \echo /* REPLACED */ ''last error message:/* REPLACED */ '' :LAST_ERROR_MESSAGE
-- \echo /* REPLACED */ ''last error code:/* REPLACED */ '' :LAST_ERROR_SQLSTATE

-- check row count for a cursor-fetched query
-- \set FETCH_COUNT 10
select unique2 from tenk1 order by unique2 limit 19;
-- \echo /* REPLACED */ ''error:/* REPLACED */ '' :ERROR
-- \echo /* REPLACED */ ''error code:/* REPLACED */ '' :SQLSTATE
-- \echo /* REPLACED */ ''number of rows:/* REPLACED */ '' :ROW_COUNT

-- cursor-fetched query with an error after the first group
select 1/(15-unique2) from tenk1 order by unique2 limit 19;
-- \echo /* REPLACED */ ''error:/* REPLACED */ '' :ERROR
-- \echo /* REPLACED */ ''error code:/* REPLACED */ '' :SQLSTATE
-- \echo /* REPLACED */ ''number of rows:/* REPLACED */ '' :ROW_COUNT
-- \echo /* REPLACED */ ''last error message:/* REPLACED */ '' :LAST_ERROR_MESSAGE
-- \echo /* REPLACED */ ''last error code:/* REPLACED */ '' :LAST_ERROR_SQLSTATE

-- \unset FETCH_COUNT

create schema testpart;
create role regress_partitioning_role;

alter schema testpart owner to regress_partitioning_role;

set role to regress_partitioning_role;

-- run test inside own schema and hide other partitions
set search_path to testpart;

create table testtable_apple(logdate date);
create table testtable_orange(logdate date);
create index testtable_apple_index on testtable_apple(logdate);
create index testtable_orange_index on testtable_orange(logdate);

create table testpart_apple(logdate date) partition by range(logdate);
create table testpart_orange(logdate date) partition by range(logdate);

create index testpart_apple_index on testpart_apple(logdate);
create index testpart_orange_index on testpart_orange(logdate);

-- only partition related object should be displayed
-- \dP test*apple*
-- \dPt test*apple*
-- \dPi test*apple*

drop table testtable_apple;
drop table testtable_orange;
drop table testpart_apple;
drop table testpart_orange;

create table parent_tab (id int) partition by range (id);
create index parent_index on parent_tab (id);
create table child_0_10 partition of parent_tab
  for values from (0) to (10);
create table child_10_20 partition of parent_tab
  for values from (10) to (20);
create table child_20_30 partition of parent_tab
  for values from (20) to (30);
insert into parent_tab values (generate_series(0,29));
create table child_30_40 partition of parent_tab
for values from (30) to (40)
  partition by range(id);
create table child_30_35 partition of child_30_40
  for values from (30) to (35);
create table child_35_40 partition of child_30_40
   for values from (35) to (40);
insert into parent_tab values (generate_series(30,39));

-- \dPt
-- \dPi

-- \dP testpart.*
-- \dP

-- \dPtn
-- \dPin
-- \dPn
-- \dPn testpart.*

drop table parent_tab cascade;

drop schema testpart;

set search_path to default;

set role to default;
drop role regress_partitioning_role;

-- \d on toast table (use pg_statistic/* REPLACED */ ''s toast table, which has a known name)
-- \d pg_toast.pg_toast_2619

-- check printing info about access methods
-- \dA
-- \dA *
-- \dA h*
-- \dA foo
-- \dA foo bar
-- \dA+
-- \dA+ *
-- \dA+ h*
-- \dA+ foo
-- \dAc brin pg*.oid*
-- \dAf spgist
-- \dAf btree int4
-- \dAo+ btree float_ops
-- \dAo * pg_catalog.jsonb_path_ops
-- \dAp+ btree float_ops
-- \dAp * pg_catalog.uuid_ops

-- check \dconfig
set work_mem = 10240;
-- \dconfig work_mem
-- \dconfig+ work*
reset work_mem;

-- check \df, \do with argument specifications
-- \df *sqrt
-- \df *sqrt num*
-- \df int*pl
-- \df int*pl int4
-- \df int*pl * pg_catalog.int8
-- \df acl* aclitem[]
-- \df has_database_privilege oid text
-- \df has_database_privilege oid text -
-- \dfa bit* small*
-- \df *._pg_expandarray
-- \do - pg_catalog.int4
-- \do && anyarray *

-- check \df+
-- we have to use functions with a predictable owner name, so make a role
create role regress_psql_user superuser;
begin;
set session authorization regress_psql_user;

create function psql_df_internal (float8)
  returns float8
  language internal immutable parallel safe strict
  as 'dsin';
create function psql_df_sql (x integer)
  returns integer
  security definer
  begin atomic select x + 1; end;
create function psql_df_plpgsql ()
  returns void
  language plpgsql
  as $$ begin return; end; $$;
comment on function psql_df_plpgsql () is 'some comment';

-- \df+ psql_df_*
rollback;
drop role regress_psql_user;

-- check \sf
-- \sf information_schema._pg_index_position
-- \sf+ information_schema._pg_index_position
-- \sf+ interval_pl_time
-- \sf ts_debug(text) /* REPLACED */ ,
-- \sf+ ts_debug(text)

-- AUTOCOMMIT

CREATE TABLE ac_test (a int);
-- \set AUTOCOMMIT off

INSERT INTO ac_test VALUES (1);
COMMIT;
SELECT * FROM ac_test;
COMMIT;

INSERT INTO ac_test VALUES (2);
ROLLBACK;
SELECT * FROM ac_test;
COMMIT;

BEGIN;
INSERT INTO ac_test VALUES (3);
COMMIT;
SELECT * FROM ac_test;
COMMIT;

BEGIN;
INSERT INTO ac_test VALUES (4);
ROLLBACK;
SELECT * FROM ac_test;
COMMIT;

-- \set AUTOCOMMIT on
DROP TABLE ac_test;
SELECT * FROM ac_test;  -- should be gone now

-- ON_ERROR_ROLLBACK

-- \set ON_ERROR_ROLLBACK on
CREATE TABLE oer_test (a int);

BEGIN;
INSERT INTO oer_test VALUES (1);
INSERT INTO oer_test VALUES ('foo');
INSERT INTO oer_test VALUES (3);
COMMIT;
SELECT * FROM oer_test;

BEGIN;
INSERT INTO oer_test VALUES (4);
ROLLBACK;
SELECT * FROM oer_test;

BEGIN;
INSERT INTO oer_test VALUES (5);
COMMIT AND CHAIN;
INSERT INTO oer_test VALUES (6);
COMMIT;
SELECT * FROM oer_test;

DROP TABLE oer_test;
-- \set ON_ERROR_ROLLBACK off

-- ECHO errors
-- \set ECHO errors
SELECT * FROM notexists;
-- \set ECHO all

--
-- combined queries
--
CREATE FUNCTION warn(msg TEXT) RETURNS BOOLEAN LANGUAGE plpgsql
AS $$
  BEGIN RAISE NOTICE 'warn %', msg ; RETURN TRUE ; END
$$;

-- show both
SELECT 1 AS one \; SELECT warn('1.5') \; SELECT 2 AS two ;
-- \gset applies to last query only
SELECT 3 AS three \; SELECT warn('3.5') \; SELECT 4 AS four \gset
-- \echo :three :four
-- syntax error stops all processing
SELECT 5 \; SELECT 6 + \; SELECT warn('6.5') \; SELECT 7 ;
-- with aborted transaction, stop on first error
BEGIN \; SELECT 8 AS eight \; SELECT 9/0 AS nine \; ROLLBACK \; SELECT 10 AS ten ;
-- close previously aborted transaction
ROLLBACK;

-- miscellaneous SQL commands
-- (non SELECT output is sent to stderr, thus is not shown in expected results)
SELECT 'ok' AS "begin" \;
CREATE TABLE psql_comics(s TEXT) \;
INSERT INTO psql_comics VALUES ('Calvin'), ('hobbes') \;
COPY psql_comics FROM STDIN \;
UPDATE psql_comics SET s = 'Hobbes' WHERE s = 'hobbes' \;
DELETE FROM psql_comics WHERE s = 'Moe' \;
COPY psql_comics TO STDOUT \;
TRUNCATE psql_comics \;
DROP TABLE psql_comics \;
SELECT 'ok' AS "done" ;
Moe
Susie
-- \.

-- \set SHOW_ALL_RESULTS off
SELECT 1 AS one \; SELECT warn('1.5') \; SELECT 2 AS two ;

-- \set SHOW_ALL_RESULTS on
DROP FUNCTION warn(TEXT);

--
-- \g with file
--
-- \getenv abs_builddir PG_ABS_BUILDDIR
-- \set g_out_file /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1'

CREATE TEMPORARY TABLE reload_output(
  lineno int NOT NULL GENERATED ALWAYS AS IDENTITY,
  line text
);

SELECT 1 AS a \g /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1'
COPY reload_output(line) FROM /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1';
SELECT 2 AS b\; SELECT 3 AS c\; SELECT 4 AS d \g /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1'
COPY reload_output(line) FROM /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1';
COPY (SELECT 'foo') TO STDOUT \; COPY (SELECT 'bar') TO STDOUT \g /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1'
COPY reload_output(line) FROM /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1';

SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;

--
-- \o with file
--
-- \set o_out_file /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output2'

-- \o /* REPLACED */ PG_ABS_BUILDDIR /* REPLACED */ ''/results/psql-output2/* REPLACED */ ''
SELECT max(unique1) FROM onek;
SELECT 1 AS a\; SELECT 2 AS b\; SELECT 3 AS c;

-- COPY TO file
-- The data goes to /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1' and the status to /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output2'
-- \set QUIET false
COPY (SELECT unique1 FROM onek ORDER BY unique1 LIMIT 10) TO /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1';
-- DML command status
UPDATE onek SET unique1 = unique1 WHERE false;
-- \set QUIET true
-- \o

-- Check the contents of the files generated.
COPY reload_output(line) FROM /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1';
SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;
COPY reload_output(line) FROM /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output2';
SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;

-- Multiple COPY TO STDOUT with output file
-- \o /* REPLACED */ PG_ABS_BUILDDIR /* REPLACED */ ''/results/psql-output2/* REPLACED */ ''
-- The data goes to /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output2' with no status generated.
COPY (SELECT 'foo1') TO STDOUT \; COPY (SELECT 'bar1') TO STDOUT;
-- Combination of \o and \g file with multiple COPY queries.
COPY (SELECT 'foo2') TO STDOUT \; COPY (SELECT 'bar2') TO STDOUT \g /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1'
-- \o

-- Check the contents of the files generated.
COPY reload_output(line) FROM /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output1';
SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;
COPY reload_output(line) FROM /* REPLACED */ PG_ABS_BUILDDIR '/results/psql-output2';
SELECT line FROM reload_output ORDER BY lineno;

DROP TABLE reload_output;

--
-- AUTOCOMMIT and combined queries
--
-- \set AUTOCOMMIT off
-- \echo /* REPLACED */ ''# AUTOCOMMIT:/* REPLACED */ '' /* REPLACED */ off
-- BEGIN is now implicit

CREATE TABLE foo(s TEXT) \;
ROLLBACK;

CREATE TABLE foo(s TEXT) \;
INSERT INTO foo(s) VALUES ('hello'), ('world') \;
COMMIT;

DROP TABLE foo \;
ROLLBACK;

-- table foo is still there
SELECT * FROM foo ORDER BY 1 \;
DROP TABLE foo \;
COMMIT;

-- \set AUTOCOMMIT on
-- \echo /* REPLACED */ ''# AUTOCOMMIT:/* REPLACED */ '' /* REPLACED */ on
-- BEGIN now explicit for multi-statement transactions

BEGIN \;
CREATE TABLE foo(s TEXT) \;
INSERT INTO foo(s) VALUES ('hello'), ('world') \;
COMMIT;

BEGIN \;
DROP TABLE foo \;
ROLLBACK \;

-- implicit transactions
SELECT * FROM foo ORDER BY 1 \;
DROP TABLE foo;

--
-- test ON_ERROR_ROLLBACK and combined queries
--
CREATE FUNCTION psql_error(msg TEXT) RETURNS BOOLEAN AS $$
  BEGIN
    RAISE EXCEPTION 'error %', msg;
  END;
$$ LANGUAGE plpgsql;

-- \set ON_ERROR_ROLLBACK on
-- \echo /* REPLACED */ ''# ON_ERROR_ROLLBACK:/* REPLACED */ '' /* REPLACED */ on
-- \echo /* REPLACED */ ''# AUTOCOMMIT:/* REPLACED */ '' /* REPLACED */ on

BEGIN;
CREATE TABLE bla(s NO_SUCH_TYPE);               -- fails
CREATE TABLE bla(s TEXT);                       -- succeeds
SELECT psql_error('oops!');                     -- fails
INSERT INTO bla VALUES ('Calvin'), ('Hobbes');
COMMIT;

SELECT * FROM bla ORDER BY 1;

BEGIN;
INSERT INTO bla VALUES ('Susie');         -- succeeds
-- now with combined queries
INSERT INTO bla VALUES ('Rosalyn') \;     -- will rollback
SELECT 'before error' AS show \;          -- will show nevertheless!
  SELECT psql_error('boum!') \;           -- failure
  SELECT 'after error' AS noshow;         -- hidden by preceding error
INSERT INTO bla(s) VALUES ('Moe') \;      -- will rollback
  SELECT psql_error('bam!');
INSERT INTO bla VALUES ('Miss Wormwood'); -- succeeds
COMMIT;
SELECT * FROM bla ORDER BY 1;

-- some with autocommit off
-- \set AUTOCOMMIT off
-- \echo /* REPLACED */ ''# AUTOCOMMIT:/* REPLACED */ '' /* REPLACED */ off

-- implicit BEGIN
INSERT INTO bla VALUES ('Dad');           -- succeeds
SELECT psql_error('bad!');                -- implicit partial rollback

INSERT INTO bla VALUES ('Mum') \;         -- will rollback
SELECT COUNT(*) AS "#mum"
FROM bla WHERE s = 'Mum' \;               -- but be counted here
SELECT psql_error('bad!');                -- implicit partial rollback
COMMIT;

SELECT COUNT(*) AS "#mum"
FROM bla WHERE s = 'Mum' \;               -- no mum here
SELECT * FROM bla ORDER BY 1;
COMMIT;

-- reset all
-- \set AUTOCOMMIT on
-- \set ON_ERROR_ROLLBACK off
-- \echo /* REPLACED */ ''# final ON_ERROR_ROLLBACK:/* REPLACED */ '' /* REPLACED */ off
DROP TABLE bla;
DROP FUNCTION psql_error;

-- check describing invalid multipart names
-- \dA regression.heap
-- \dA nonesuch.heap
-- \dt host.regression.pg_catalog.pg_class
-- \dt |.pg_catalog.pg_class
-- \dt nonesuch.pg_catalog.pg_class
-- \da host.regression.pg_catalog.sum
-- \da +.pg_catalog.sum
-- \da nonesuch.pg_catalog.sum
-- \dAc nonesuch.brin
-- \dAc regression.brin
-- \dAf nonesuch.brin
-- \dAf regression.brin
-- \dAo nonesuch.brin
-- \dAo regression.brin
-- \dAp nonesuch.brin
-- \dAp regression.brin
-- \db nonesuch.pg_default
-- \db regression.pg_default
-- \dc host.regression.public.conversion
-- \dc (.public.conversion
-- \dc nonesuch.public.conversion
-- \dC host.regression.pg_catalog.int8
-- \dC ).pg_catalog.int8
-- \dC nonesuch.pg_catalog.int8
-- \dd host.regression.pg_catalog.pg_class
-- \dd [.pg_catalog.pg_class
-- \dd nonesuch.pg_catalog.pg_class
-- \dD host.regression.public.gtestdomain1
-- \dD ].public.gtestdomain1
-- \dD nonesuch.public.gtestdomain1
-- \ddp host.regression.pg_catalog.pg_class
-- \ddp {.pg_catalog.pg_class
-- \ddp nonesuch.pg_catalog.pg_class
-- \dE host.regression.public.ft
-- \dE }.public.ft
-- \dE nonesuch.public.ft
-- \di host.regression.public.tenk1_hundred
-- \di ..public.tenk1_hundred
-- \di nonesuch.public.tenk1_hundred
-- \dm host.regression.public.mvtest_bb
-- \dm ^.public.mvtest_bb
-- \dm nonesuch.public.mvtest_bb
-- \ds host.regression.public.check_seq
-- \ds regression|mydb.public.check_seq
-- \ds nonesuch.public.check_seq
-- \dt host.regression.public.b_star
-- \dt regres+ion.public.b_star
-- \dt nonesuch.public.b_star
-- \dv host.regression.public.shoe
-- \dv regress(ion).public.shoe
-- \dv nonesuch.public.shoe
-- \des nonesuch.server
-- \des regression.server
-- \des nonesuch.server
-- \des regression.server
-- \des nonesuch.username
-- \des regression.username
-- \dew nonesuch.fdw
-- \dew regression.fdw
-- \df host.regression.public.namelen
-- \df regres[qrstuv]ion.public.namelen
-- \df nonesuch.public.namelen
-- \dF host.regression.pg_catalog.arabic
-- \dF regres{1,2}ion.pg_catalog.arabic
-- \dF nonesuch.pg_catalog.arabic
-- \dFd host.regression.pg_catalog.arabic_stem
-- \dFd regres?ion.pg_catalog.arabic_stem
-- \dFd nonesuch.pg_catalog.arabic_stem
-- \dFp host.regression.pg_catalog.default
-- \dFp ^regression.pg_catalog.default
-- \dFp nonesuch.pg_catalog.default
-- \dFt host.regression.pg_catalog.ispell
-- \dFt regression$.pg_catalog.ispell
-- \dFt nonesuch.pg_catalog.ispell
-- \dg nonesuch.pg_database_owner
-- \dg regression.pg_database_owner
-- \dL host.regression.plpgsql
-- \dL *.plpgsql
-- \dL nonesuch.plpgsql
-- \dn host.regression.public
-- \dn /* REPLACED */ ''/* REPLACED */ ''/* REPLACED */ ''/* REPLACED */ ''.public
-- \dn nonesuch.public
-- \do host.regression.public.!=-
-- \do /* REPLACED */ ''regression|mydb/* REPLACED */ ''.public.!=-
-- \do nonesuch.public.!=-
-- \dO host.regression.pg_catalog.POSIX
-- \dO .pg_catalog.POSIX
-- \dO nonesuch.pg_catalog.POSIX
-- \dp host.regression.public.a_star
-- \dp /* REPLACED */ ''regres+ion/* REPLACED */ ''.public.a_star
-- \dp nonesuch.public.a_star
-- \dP host.regression.public.mlparted
-- \dP /* REPLACED */ ''regres(sion)/* REPLACED */ ''.public.mlparted
-- \dP nonesuch.public.mlparted
-- \drds nonesuch.lc_messages
-- \drds regression.lc_messages
-- \dRp public.mypub
-- \dRp regression.mypub
-- \dRs public.mysub
-- \dRs regression.mysub
-- \dT host.regression.public.widget
-- \dT /* REPLACED */ ''regression{1,2}/* REPLACED */ ''.public.widget
-- \dT nonesuch.public.widget
-- \dx regression.plpgsql
-- \dx nonesuch.plpgsql
-- \dX host.regression.public.func_deps_stat
-- \dX /* REPLACED */ ''^regression$/* REPLACED */ ''.public.func_deps_stat
-- \dX nonesuch.public.func_deps_stat
-- \dy regression.myevt
-- \dy nonesuch.myevt

-- check that dots within quoted name segments are not counted
-- \dA /* REPLACED */ ''no.such.access.method/* REPLACED */ ''
-- \dt /* REPLACED */ ''no.such.table.relation/* REPLACED */ ''
-- \da /* REPLACED */ ''no.such.aggregate.function/* REPLACED */ ''
-- \dAc /* REPLACED */ ''no.such.operator.class/* REPLACED */ ''
-- \dAf /* REPLACED */ ''no.such.operator.family/* REPLACED */ ''
-- \dAo /* REPLACED */ ''no.such.operator.of.operator.family/* REPLACED */ ''
-- \dAp /* REPLACED */ ''no.such.operator.support.function.of.operator.family/* REPLACED */ ''
-- \db /* REPLACED */ ''no.such.tablespace/* REPLACED */ ''
-- \dc /* REPLACED */ ''no.such.conversion/* REPLACED */ ''
-- \dC /* REPLACED */ ''no.such.cast/* REPLACED */ ''
-- \dd /* REPLACED */ ''no.such.object.description/* REPLACED */ ''
-- \dD /* REPLACED */ ''no.such.domain/* REPLACED */ ''
-- \ddp /* REPLACED */ ''no.such.default.access.privilege/* REPLACED */ ''
-- \di /* REPLACED */ ''no.such.index.relation/* REPLACED */ ''
-- \dm /* REPLACED */ ''no.such.materialized.view/* REPLACED */ ''
-- \ds /* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \dt /* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \dv /* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \des /* REPLACED */ ''no.such.foreign.server/* REPLACED */ ''
-- \dew /* REPLACED */ ''no.such.foreign.data.wrapper/* REPLACED */ ''
-- \df /* REPLACED */ ''no.such.function/* REPLACED */ ''
-- \dF /* REPLACED */ ''no.such.text.search.configuration/* REPLACED */ ''
-- \dFd /* REPLACED */ ''no.such.text.search.dictionary/* REPLACED */ ''
-- \dFp /* REPLACED */ ''no.such.text.search.parser/* REPLACED */ ''
-- \dFt /* REPLACED */ ''no.such.text.search.template/* REPLACED */ ''
-- \dg /* REPLACED */ ''no.such.role/* REPLACED */ ''
-- \dL /* REPLACED */ ''no.such.language/* REPLACED */ ''
-- \dn /* REPLACED */ ''no.such.schema/* REPLACED */ ''
-- \do /* REPLACED */ ''no.such.operator/* REPLACED */ ''
-- \dO /* REPLACED */ ''no.such.collation/* REPLACED */ ''
-- \dp /* REPLACED */ ''no.such.access.privilege/* REPLACED */ ''
-- \dP /* REPLACED */ ''no.such.partitioned.relation/* REPLACED */ ''
-- \drds /* REPLACED */ ''no.such.setting/* REPLACED */ ''
-- \dRp /* REPLACED */ ''no.such.publication/* REPLACED */ ''
-- \dRs /* REPLACED */ ''no.such.subscription/* REPLACED */ ''
-- \dT /* REPLACED */ ''no.such.data.type/* REPLACED */ ''
-- \dx /* REPLACED */ ''no.such.installed.extension/* REPLACED */ ''
-- \dX /* REPLACED */ ''no.such.extended.statistics/* REPLACED */ ''
-- \dy /* REPLACED */ ''no.such.event.trigger/* REPLACED */ ''

-- again, but with dotted schema qualifications.
-- \dA /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.access.method/* REPLACED */ ''
-- \dt /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.table.relation/* REPLACED */ ''
-- \da /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.aggregate.function/* REPLACED */ ''
-- \dAc /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.operator.class/* REPLACED */ ''
-- \dAf /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.operator.family/* REPLACED */ ''
-- \dAo /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.operator.of.operator.family/* REPLACED */ ''
-- \dAp /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.operator.support.function.of.operator.family/* REPLACED */ ''
-- \db /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.tablespace/* REPLACED */ ''
-- \dc /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.conversion/* REPLACED */ ''
-- \dC /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.cast/* REPLACED */ ''
-- \dd /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.object.description/* REPLACED */ ''
-- \dD /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.domain/* REPLACED */ ''
-- \ddp /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.default.access.privilege/* REPLACED */ ''
-- \di /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.index.relation/* REPLACED */ ''
-- \dm /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.materialized.view/* REPLACED */ ''
-- \ds /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \dt /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \dv /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \des /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.foreign.server/* REPLACED */ ''
-- \dew /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.foreign.data.wrapper/* REPLACED */ ''
-- \df /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.function/* REPLACED */ ''
-- \dF /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.configuration/* REPLACED */ ''
-- \dFd /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.dictionary/* REPLACED */ ''
-- \dFp /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.parser/* REPLACED */ ''
-- \dFt /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.template/* REPLACED */ ''
-- \dg /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.role/* REPLACED */ ''
-- \dL /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.language/* REPLACED */ ''
-- \do /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.operator/* REPLACED */ ''
-- \dO /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.collation/* REPLACED */ ''
-- \dp /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.access.privilege/* REPLACED */ ''
-- \dP /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.partitioned.relation/* REPLACED */ ''
-- \drds /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.setting/* REPLACED */ ''
-- \dRp /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.publication/* REPLACED */ ''
-- \dRs /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.subscription/* REPLACED */ ''
-- \dT /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.data.type/* REPLACED */ ''
-- \dx /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.installed.extension/* REPLACED */ ''
-- \dX /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.extended.statistics/* REPLACED */ ''
-- \dy /* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.event.trigger/* REPLACED */ ''

-- again, but with current database and dotted schema qualifications.
-- \dt regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.table.relation/* REPLACED */ ''
-- \da regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.aggregate.function/* REPLACED */ ''
-- \dc regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.conversion/* REPLACED */ ''
-- \dC regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.cast/* REPLACED */ ''
-- \dd regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.object.description/* REPLACED */ ''
-- \dD regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.domain/* REPLACED */ ''
-- \di regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.index.relation/* REPLACED */ ''
-- \dm regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.materialized.view/* REPLACED */ ''
-- \ds regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \dt regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \dv regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \df regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.function/* REPLACED */ ''
-- \dF regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.configuration/* REPLACED */ ''
-- \dFd regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.dictionary/* REPLACED */ ''
-- \dFp regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.parser/* REPLACED */ ''
-- \dFt regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.template/* REPLACED */ ''
-- \do regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.operator/* REPLACED */ ''
-- \dO regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.collation/* REPLACED */ ''
-- \dp regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.access.privilege/* REPLACED */ ''
-- \dP regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.partitioned.relation/* REPLACED */ ''
-- \dT regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.data.type/* REPLACED */ ''
-- \dX regression./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.extended.statistics/* REPLACED */ ''

-- again, but with dotted database and dotted schema qualifications.
-- \dt /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.table.relation/* REPLACED */ ''
-- \da /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.aggregate.function/* REPLACED */ ''
-- \dc /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.conversion/* REPLACED */ ''
-- \dC /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.cast/* REPLACED */ ''
-- \dd /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.object.description/* REPLACED */ ''
-- \dD /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.domain/* REPLACED */ ''
-- \ddp /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.default.access.privilege/* REPLACED */ ''
-- \di /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.index.relation/* REPLACED */ ''
-- \dm /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.materialized.view/* REPLACED */ ''
-- \ds /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \dt /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \dv /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.relation/* REPLACED */ ''
-- \df /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.function/* REPLACED */ ''
-- \dF /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.configuration/* REPLACED */ ''
-- \dFd /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.dictionary/* REPLACED */ ''
-- \dFp /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.parser/* REPLACED */ ''
-- \dFt /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.text.search.template/* REPLACED */ ''
-- \do /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.operator/* REPLACED */ ''
-- \dO /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.collation/* REPLACED */ ''
-- \dp /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.access.privilege/* REPLACED */ ''
-- \dP /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.partitioned.relation/* REPLACED */ ''
-- \dT /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.data.type/* REPLACED */ ''
-- \dX /* REPLACED */ ''no.such.database/* REPLACED */ ''./* REPLACED */ ''no.such.schema/* REPLACED */ ''./* REPLACED */ ''no.such.extended.statistics/* REPLACED */ ''

-- check \drg and \du
CREATE ROLE regress_du_role0;
CREATE ROLE regress_du_role1;
CREATE ROLE regress_du_role2;
CREATE ROLE regress_du_admin;

GRANT regress_du_role0 TO regress_du_admin WITH ADMIN TRUE;
GRANT regress_du_role1 TO regress_du_admin WITH ADMIN TRUE;
GRANT regress_du_role2 TO regress_du_admin WITH ADMIN TRUE;

GRANT regress_du_role0 TO regress_du_role1 WITH ADMIN TRUE,  INHERIT TRUE,  SET TRUE  GRANTED BY regress_du_admin;
GRANT regress_du_role0 TO regress_du_role2 WITH ADMIN TRUE,  INHERIT FALSE, SET FALSE GRANTED BY regress_du_admin;
GRANT regress_du_role1 TO regress_du_role2 WITH ADMIN TRUE , INHERIT FALSE, SET TRUE  GRANTED BY regress_du_admin;
GRANT regress_du_role0 TO regress_du_role1 WITH ADMIN FALSE, INHERIT TRUE,  SET FALSE GRANTED BY regress_du_role1;
GRANT regress_du_role0 TO regress_du_role2 WITH ADMIN FALSE, INHERIT TRUE , SET TRUE  GRANTED BY regress_du_role1;
GRANT regress_du_role0 TO regress_du_role1 WITH ADMIN FALSE, INHERIT FALSE, SET TRUE  GRANTED BY regress_du_role2;
GRANT regress_du_role0 TO regress_du_role2 WITH ADMIN FALSE, INHERIT FALSE, SET FALSE GRANTED BY regress_du_role2;

-- \drg regress_du_role*
-- \du regress_du_role*

DROP ROLE regress_du_role0;
DROP ROLE regress_du_role1;
DROP ROLE regress_du_role2;
DROP ROLE regress_du_admin;

-- Test display of empty privileges.
BEGIN;
-- Create an owner for tested objects because output contains owner name.
CREATE ROLE regress_zeropriv_owner;
SET LOCAL ROLE regress_zeropriv_owner;

CREATE DOMAIN regress_zeropriv_domain AS int;
REVOKE ALL ON DOMAIN regress_zeropriv_domain FROM CURRENT_USER, PUBLIC;
-- \dD+ regress_zeropriv_domain

CREATE PROCEDURE regress_zeropriv_proc() LANGUAGE sql AS '';
REVOKE ALL ON PROCEDURE regress_zeropriv_proc() FROM CURRENT_USER, PUBLIC;
-- \df+ regress_zeropriv_proc

CREATE TABLE regress_zeropriv_tbl (a int);
REVOKE ALL ON TABLE regress_zeropriv_tbl FROM CURRENT_USER;
-- \dp regress_zeropriv_tbl

CREATE TYPE regress_zeropriv_type AS (a int);
REVOKE ALL ON TYPE regress_zeropriv_type FROM CURRENT_USER, PUBLIC;
-- \dT+ regress_zeropriv_type

ROLLBACK;

-- Test display of default privileges with \pset null.
CREATE TABLE defprivs (a int);
-- \pset null /* REPLACED */ ''(default)/* REPLACED */ ''
-- \z defprivs
-- \pset null /* REPLACED */ ''/* REPLACED */ ''
DROP TABLE defprivs;
