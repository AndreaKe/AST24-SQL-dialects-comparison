--
-- FLOAT4
--

CREATE TABLE FLOAT4_TBL (f1  float4);

INSERT INTO FLOAT4_TBL(f1) VALUES ('    0.0');
INSERT INTO FLOAT4_TBL(f1) VALUES ('1004.30   ');
INSERT INTO FLOAT4_TBL(f1) VALUES ('     -34.84    ');
INSERT INTO FLOAT4_TBL(f1) VALUES ('1.2345678901234e+20');
INSERT INTO FLOAT4_TBL(f1) VALUES ('1.2345678901234e-20');

-- test for over and under flow
INSERT INTO FLOAT4_TBL(f1) VALUES ('10e70');
INSERT INTO FLOAT4_TBL(f1) VALUES ('-10e70');
INSERT INTO FLOAT4_TBL(f1) VALUES ('10e-70');
INSERT INTO FLOAT4_TBL(f1) VALUES ('-10e-70');

INSERT INTO FLOAT4_TBL(f1) VALUES ('10e70'::float8);
INSERT INTO FLOAT4_TBL(f1) VALUES ('-10e70'::float8);
INSERT INTO FLOAT4_TBL(f1) VALUES ('10e-70'::float8);
INSERT INTO FLOAT4_TBL(f1) VALUES ('-10e-70'::float8);

INSERT INTO FLOAT4_TBL(f1) VALUES ('10e400');
INSERT INTO FLOAT4_TBL(f1) VALUES ('-10e400');
INSERT INTO FLOAT4_TBL(f1) VALUES ('10e-400');
INSERT INTO FLOAT4_TBL(f1) VALUES ('-10e-400');

-- bad input
INSERT INTO FLOAT4_TBL(f1) VALUES ('');
INSERT INTO FLOAT4_TBL(f1) VALUES ('       ');
INSERT INTO FLOAT4_TBL(f1) VALUES ('xyz');
INSERT INTO FLOAT4_TBL(f1) VALUES ('5.0.0');
INSERT INTO FLOAT4_TBL(f1) VALUES ('5 . 0');
INSERT INTO FLOAT4_TBL(f1) VALUES ('5.   0');
INSERT INTO FLOAT4_TBL(f1) VALUES ('     - 3.0');
INSERT INTO FLOAT4_TBL(f1) VALUES ('123            5');

-- Also try it with non-error-throwing API
SELECT pg_input_is_valid('34.5', 'float4');
SELECT pg_input_is_valid('xyz', 'float4');
SELECT pg_input_is_valid('1e400', 'float4');
SELECT * FROM pg_input_error_info('1e400', 'float4');

-- special inputs
SELECT 'NaN'::float4;
SELECT 'nan'::float4;
SELECT '   NAN  '::float4;
SELECT 'infinity'::float4;
SELECT '          -INFINiTY   '::float4;
-- bad special inputs
SELECT 'N A N'::float4;
SELECT 'NaN x'::float4;
SELECT ' INFINITY    x'::float4;

SELECT 'Infinity'::float4 + 100.0;
SELECT 'Infinity'::float4 / 'Infinity'::float4;
SELECT '42'::float4 / 'Infinity'::float4;
SELECT 'nan'::float4 / 'nan'::float4;
SELECT 'nan'::float4 / '0'::float4;
SELECT 'nan'::numeric::float4;

SELECT * FROM FLOAT4_TBL;

SELECT f.* FROM FLOAT4_TBL f WHERE f.f1 <> '1004.3';

SELECT f.* FROM FLOAT4_TBL f WHERE f.f1 = '1004.3';

SELECT f.* FROM FLOAT4_TBL f WHERE '1004.3' > f.f1;

SELECT f.* FROM FLOAT4_TBL f WHERE  f.f1 < '1004.3';

SELECT f.* FROM FLOAT4_TBL f WHERE '1004.3' >= f.f1;

SELECT f.* FROM FLOAT4_TBL f WHERE  f.f1 <= '1004.3';

SELECT f.f1, f.f1 * '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0';

SELECT f.f1, f.f1 + '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0';

SELECT f.f1, f.f1 / '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0';

SELECT f.f1, f.f1 - '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0';

-- test divide by zero
SELECT f.f1 / '0.0' from FLOAT4_TBL f;

SELECT * FROM FLOAT4_TBL;

-- test the unary float4abs operator
SELECT f.f1, @f.f1 AS abs_f1 FROM FLOAT4_TBL f;

UPDATE FLOAT4_TBL
   SET f1 = FLOAT4_TBL.f1 * '-1'
   WHERE FLOAT4_TBL.f1 > '0.0';

SELECT * FROM FLOAT4_TBL;

-- test edge-case coercions to integer
SELECT '32767.4'::float4::int2;
SELECT '32767.6'::float4::int2;
SELECT '-32768.4'::float4::int2;
SELECT '-32768.6'::float4::int2;
SELECT '2147483520'::float4::int4;
SELECT '2147483647'::float4::int4;
SELECT '-2147483648.5'::float4::int4;
SELECT '-2147483900'::float4::int4;
SELECT '9223369837831520256'::float4::int8;
SELECT '9223372036854775807'::float4::int8;
SELECT '-9223372036854775808.5'::float4::int8;
SELECT '-9223380000000000000'::float4::int8;

-- test output (and round-trip safety) of various values.
-- To ensure we/* REPLACED */ ''re testing what we think we/* REPLACED */ ''re testing, start with
-- float values specified by bit patterns (as a useful side effect,
-- this means we/* REPLACED */ ''ll fail on non-IEEE platforms).

create type xfloat4;
create function xfloat4in(cstring) returns xfloat4 immutable strict
  language internal as 'int4in';
create function xfloat4out(xfloat4) returns cstring immutable strict
  language internal as 'int4out';
create type xfloat4 (input = xfloat4in, output = xfloat4out, like = float4);
create cast (xfloat4 as float4) without function;
create cast (float4 as xfloat4) without function;
create cast (xfloat4 as integer) without function;
create cast (integer as xfloat4) without function;

-- clean up, lest opr_sanity complain
drop type xfloat4 cascade;
