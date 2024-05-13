import os
import re
from pathlib import Path

timestamp_pattern = re.compile(b'[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{6}Z')

logfile_first_line_pattern = re.compile(b'^/.*/mysqld, Version: 8.0.36 \(Source distribution\). started with:$')
logfile_second_line_pattern = re.compile(b'^Tcp port: [0-9]+  Unix socket.*$')
logfile_third_line_pattern = re.compile(b'^Time[\s]*Id[\s]*Command[\s]*Argument$')

set_general_log_file_off_pattern = re.compile(b"^.*SET\sGLOBAL\sgeneral_log.*=.*'OFF'.*$", re.IGNORECASE)

wait_until_connected_pattern = re.compile(b"^--source include/(wait_until_connected_again|.*start.*).inc$")

mysql_test_path = '/home/stephanie/mysql-server/mysql-test/t' # TODO Only from /t, which suites to include?
mysql_build_path = '/home/stephanie/mysql-server/build'

temp_path = Path('temp_mysql')
temp_path.mkdir(exist_ok=True)

failed_file = open('failed.txt', 'w+')
failed_file.write('Extraction failed:\n')

def isBeginningOfLogFile(l):
    return logfile_first_line_pattern.match(l) \
        or logfile_second_line_pattern.match(l) \
        or logfile_third_line_pattern.match(l)

def getNextLine(f, currLine):
    l = f.readline()
    while l and b"@@" in l or isBeginningOfLogFile(l) or re.match(b'.*Query\t\n$', l, re.DOTALL):
        l = f.readline()
    if b'shutdown' in currLine:
        return getNextLine(f, l) # two shutdowns after each other does not make sense
    return l

for root, dirs, files in os.walk(mysql_test_path):
    for filename in files:
        filepath = Path(root) / filename
        if filepath.suffix == '.test' and filename != 'check-testcase.test' and filename == 'invalid_collation.test':  # TODO: remove
            print(filepath)
            with open(filepath.resolve(), "rb") as f1:
                file_bytes_lines = f1.readlines()
                log_file_path = temp_path / f"{filepath.stem}.log"
                if not file_bytes_lines[0].startswith(b'--disable_query_log\nSET GLOBAL log_output'):
                    f2 = open(filepath.resolve(), "wb")
                    f2.write(b'--disable_query_log\n')
                    f2.write(b'SET GLOBAL log_output = "FILE";\n')
                    f2.write((f'SET GLOBAL general_log_file = "{log_file_path.absolute()}";\n').encode())
                    f2.write(b"SET GLOBAL general_log = 'ON';\n")
                    for l in file_bytes_lines:
                        if set_general_log_file_off_pattern.match(l) \
                            or l.startswith(b"--remove_file"):
                            continue
                        l = re.sub(b"'[^\s]+.log'", (f"'{log_file_path.absolute()}'").encode(), l)
                        f2.write(l)
                        if wait_until_connected_pattern.match(l):
                            f2.write(b"--disable_query_log\n")
                            f2.write(b'SET GLOBAL log_output = "FILE";\n')
                            f2.write((f'SET GLOBAL general_log_file = "{log_file_path.absolute()}";\n').encode())
                            f2.write(b"SET GLOBAL general_log = 'ON';\n")
                    f2.close()
            os.system(f"{mysql_build_path}/mysql-test/mysql-test-run {filepath.stem} --fast > /dev/null") #   TODO: Ensure it is executed on one thread, log output?
            test_path = Path('mysql_tests') / filepath.stem
            test_path.mkdir(exist_ok=True, parents=True)
            test_path = test_path / 'test.sql'
            test_file = open(test_path.resolve(), 'wb+')
            try:
                with open(log_file_path.resolve(), "rb") as f:
                    f.readline()
                    f.readline()
                    f.readline()
                    f.readline()
                    firstLine = True
                    query = None
                    l0 = b""
                    l1 = getNextLine(f, l0)
                    if l1:
                        l2 = getNextLine(f, l1)
                    while True:
                        if not firstLine:
                            l0 = l1
                            l1 = l2
                            l2 = l3
                        print("l0: ")
                        print(l0)
                        print("\n")
                        print("l1: ")
                        print(l1)
                        print("\n")
                        print("l2: ")
                        print(l2)
                        print("\n")
                        if not l1:
                            test_file.write(b";")
                            print("1")
                            break
                        if l2:
                            l3 = getNextLine(f, l2)
                            print("l3: ")
                            print(l3)
                            print("\n")
                        if b"SET SQL_LOG_BIN = 0" in l1.upper() \
                            and (b"USE mtr" in l2 or b"use mtr" in l2):
                            print("2")
                            break
                        if b"SHOW WARNINGS" in l1.upper() and b"Quit" in l2 and not l3: # b"DROP" in l0 and 
                            print("HERE")
                            test_file.write(b"\n"+l0.split(b'\t')[2].strip()+b";")
                            print("3")
                            break
                        split = l1.split(b'\t')
                        if (timestamp_pattern.match(split[0])):
                            if not firstLine and query:
                                print("HERE2222222")
                                test_file.write(query + b';')
                            if b'Query' not in split[1]:
                                query = None
                                continue
                            query = split[2].strip()
                            if re.match(b"^[\s]*$", query):
                                query = None
                                continue
                            if not firstLine:
                                query = b"\n" + query;
                        else:
                            if query:
                                query += b"\n"+split[0].strip()
                        firstLine = False
            except Exception as e:
                print(e)
                failed_file.write(f"{filepath.resolve()}\n")
            test_file.close()
failed_file.close()

"""
# TODO: This might be faster, why does it not work?
print("UPDATING TEST CASES")
for root, dirs, files in os.walk(mysql_test_path):
    for filename in files:
        filepath = Path(root) / filename
        if filepath.suffix == '.test':
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

print('RUN TESTS')
os.system(f"{mysql_build_path}/mysql-test/mysql-test-run --skip-combinations") # --fast  TODO: Ensure it is executed on one thread, log output, skip-combinations (maybe for the suites we select, anyway no combinations, TODO check, argumentation), > /dev/null?

print("EXTRACT TESTS FROM LOGS")
for lf in temp_path.iterdir():
    print(lf)
    test_path = Path('mysql_tests') / filepath.stem
    test_path.mkdir(exist_ok=True, parents=True)
    test_path = test_path / 'test.sql'
    test_file = open(test_path.resolve(), 'wb+')
    with open(lf, "rb") as f:
        f.readline()
        f.readline()
        f.readline()
        f.readline()
        firstLine = True
        query = None
        l0 = b""
        l1 = f.readline()
        if l1:
            l2 = f.readline()
        while True:
            if not firstLine:
                l0 = l1
                l1 = l2
                l2 = l3
            if not l1:
                test_file.write(b";")
                break
            if l2:
                l3 = f.readline()
            if b"SET SQL_LOG_BIN = 0" in l1 and b"USE mtr" in l2:
                break
            if b"DROP" in l0 and b"SHOW WARNINGS" in l1 and b"Quit" in l2 and not l3:
                test_file.write(b"\n"+l0+";")
                break
            split = l1.split(b'\t')
            if (pattern.match(split[0])):
                if not firstLine and (query and not b"@@" in query):
                    test_file.write(query + b';')
                if b'Query' not in split[1]:
                    query = None
                    continue
                query = split[2].strip()
                if not firstLine:
                    query = b"\n" + query;
            else:
                if query:
                    query += b"\n"+split[0].strip()
            firstLine = False
    test_file.close()
"""
# TODO: Remove temp directory
# os.system(f"rm -r {temp_path.absolute()}")
"""
# TODO: Revert files
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