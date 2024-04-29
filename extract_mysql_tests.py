import os
import shutil
import re
from pathlib import Path

pattern = re.compile(b'[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{6}Z')

mysql_test_path = '/home/stephanie/mysql-server/mysql-test' # TODO
mysql_build_path = '/home/stephanie/mysql-server/build'

temp_path = Path('temp')
temp_path.mkdir(exist_ok=True)

for root, dirs, files in os.walk(mysql_test_path):
    for filename in files:
        filepath = Path(root) / filename
        if filepath.suffix == '.test':
            print(filepath)
            with open(filepath.resolve(), "rb") as f1:
                file_bytes = f1.read();
                log_file_path = temp_path / f"{filepath.stem}.log"
                if not file_bytes.startswith(b'--disable_query_log\nSET GLOBAL log_output'):
                    f2 = open(filepath.resolve(), "wb")
                    f2.write(b"--disable_query_log\n")
                    f2.write(b'SET GLOBAL log_output = "FILE";\n')
                    f2.write((f'SET GLOBAL general_log_file = "{log_file_path.absolute()}";\n').encode())
                    f2.write(b"SET GLOBAL general_log = 'ON';\n")
                    f2.write(file_bytes);
                    f2.close();
            os.system(f"{mysql_build_path}/mysql-test/mysql-test-run {filepath.stem} --fast > /dev/null") # TODO: Ensure it is executed on one thread, log output?
            test_path = Path('mysql_tests') / filepath.stem
            test_path.mkdir(exist_ok=True, parents=True)
            test_path = test_path / 'test.sql'
            test_file = open(test_path.resolve(), 'wb+')
            with open(log_file_path.resolve(), "rb") as f:
                f.readline()
                f.readline()
                f.readline()
                f.readline()
                firstLine = True
                isQuery = False
                l1 = f.readline()
                while True:
                    if not firstLine:
                        l1 = l2
                    if not l1:
                        test_file.write(b";")
                        break
                    l2 = f.readline()
                    if (b"SET SQL_LOG_BIN = 0" in l1 and b"USE mtr" in l2):
                        test_file.write(b";")
                        break
                    split = l1.split(b'\t')
                    if (pattern.match(split[0])):
                        if b'Query' not in split[1]:
                            isQuery = False
                            continue
                        if not firstLine:
                            test_file.write(b';')
                        isQuery = True
                        query = split[2].strip()
                        if not firstLine:
                            test_file.write(b"\n")
                        test_file.write(query)
                    else:
                        if isQuery:
                            test_file.write(b"\n"+split[0].strip())
                    firstLine = False
            test_file.close()
"""                   
for root, dirs, files in os.walk(mysql_test_path):
    for filename in files:
        filepath = Path(root) / filename
        if filepath.suffix == '.result': # ignore '.inc' & '.test', how to split .test for setup.sql

            result_dir_path = Path('mysql_tests') / Path(filename).stem
            result_dir_path.mkdir(parents=True, exist_ok=True)

            shutil.copyfile(filepath.resolve(), (result_dir_path / 'result.txt').resolve()) # TODO Improve result format

            test_file = open((result_dir_path / 'test.sql').resolve(), "wb+")
            
            test_file.close()
"""
# TODO: Remove temp directory
# os.system(f"rm -r {temp_path.absolute()}")
# TODO: Revert files
"""
for root, dirs, files in os.walk(mysql_test_path):
    for filename in files:
        filepath = Path(root) / filename
        if filepath.suffix == '.test':
            with open(filepath.resolve(), "rb") as f1:
                for i in range(5):
                    f1.readline();
                f2 = open(filepath.resolve(), "wb")
                f2.write(f1.read());
                f2.close();
"""