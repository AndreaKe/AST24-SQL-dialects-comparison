--
-- FLOAT8
--

--
-- Build a table for testing
-- (This temporarily hides the table created in test_setup.sql)
--

CREATE TEMP TABLE FLOAT8_TBL(f1 float8);

INSERT INTO FLOAT8_TBL(f1) VALUES ('    0.0   ');
INSERT INTO FLOAT8_TBL(f1) VALUES ('1004.30  ');
INSERT INTO FLOAT8_TBL(f1) VALUES ('   -34.84');
INSERT INTO FLOAT8_TBL(f1) VALUES ('1.2345678901234e+200');
INSERT INTO FLOAT8_TBL(f1) VALUES ('1.2345678901234e-200');

-- test for underflow and overflow handling
SELECT '10e400'::float8;
SELECT '-10e400'::float8;
SELECT '10e-400'::float8;
SELECT '-10e-400'::float8;

-- bad input
INSERT INTO FLOAT8_TBL(f1) VALUES ('');
INSERT INTO FLOAT8_TBL(f1) VALUES ('     ');
INSERT INTO FLOAT8_TBL(f1) VALUES ('xyz');
INSERT INTO FLOAT8_TBL(f1) VALUES ('5.0.0');
INSERT INTO FLOAT8_TBL(f1) VALUES ('5 . 0');
INSERT INTO FLOAT8_TBL(f1) VALUES ('5.   0');
INSERT INTO FLOAT8_TBL(f1) VALUES ('    - 3');
INSERT INTO FLOAT8_TBL(f1) VALUES ('123           5');

-- Also try it with non-error-throwing API
SELECT pg_input_is_valid('34.5', 'float8');
SELECT pg_input_is_valid('xyz', 'float8');
SELECT pg_input_is_valid('1e4000', 'float8');
SELECT * FROM pg_input_error_info('1e4000', 'float8');

-- special inputs
SELECT 'NaN'::float8;
SELECT 'nan'::float8;
SELECT '   NAN  '::float8;
SELECT 'infinity'::float8;
SELECT '          -INFINiTY   '::float8;
-- bad special inputs
SELECT 'N A N'::float8;
SELECT 'NaN x'::float8;
SELECT ' INFINITY    x'::float8;

SELECT 'Infinity'::float8 + 100.0;
SELECT 'Infinity'::float8 / 'Infinity'::float8;
SELECT '42'::float8 / 'Infinity'::float8;
SELECT 'nan'::float8 / 'nan'::float8;
SELECT 'nan'::float8 / '0'::float8;
SELECT 'nan'::numeric::float8;

SELECT * FROM FLOAT8_TBL;

SELECT f.* FROM FLOAT8_TBL f WHERE f.f1 <> '1004.3';

SELECT f.* FROM FLOAT8_TBL f WHERE f.f1 = '1004.3';

SELECT f.* FROM FLOAT8_TBL f WHERE '1004.3' > f.f1;

SELECT f.* FROM FLOAT8_TBL f WHERE  f.f1 < '1004.3';

SELECT f.* FROM FLOAT8_TBL f WHERE '1004.3' >= f.f1;

SELECT f.* FROM FLOAT8_TBL f WHERE  f.f1 <= '1004.3';

SELECT f.f1, f.f1 * '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';

SELECT f.f1, f.f1 + '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';

SELECT f.f1, f.f1 / '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';

SELECT f.f1, f.f1 - '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';

SELECT f.f1 ^ '2.0' AS square_f1
   FROM FLOAT8_TBL f where f.f1 = '1004.3';

-- absolute value
SELECT f.f1, @f.f1 AS abs_f1
   FROM FLOAT8_TBL f;

-- truncate
SELECT f.f1, trunc(f.f1) AS trunc_f1
   FROM FLOAT8_TBL f;

-- round
SELECT f.f1, round(f.f1) AS round_f1
   FROM FLOAT8_TBL f;

-- ceil / ceiling
select ceil(f1) as ceil_f1 from float8_tbl f;
select ceiling(f1) as ceiling_f1 from float8_tbl f;

-- floor
select floor(f1) as floor_f1 from float8_tbl f;

-- sign
select sign(f1) as sign_f1 from float8_tbl f;

-- avoid bit-exact output here because operations may not be bit-exact.
SET extra_float_digits = 0;

-- square root
SELECT sqrt(float8 '64') AS eight;

SELECT |/ float8 '64' AS eight;

SELECT f.f1, |/f.f1 AS sqrt_f1
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';

-- power
SELECT power(float8 '144', float8 '0.5');
SELECT power(float8 'NaN', float8 '0.5');
SELECT power(float8 '144', float8 'NaN');
SELECT power(float8 'NaN', float8 'NaN');
SELECT power(float8 '-1', float8 'NaN');
SELECT power(float8 '1', float8 'NaN');
SELECT power(float8 'NaN', float8 '0');
SELECT power(float8 'inf', float8 '0');
SELECT power(float8 '-inf', float8 '0');
SELECT power(float8 '0', float8 'inf');
SELECT power(float8 '0', float8 '-inf');
SELECT power(float8 '1', float8 'inf');
SELECT power(float8 '1', float8 '-inf');
SELECT power(float8 '-1', float8 'inf');
SELECT power(float8 '-1', float8 '-inf');
SELECT power(float8 '0.1', float8 'inf');
SELECT power(float8 '-0.1', float8 'inf');
SELECT power(float8 '1.1', float8 'inf');
SELECT power(float8 '-1.1', float8 'inf');
SELECT power(float8 '0.1', float8 '-inf');
SELECT power(float8 '-0.1', float8 '-inf');
SELECT power(float8 '1.1', float8 '-inf');
SELECT power(float8 '-1.1', float8 '-inf');
SELECT power(float8 'inf', float8 '-2');
SELECT power(float8 'inf', float8 '2');
SELECT power(float8 'inf', float8 'inf');
SELECT power(float8 'inf', float8 '-inf');
-- Intel/* REPLACED */ ''s icc misoptimizes the code that controls the sign of this result,
-- even with -mp1.  Pending a fix for that, only test for /* REPLACED */ ''is it zero/* REPLACED */ ''.
SELECT power(float8 '-inf', float8 '-2') = '0';
SELECT power(float8 '-inf', float8 '-3');
SELECT power(float8 '-inf', float8 '2');
SELECT power(float8 '-inf', float8 '3');
SELECT power(float8 '-inf', float8 '3.5');
SELECT power(float8 '-inf', float8 'inf');
SELECT power(float8 '-inf', float8 '-inf');

-- take exp of ln(f.f1)
SELECT f.f1, exp(ln(f.f1)) AS exp_ln_f1
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';

-- check edge cases for exp
SELECT exp('inf'::float8), exp('-inf'::float8), exp('nan'::float8);

-- cube root
SELECT ||/ float8 '27' AS three;

SELECT f.f1, ||/f.f1 AS cbrt_f1 FROM FLOAT8_TBL f;


SELECT * FROM FLOAT8_TBL;

UPDATE FLOAT8_TBL
   SET f1 = FLOAT8_TBL.f1 * '-1'
   WHERE FLOAT8_TBL.f1 > '0.0';

SELECT f.f1 * '1e200' from FLOAT8_TBL f;

SELECT f.f1 ^ '1e200' from FLOAT8_TBL f;

SELECT 0 ^ 0 + 0 ^ 1 + 0 ^ 0.0 + 0 ^ 0.5;

SELECT ln(f.f1) from FLOAT8_TBL f where f.f1 = '0.0' ;

SELECT ln(f.f1) from FLOAT8_TBL f where f.f1 < '0.0' ;

SELECT exp(f.f1) from FLOAT8_TBL f;

SELECT f.f1 / '0.0' from FLOAT8_TBL f;

SELECT * FROM FLOAT8_TBL;

-- hyperbolic functions
-- we run these with extra_float_digits = 0 too, since different platforms
-- tend to produce results that vary in the last place.
SELECT sinh(float8 '1');
SELECT cosh(float8 '1');
SELECT tanh(float8 '1');
SELECT asinh(float8 '1');
SELECT acosh(float8 '2');
SELECT atanh(float8 '0.5');
-- test Inf/NaN cases for hyperbolic functions
SELECT sinh(float8 'infinity');
SELECT sinh(float8 '-infinity');
SELECT sinh(float8 'nan');
SELECT cosh(float8 'infinity');
SELECT cosh(float8 '-infinity');
SELECT cosh(float8 'nan');
SELECT tanh(float8 'infinity');
SELECT tanh(float8 '-infinity');
SELECT tanh(float8 'nan');
SELECT asinh(float8 'infinity');
SELECT asinh(float8 '-infinity');
SELECT asinh(float8 'nan');
-- acosh(Inf) should be Inf, but some mingw versions produce NaN, so skip test
-- SELECT acosh(float8 /* REPLACED */ ''infinity/* REPLACED */ '') /* REPLACED */ ,
SELECT acosh(float8 '-infinity');
SELECT acosh(float8 'nan');
SELECT atanh(float8 'infinity');
SELECT atanh(float8 '-infinity');
SELECT atanh(float8 'nan');

-- error functions
-- we run these with extra_float_digits = -1, to get consistently rounded
-- results on all platforms.
SET extra_float_digits = -1;
SELECT x,
       erf(x),
       erfc(x)
FROM (VALUES (float8 '-infinity'),
      (-28), (-6), (-3.4), (-2.1), (-1.1), (-0.45),
      (-1.2e-9), (-2.3e-13), (-1.2e-17), (0),
      (1.2e-17), (2.3e-13), (1.2e-9),
      (0.45), (1.1), (2.1), (3.4), (6), (28),
      (float8 'infinity'), (float8 'nan')) AS t(x);

RESET extra_float_digits;

-- test for over- and underflow
INSERT INTO FLOAT8_TBL(f1) VALUES ('10e400');

INSERT INTO FLOAT8_TBL(f1) VALUES ('-10e400');

INSERT INTO FLOAT8_TBL(f1) VALUES ('10e-400');

INSERT INTO FLOAT8_TBL(f1) VALUES ('-10e-400');

DROP TABLE FLOAT8_TBL;

-- Check the float8 values exported for use by other tests

SELECT * FROM FLOAT8_TBL;

-- test edge-case coercions to integer
SELECT '32767.4'::float8::int2;
SELECT '32767.6'::float8::int2;
SELECT '-32768.4'::float8::int2;
SELECT '-32768.6'::float8::int2;
SELECT '2147483647.4'::float8::int4;
SELECT '2147483647.6'::float8::int4;
SELECT '-2147483648.4'::float8::int4;
SELECT '-2147483648.6'::float8::int4;
SELECT '9223372036854773760'::float8::int8;
SELECT '9223372036854775807'::float8::int8;
SELECT '-9223372036854775808.5'::float8::int8;
SELECT '-9223372036854780000'::float8::int8;

-- test exact cases for trigonometric functions in degrees

SELECT x,
       sind(x),
       sind(x) IN (-1,-0.5,0,0.5,1) AS sind_exact
FROM (VALUES (0), (30), (90), (150), (180),
      (210), (270), (330), (360)) AS t(x);

SELECT x,
       cosd(x),
       cosd(x) IN (-1,-0.5,0,0.5,1) AS cosd_exact
FROM (VALUES (0), (60), (90), (120), (180),
      (240), (270), (300), (360)) AS t(x);

SELECT x,
       tand(x),
       tand(x) IN ('-Infinity'::float8,-1,0,
                   1,'Infinity'::float8) AS tand_exact,
       cotd(x),
       cotd(x) IN ('-Infinity'::float8,-1,0,
                   1,'Infinity'::float8) AS cotd_exact
FROM (VALUES (0), (45), (90), (135), (180),
      (225), (270), (315), (360)) AS t(x);

SELECT x,
       asind(x),
       asind(x) IN (-90,-30,0,30,90) AS asind_exact,
       acosd(x),
       acosd(x) IN (0,60,90,120,180) AS acosd_exact
FROM (VALUES (-1), (-0.5), (0), (0.5), (1)) AS t(x);

SELECT x,
       atand(x),
       atand(x) IN (-90,-45,0,45,90) AS atand_exact
FROM (VALUES ('-Infinity'::float8), (-1), (0), (1),
      ('Infinity'::float8)) AS t(x);

SELECT x, y,
       atan2d(y, x),
       atan2d(y, x) IN (-90,0,90,180) AS atan2d_exact
FROM (SELECT 10*cosd(a), 10*sind(a)
      FROM generate_series(0, 360, 90) AS t(a)) AS t(x,y);

--
-- test output (and round-trip safety) of various values.
-- To ensure we/* REPLACED */ ''re testing what we think we/* REPLACED */ ''re testing, start with
-- float values specified by bit patterns (as a useful side effect,
-- this means we/* REPLACED */ ''ll fail on non-IEEE platforms).

create type xfloat8;
create function xfloat8in(cstring) returns xfloat8 immutable strict
  language internal as 'int8in';
create function xfloat8out(xfloat8) returns cstring immutable strict
  language internal as 'int8out';
create type xfloat8 (input = xfloat8in, output = xfloat8out, like = float8);
create cast (xfloat8 as float8) without function;
create cast (float8 as xfloat8) without function;
create cast (xfloat8 as bigint) without function;
create cast (bigint as xfloat8) without function;

-- clean up, lest opr_sanity complain
drop type xfloat8 cascade;
