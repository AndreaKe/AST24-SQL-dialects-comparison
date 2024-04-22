import os
import sys
import logging

logging.basicConfig(stream=sys.stderr, level=logging.WARN) # change level to INFO or DEBUG to see more output



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


def is_equal_but_no_comment(a, e):
    if a.startswith('--') or a != e:
        logging.debug("r={}\ne={}\n")
        return False
    return True

def is_equal(a, e):
    if a.startswith('--') or "/* REPLACED */"  in a:
        # We ignore comments and lines where we replaced something (as those are part of the queries, not of the results anyway)
        # print("PASS:\n\texpected: {}\tresult: {}".format(e, r))
        return True

    if a != e:
        logging.debug("r={}\ne={}\n")
        return False
    return True

isIdentical = True

logging.info("\n==============\nComparing {} {}\n".format(results_path, expected_path))
e_i = 0
r_i = 0
r = ''
e = ''
while e_i < len(expected) or r_i < len(results):
    if r_i >= len(results) or e_i >= len(expected):
        isIdentical = False
        logging.warning("r={}\ne={}\n")
        logging.error("ERROR: Unexpected EOF")
        break

    r = results[r_i]
    e = expected[e_i]

    if e.startswith("\d") and r.startswith("-- \\"): # we ignore meta data queries
        while r_i < len(results)-1 and (r.startswith("--") or r == ''):
            r_i = r_i + 1
            r = results[r_i].split('--')[0]
        logging.debug("after --\d r={}".format(r))
        
        while e_i < len(expected)-1 and not is_equal(r, e):
            e_i = e_i + 1
            e = expected[e_i].split('--')[0]
        
        logging.debug("after --\d e={}".format(e))
        continue

    if not is_equal(r, e):
        logging.warning("r={}\ne={}\n")
        isIdentical = False
        logging.error("ERROR:\n\texpected: {}\tresult: {}".format(e, r))
        break

    r_i = r_i + 1
    e_i = e_i + 1
    
        
if isIdentical:
    print("PASS: Files are identical")
else:  
    print("FAIL: Files are not identical")  
