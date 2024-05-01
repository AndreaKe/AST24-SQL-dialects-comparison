
UNINSTALL PLUGIN example;
SELECT PLUGIN_NAME, PLUGIN_STATUS, LOAD_OPTION FROM INFORMATION_SCHEMA.PLUGINS
WHERE PLUGIN_NAME IN ('MyISAM', 'EXAMPLE');
SET GLOBAL log_output = "FILE";
SET GLOBAL general_log_file = "/home/stephanie/Dokumente/a/AST/AST24-SQL-dialects-comparison/temp_mysql/check-warnings.log"
/home/stephanie/mysql-server/build/runtime_output_directory/mysqld, Version: 8.0.36 (Source distribution). started with:
Tcp port: 13000  Unix socket: /home/stephanie/mysql-server/build/mysql-test/var/tmp/mysqld.1.sock
Time                 Id Command    Argument;
SET GLOBAL general_log = 'ON';
UNINSTALL PLUGIN example;
SELECT PLUGIN_NAME, PLUGIN_STATUS, LOAD_OPTION FROM INFORMATION_SCHEMA.PLUGINS
WHERE PLUGIN_NAME IN ('MyISAM', 'EXAMPLE');
SET GLOBAL log_output = "FILE";;