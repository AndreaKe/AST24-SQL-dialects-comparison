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
