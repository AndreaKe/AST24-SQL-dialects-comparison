SHOW VARIABLES LIKE 'character_sets_dir%';
SHOW COLLATION LIKE 'utf8_phone_ci';
CREATE TABLE t1 (i INTEGER, a VARCHAR(10) COLLATE utf8_phone_ci) COLLATE utf8_phone_ci;
SHOW WARNINGS;
CREATE TABLE t2 (i INTEGER, a VARCHAR(10) COLLATE utf8_phone_ci) COLLATE utf8_phone_ci;
SHOW WARNINGS;
SHOW VARIABLES LIKE 'pid_file';
SHOW VARIABLES LIKE 'core_file';
SHOW VARIABLES LIKE 'datadir';
shutdown;

/home/stephanie/mysql-server/build/runtime_output_directory/mysqld, Version: 8.0.36 (Source distribution). started with:
Tcp port: 13000  Unix socket: /home/stephanie/mysql-server/build/mysql-test/var/tmp/mysqld.1.sock
Time                 Id Command    Argument;
SET GLOBAL general_log = 'ON';
SHOW VARIABLES LIKE 'character_sets_dir%';
SHOW COLLATION LIKE 'utf8_phone_ci';
CREATE TABLE t1 (i INTEGER, a VARCHAR(10) COLLATE utf8_phone_ci) COLLATE utf8_phone_ci;
SHOW WARNINGS;
CREATE TABLE t2 (i INTEGER, a VARCHAR(10) COLLATE utf8_phone_ci) COLLATE utf8_phone_ci;
SHOW WARNINGS;
SHOW VARIABLES LIKE 'pid_file';
SHOW VARIABLES LIKE 'core_file';
SHOW VARIABLES LIKE 'datadir';
shutdown;;