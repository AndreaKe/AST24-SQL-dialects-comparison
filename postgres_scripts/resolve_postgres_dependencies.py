import os
import re
import sys

TEST_PATH = "'" + os.environ.get('PG_ABS_SRCDIR') + "'"

if(len(sys.argv) > 1):
    TEST_PATH = str(sys.argv[1])


PG_ABS_SRCDIR = "'" + os.environ.get('PG_ABS_SRCDIR') + "'"
PG_LIBDIR = "'" + os.environ.get('PG_LIBDIR') + "'"
PG_DLSUFFIX = "'" + os.environ.get('PG_DLSUFFIX', '.so') + "'"
PG_ABS_BUILDDIR = "'" + os.environ.get('PG_ABS_BUILDDIR') + "'"

# print("PG_ABS_SRCDIR=", PG_ABS_SRCDIR)
# print("PG_LIBDIR=", PG_LIBDIR)
# print("PG_DLSUFFIX=", PG_DLSUFFIX)
# print("PG_ABS_BUILDDIR=", PG_ABS_BUILDDIR)

HARDCODE_PATHS = True

for fname in os.listdir(TEST_PATH):

    folder_path = os.path.join(TEST_PATH, fname)
    
    if os.path.isdir(folder_path) and fname != "data" and fname != "collate.windows.win1252":
        print("Folder: ", fname)

        test_file = open("{}/test.sql".format(folder_path), "r")

        lines = test_file.readlines()
        test_file.close()

        test_file = open("{}/test.sql".format(folder_path), "w")
        variables = {}
        
        for line in lines:
            # ';' is used later on as a delimiter of sql commands. Therefore, we need to remove them from comments
            if "--" in line and not "/* REPLACED */" in line:
                ls = line.split("--")
                line = ls[0]
                is_comment = False
                ls_i = 1
                while ls_i < len(ls):
                    if not is_comment and (line.count('$$') % 2 != 0 or line.count('"') % 2 != 0 or line.count("'") % 2 != 0):
                        line = line + "--" + ls[ls_i]
                    else:
                        line = line + "--" + ls[ls_i].replace(";", " /* REPLACED */," ).replace("'", "/* REPLACED */''").replace('"', "/* REPLACED */''").replace("$$", "/* REPLACED */")
                    ls_i = ls_i + 1

            if HARDCODE_PATHS:
                line = line.replace('PG_ABS_SRCDIR', PG_ABS_SRCDIR)
                line = line.replace('PG_LIBDIR', PG_LIBDIR)
                line = line.replace('PG_DLSUFFIX', PG_DLSUFFIX)
                line = line.replace('PG_ABS_BUILDDIR', PG_ABS_BUILDDIR)

            for var in variables:
                #print("original line: ", line)
                line = line.replace(":'" + var + "'", "/* REPLACED */" + variables.get(var))
                line = line.replace(":" + var, "/* REPLACED */" + variables.get(var))
                line = line.replace("' || '", "")
                #print("new line: ", line)
            
            if line.startswith("\set") or line.startswith("\getenv"):
                #print("original line: ", line)
                components = line.replace("\n", "").replace("/* REPLACED */", "").split(" ", 2)
                if len(components) > 2:
                    variables[components[1]] = components[2].replace("/* REPLACED */", "").replace("' '", "")
                line = "-- " + line
                #print("variables: ", variables)
            elif line.startswith('\d'):
                line = "-- " + line
            
            test_file.write(line)
        
        test_file.close()


# extract dependencies from parallel_schedule file
parallel_schedule_src = open("{}/parallel_schedule".format(TEST_PATH), "r")
schedule_lines = parallel_schedule_src.readlines()
parallel_schedule_src.close()

dependencies = {}
for line in schedule_lines:
    m = re.match(r"# (.*) depends on (.*)", line)
    if m != None:
        test = m.group(1)
        print("groups: {}, {}, {}".format(m.group(0), m.group(1), m.group(2)))
        direct_deps = (m.group(2).split(" and ",1)[0]).split(", ")
        all_deps = []
        if test != 'test_setup':
                all_deps.append('test_setup')
                if test != 'create_index':
                    all_deps.append('create_index')
        
        for d in direct_deps:
            ds_ = dependencies.get(d)
            if ds_ != None:
                for a in ds_:
                    if a not in all_deps:
                        all_deps.append(a)
            all_deps.append(d)

        dependencies[test] = all_deps

print("dependencies: ", dependencies)


# resolve dependencies between test cases by creating setup.sql
for fname in os.listdir(TEST_PATH):

    folder_path = os.path.join(TEST_PATH, fname)
    
    if os.path.isdir(folder_path) and fname != "data":
        print("Folder: ", fname)

        curr_deps = dependencies.get(fname)

        if curr_deps == None:
            curr_deps = []
            if fname != 'test_setup':
                curr_deps.append('test_setup')
                if fname != 'create_index':
                    curr_deps.append('create_index')

        
        dependencies_file = open("{}/schedule_requirements".format(folder_path), "w")
        for d in curr_deps:
            dependencies_file.write("{}\n".format(d))
        dependencies_file.close()

        setup_file = open("{}/setup.sql".format(folder_path), "w")
    
        for d in curr_deps:
            with open("{}/{}/test.sql".format(TEST_PATH, d.strip()), "r") as scan: # TODO: catch error
                setup_file.write("-- START setup from {} \n".format(d))
                setup_file.write(scan.read())
                setup_file.write("-- END setup from {} \n".format(d))
                setup_file.write("SELECT pg_catalog.set_config('search_path', 'public', false);\n")
        setup_file.close()


        

