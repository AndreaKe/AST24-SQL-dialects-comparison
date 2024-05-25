import os
from pathlib import Path

pgSame = 0
pgDiff = 0
pgErr = 0
ddbSame = 0
ddbDiff = 0
ddbErr = 0
for root, _, files in os.walk('mysql_results'):
    for filename in files:
        filepath = Path(root) / filename
        if filename == 'summary.txt':
            with open(filepath.absolute(), 'r') as  f:
                lines = f.readlines()[-9:]
            pgSame += int(lines[0].split("\t")[1].replace(" queries", ''))
            pgDiff += int(lines[1].split("\t")[1].replace(" queries", ''))
            pgErr += int(lines[2].split("\t")[1].replace(" queries", ''))
            ddbSame += int(lines[6].split("\t")[1].replace(" queries", ''))
            ddbDiff += int(lines[7].split("\t")[1].replace(" queries", ''))
            ddbErr += int(lines[8].split("\t")[1].replace(" queries", ''))
totalPg = pgSame + pgDiff + pgErr
totalDdb = ddbSame + ddbDiff + ddbErr
with open("mysql_results/overall_summary.txt", 'w+') as f:
    f.write("=================\n")
    f.write("Results for postgres\n")
    f.write("SAME:\t{} queries\t{:.2f}%\n".format(pgSame, pgSame/totalPg*100))
    f.write("DIFFERENT:\t{} queries\t{:.2f}%\n".format(pgDiff, pgDiff/totalPg*100))
    f.write("ERROR:\t{} queries\t{:.2f}%\n".format(pgErr, pgErr/totalPg*100))
    f.write("=================\n")
    f.write("Results for duckdb\n")
    f.write("SAME:\t{} queries\t{:.2f}%\n".format(ddbSame, ddbSame/totalDdb*100))
    f.write("DIFFERENT:\t{} queries\t{:.2f}%\n".format(ddbDiff, ddbDiff/totalDdb*100))
    f.write("ERROR:\t{} queries\t{:.2f}%\n".format(ddbErr, ddbErr/totalDdb*100))

            

