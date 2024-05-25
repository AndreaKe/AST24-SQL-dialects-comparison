import os
import re
from pathlib import Path

## UNFINISHED
## Proof of Concept 

duckdb_sql_test_dir = (Path.home() / 'duckdb/test/sql').absolute() # TODO
duckdb_build_path = (Path.home() / 'duckdb/build/release').absolute() #/test

#log_file_path = Path('temp_duckdb/temp.log')
log_file_path = Path('temp_duckdb')
log_file_path.mkdir(exist_ok=True)

# os.system(f"{duckdb_build_path}/test/unittest dummy") # TODO: Ensure it is executed on one thread > /dev/null
temp_path = Path('temp_duckdb')
temp_path.mkdir(exist_ok=True)

for root, dirs, files in os.walk(duckdb_sql_test_dir):
    for filename in files:
        filepath = Path(root) / filename
        if filepath.suffix == '.test' or filepath.suffix == '.test_slow':
            filepath_r = str(filepath.resolve())
            print(filepath_r)
            with open(filepath_r, "rb") as f1:
                f1s = f1.read();
                log_file_path = temp_path / f"{filepath.stem}.log"
                if not f1s.startswith(b'statement ok\nSET log_query_path'):
                    if re.match(b'^require.*$',f1s): # otherwise test is skipped
                        f2 = open(filepath_r, "wb")
                        f2.write(b"statement ok\n")
                        f2.write((f"SET log_query_path = '{log_file_path.resolve()}'\n").encode())
                        f2.write(f1s);
                        f2.close();
                os.system(f"{duckdb_build_path}/test/unittest {filepath_r[filepath_r.find('test/sql'):]}") #   TODO: Ensure it is executed on one thread, log output?
                #test_path = Path('duckdb_tests') / filepath.stem
                #test_path.mkdir(exist_ok=True, parents=True)
                #test_path = test_path / 'test.sql'
                #test_file = open(test_path.resolve(), 'w+')

        
