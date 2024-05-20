import os
import re
import argparse
from pathlib import Path

SKIP_EXISTING = True
MYSQL_TEST_SUITE_PATH = (Path.home() / 'mysql-server/mysql-test/t').absolute()
MYSQL_BUILD_PATH = (Path.home() / 'mysql-server/build').absolute()

timestamp_pattern = re.compile(b'[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{6}Z')

logfile_first_line_pattern = re.compile(b'^/.*/mysqld, Version: 8.0.36 \(Source distribution\). started with:$')
logfile_second_line_pattern = re.compile(b'^Tcp port: [0-9]+  Unix socket.*$')
logfile_third_line_pattern = re.compile(b'^Time[\s]*Id[\s]*Command[\s]*Argument$')

set_general_log_file_off_pattern = re.compile(b"^.*SET\sGLOBAL\sgeneral_log.*=.*(\"|')OFF(\"|').*$", re.IGNORECASE)
set_general_log_output_table_pattern = re.compile(b"^.*SET\sGLOBAL\slog_output.*=.*(\"|')TABLE(\"|').*$", re.IGNORECASE)

wait_until_connected_pattern = re.compile(b"^--source include/(wait_until_connected_again|.*start.*).inc$")

def isIncludedTestCase(filename):
    return filename != 'check-testcase.test' and filename != 'windows_myisam.test' \
        and filename != 'shm.test'

def isBeginningOfLogFile(l):
    return logfile_first_line_pattern.match(l) \
        or logfile_second_line_pattern.match(l) \
        or logfile_third_line_pattern.match(l)

def getNextLine(f, currLine):
    l = f.readline()
    if b'SELECT "2024_AST_LET"' in l:
        l = f.readline()
        l = f.readline()
    isLet = b'SELECT "2024_AST_LET"' in l
    while l and  (isBeginningOfLogFile(l) \
        or re.match(b'.*Query\t$', l) \
        or b"Query\tSHOW" in l or b"Query\tshow" in l \
        or isLet \
        or b"Connect\t" in l):
        l = f.readline()
        if isLet:
            l = f.readline()
        isLet = b'SELECT "2024_AST_LET"' in l
    if b'SELECT "2024_AST_SHOW"' in l:
        return f.readline()
    if b'SELECT "2024_AST_LOG_OUTPUT_TABLE' in l:
        l = f.readLine()
        l = l.replace(b'"TABLE,FILE"', b'TABLE')
        return l
    if b'SELECT "2024_AST_GENERAL_LOG_OFF' in l:
        l = l.replace(b'SELECT "2024_AST_GENERAL_LOG_OFF"', b'SET GLOBAL general_log="OFF"')
        return l
    if b'shutdown' in currLine:
        return getNextLine(f, l) # two shutdowns after each other does not make sense
    return l

parser = argparse.ArgumentParser()
parser.add_argument("-MYSQL_TEST_SUITE_PATH", 
                    help="path to mySQL test suite folder",
                    default= (Path.home() / 'mysql-server/mysql-test/t').absolute(),
                    required=False,
                    type=str)
parser.add_argument("-MYSQL_BUILD_PATH", 
                    default= (Path.home() / 'mysql-server/build').absolute(),
                    help="mySQL build path",
                    required=False,
                    type=str)
parser.add_argument('-dont_skip_existing',
                    action='store_false')
args = parser.parse_args()
MYSQL_TEST_SUITE_PATH = args.MYSQL_TEST_SUITE_PATH
MYSQL_BUILD_PATH = args.MYSQL_BUILD_PATH
SKIP_EXISTING = args.dont_skip_existing

temp_path = Path('temp_mysql')
temp_path.mkdir(exist_ok=True)

failed_file = open(f'failed.txt', 'w+')
failed_file.write('Extraction failed:\n')

total_num_tests = 0
for root, dirs, files in os.walk(MYSQL_TEST_SUITE_PATH):
    for filename in files:
        filepath = Path(root) / filename
        if filepath.suffix == '.test' and isIncludedTestCase(filename):
            total_num_tests += 1

test_num = 0
print(MYSQL_TEST_SUITE_PATH)
for root, dirs, files in os.walk(MYSQL_TEST_SUITE_PATH):
    for filename in files:
        filepath = Path(root) / filename
        test_path = Path('mysql_tests') / filepath.stem
        if SKIP_EXISTING and test_path.exists():
            test_num += 1
            continue
        if filepath.suffix == '.test' and isIncludedTestCase(filename):
            # and filename == 'all_persisted_variables.test': # TODO
            print(filepath)
            test_num += 1
            print(f"Extracting test ({test_num}\{total_num_tests})")
            with open(filepath.resolve(), "rb") as f1:
                file_bytes_lines = f1.readlines()
                log_file_path = temp_path / f"{filepath.stem}.log"
                prepend_lines = [b'SET GLOBAL log_output = "FILE";\n', \
                            (f'SET GLOBAL general_log_file = "{log_file_path.absolute()}";\n').encode(), \
                            b"SET GLOBAL general_log = 'ON';\n", \
                            b'SELECT "2024_automated_software_testing";\n']
                if len(file_bytes_lines) < 4 \
                    or not file_bytes_lines[3].startswith(b'SELECT "2024_automated_software_testing"'):
                    f2 = open(filepath.resolve(), "wb")
                    f2.writelines(prepend_lines)
                    prev_line = b""
                    oldCheckIsError = False
                    for l in file_bytes_lines:
                        if set_general_log_file_off_pattern.match(l):
                            f2.write(b'SELECT "2024_AST_GENERAL_LOG_OFF";\n')
                            oldCheckIsError = False
                            prev_line = l
                            continue
                        if l.startswith(b"--remove_file"):
                            prev_line=l
                            oldCheckIsError = False
                            continue
                        if l.startswith(b"--error"):
                            prev_line=l
                            oldCheckIsError = True
                            continue
                        l = re.sub(b"\$MYSQLTEST_VARDIR/[^\s]+.log", (f"{log_file_path.absolute()}").encode(), l)
                        if set_general_log_output_table_pattern.match(l):
                            f2.write(b'SELECT "2024_AST_LOG_OUTPUT_TABLE";\n')
                            l = b"SET GLOBAL log_output= \"TABLE,FILE\";"
                        if l.startswith(b"SHOW") or l.startswith(b"show"):
                            f2.write(b'SELECT "2024_AST_SHOW";\n')
                        if l.startswith(b"LET") or l.startswith(b"let"):
                            f2.write(b'SELECT "2024_AST_LET";\n')
                        if oldCheckIsError:
                            f2.write(prev_line)
                        f2.write(l)
                        if wait_until_connected_pattern.match(l):
                            f2.writelines(prepend_lines[:-1])
                        oldCheckIsError = False
                        prev_line=l
                    f2.close()
            os.system(f"{MYSQL_BUILD_PATH}/mysql-test/mysql-test-run {filepath.stem} --fast > /dev/null") #     TODO: Ensure it is executed on one thread, log output?
            test_path.mkdir(exist_ok=True, parents=True)
            setup_path = test_path / 'setup.sql'
            with open(setup_path.resolve(), 'wb+') as setup_f:
                pass
            test_path = test_path / 'test.sql'
            test_file = open(test_path.resolve(), 'wb+')
            try:
                with open(log_file_path.resolve(), "rb") as f:
                    f.readline()
                    f.readline()
                    f.readline()
                    b1 = f.readline()
                    b2 = f.readline()
                    if prepend_lines[-2][:-2] not in b1 or prepend_lines[-1][:-2] not in b2:
                        raise Exception('Test is skipped')
                    i = 0
                    query = None
                    l0 = b""
                    l1 = getNextLine(f, l0)
                    if l1:
                        l2 = getNextLine(f, l1)
                    while l1 or l2:
                        i += 1
                        if i > 1:
                            ##print(("Inside swap")
                            l0 = l1
                            l1 = l2
                            l2 = l3
                        #print("l0: ")
                        #print(l0)
                        #print("\n")
                        #print("l1: ")
                        #print(l1)
                        #print("\n")
                        #print("l2: ")
                        #print(l2)
                        #print("\n")
                        if l2:
                            l3 = getNextLine(f, l2)
                            #print("l3: ")
                            #print(l3)
                            #print("\n")
                        if b"SET SQL_LOG_BIN = 0" in l1.upper() \
                            and (b"USE mtr" in l2 or b"use mtr" in l2):
                            #print("2")
                            break
                        split = l1.split(b'\t')
                        if (timestamp_pattern.match(split[0])):
                            if i>1 and query:
                                #print(query)
                                #print("HERE2222222")
                                test_file.write(query + b';')
                            if b'Query' not in split[1]:
                                query = None
                                continue
                            query = split[2].strip()
                            if re.match(b"^[\s]*$", query):
                                query = None
                                continue
                            if i>1:
                                query = b"\n" + query;
                        else:
                            if query:
                                query += b"\n"+split[0].strip()
            except Exception as e:
                os.remove(setup_path.resolve())
                os.remove(test_path.resolve())
                if test_path.parent.exists():
                    os.rmdir(test_path.parent.resolve())
                print(e)
                failed_file.write(f"{filepath.resolve()}\n")
            test_file.close()
failed_file.close()