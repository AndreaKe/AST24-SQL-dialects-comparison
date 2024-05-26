import re
import os
import argparse
from pathlib import Path

class AnalysisInfo(object):
    missingTableRegex = re.compile('.*')
    missingTableCount = 0
    missingFunctionRegex = re.compile(".*")
    missingFunctionCount = 0
    postgresConvertErrorRegex = re.compile(".*")
    postgresConvertErrorCount = 0
    globalVariableErrorRegex = re.compile(".*")
    globalVariableErrorCount = 0

    def countMissingTable(self, fs: str):
        count = len(self.missingTableRegex.findall(fs))
        self.missingTableCount += count

    def countMissingFunction(self, fs: str):
        self.missingFunctionCount += len(self.missingFunctionRegex.findall(fs))

    def countPostgresConvertError(self, fs: str):
        self.postgresConvertErrorCount += len(self.postgresConvertErrorRegex.findall(fs)) if self.postgresConvertErrorRegex else 0

    def countGlobalVariableError(self, fs: str):
        count = len(self.globalVariableErrorRegex.findall(fs)) if self.globalVariableErrorRegex else 0
        print("global var count: ", count)
        self.globalVariableErrorCount += count

class Postgres(AnalysisInfo):
    missingTableRegex = re.compile("ERROR - relation \"[^\n]*\" does not exist")
    missingFunctionRegex = re.compile("LINE [0-9]*: call")
    postgresConvertErrorRegex = None
    globalVariableErrorRegex = re.compile("ERROR - syntax error at or near \"@")

class MySQL(AnalysisInfo):
    missingTableRegex = re.compile("ERROR - \(1146, \"Table \'[^\n]*\' doesn\'t exist\"\)")
    missingFunctionRegex = re.compile("execute procedure[^\n]\nRESULT:\n[^\n]*ERROR - \(1064,")
    postgresConvertErrorRegex = re.compile("ERROR - \(1064, \"You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'::")
    globalVariableErrorRegex = re.compile("ERROR - \(1193, \"Unknown system variable")

class DuckDB(AnalysisInfo):
    missingTableRegex = re.compile("ERROR - Catalog Error: Table with name [^\n]* does not exist!")
    missingFunctionRegex = re.compile("ERROR - Catalog Error: Table Function with name [^\n]* does not exist!")
    postgresConvertErrorRegex = re.compile("ERROR - Catalog Error: Type with name [^\n]* does not exist!")
    globalVariableErrorRegex = re.compile("(Parser Error: syntax error at or near \"@ | Catalog Error: unrecognized configuration parameter)")

analysisInfo = {'postgres': Postgres(), 'mysql': MySQL(), 'duckdb': DuckDB()}

parser = argparse.ArgumentParser()
parser.add_argument("-f", 
                    help="path to results folder",
                    required=True,
                    type=str)
args = parser.parse_args()
results_folder = args.f

testSuiteDBName = results_folder.replace("_results", "")

for root, _, files in os.walk(results_folder):
    for filename in files:
        filepath = Path(root) / filename
        if not filename.endswith('_result.txt'):
            print(filename)
            continue
        print(filepath)
        dbName = filename.replace('_result.txt', '')
        with open(filepath.absolute(), 'r') as f:
            fs = f.read()
            analysisInfo[dbName].countMissingTable(fs)
            analysisInfo[dbName].countMissingFunction(fs)
            analysisInfo[dbName].countPostgresConvertError(fs)
            analysisInfo[dbName].countGlobalVariableError(fs)
        print("Done")

for dbName, info in analysisInfo.items():
    if dbName == testSuiteDBName:
        continue
    print(f"========={dbName.upper()}=========\n")
    print(f"Missing Table Errors: {info.missingTableCount}\n")
    print(f"Missing Function Errors: {info.missingFunctionCount}\n")
    print(f"Postgres :: Convert Errors: {info.postgresConvertErrorCount}\n")
    print(f"Global Variable Errors: {info.globalVariableErrorCount}\n")