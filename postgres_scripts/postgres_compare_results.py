import os
import sys

results_path = ""
expected_path = ""
if(len(sys.argv) > 2):
    results_path = str(sys.argv[1]) 
    expected_path = str(sys.argv[2]) 

results_file = open(results_path, "r")
results = results_file.readlines()
results_file.close()

expected_file = open(expected_path, "r")
expected = expected_file.readlines()
expected_file.close()

isIdentical = True

print("\n==============\nComparing {} and {}...\n".format(results_path, expected_path))
e_i = 0
r_i = 0
while e_i < len(expected) or r_i < len(results):
    if r_i >= len(results) or e_i >= len(expected):
        isIdentical = False
        print("ERROR: Unexpected EOF")
        break

    r = results[r_i]
    e = expected[e_i]

    r_i = r_i + 1
    e_i = e_i + 1

    if e.startswith("\d") and r.startswith("-- \d"): 
        # we ignore meta data queries
        if r_i < len(results):
            r =  results[r_i]
        while e_i < len(expected) and r != expected[e_i]:
            e_i = e_i + 1
        continue

    if r.startswith('--') or "/* REPLACED */"  in r:
        # We ignore comments and lines where we replaced something (as those are part of the queries, not of the results anyway)
        # print("PASS:\n\texpected: {}\tresult: {}".format(e, r))
        continue

    if r != e:
        isIdentical = False
        print("ERROR:\n\texpected: {}\tresult: {}".format(e, r))
        break
    
        
if isIdentical:
    print("PASS: Files are identical")
else:  
    print("FAIL: Files are not identical")  
