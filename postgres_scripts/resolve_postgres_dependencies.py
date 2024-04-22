
import os
import re

test_path = "/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests"  # TODO 

for fname in os.listdir(test_path):

    folder_path = os.path.join(test_path, fname)
    
    if os.path.isdir(folder_path) and fname != "data" and fname != "collate.windows.win1252":
        print("Folder: ", fname)

        test_file = open("{}/test.sql".format(folder_path), "r")

        lines = test_file.readlines()
        test_file.close()

        test_file = open("{}/test.sql".format(folder_path), "w")
        variables = {}
        
        for line in lines:
            # ';' is used later on as a delimiter of sql commands. Therefore, we need to remove them from comments
            if "--" in line:
                ls = line.split("--", 1)
                line = ls[0] + "--" + ls[1].replace(";", " /* REPLACED */," ).replace("'", "/* REPLACED */''").replace('"', "/* REPLACED */''").replace("$$", "/* REPLACED */")
                

            # TODO probably we should do this when executing the tests such that people can share the test cases with each other
            if 'PG_ABS_SRCDIR' in line or 'PG_LIBDIR' in line or 'PG_DLSUFFIX' in line or 'PG_ABS_BUILDDIR' in line:
                line = line.replace('PG_ABS_SRCDIR', "'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests'")
                line = line.replace('PG_LIBDIR', "'/home/keuscha/Documents/FS2024/AST/project/postgresql/src/test/regress'")
                line = line.replace('PG_DLSUFFIX', "'.so'")
                line = line.replace('PG_ABS_BUILDDIR', "'/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_results'")

            for var in variables:
                #print("original line: ", line)
                line = line.replace(":'" + var + "'", "/* REPLACED */ " + variables.get(var))
                line = line.replace(":" + var, "/* REPLACED */ " + variables.get(var))
                line = line.replace("' || '", "")
                #print("new line: ", line)
            
            if line.startswith("\set") or line.startswith("\getenv"):
                #print("original line: ", line)
                components = line.replace("\n", "").replace("/* REPLACED */ ", "").split(" ")
                variables[components[1]] = ' || '.join(components[2:])
                line = "-- " + line
                #print("variables: ", variables)
            elif line.startswith('\d'):
                line = "-- " + line
            
            test_file.write(line)
        
        test_file.close()


# extract dependencies from parallel_schedule file
parallel_schedule_src = open("{}/parallel_schedule".format(test_path), "r")
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
for fname in os.listdir(test_path):

    folder_path = os.path.join(test_path, fname)
    
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
            with open("{}/{}/test.sql".format(test_path, d.strip()), "r") as scan: # TODO: catch error
                setup_file.write("-- START setup from {} \n".format(d))
                setup_file.write(scan.read())
                setup_file.write("-- END setup from {} \n".format(d))
                setup_file.write("SELECT pg_catalog.set_config('search_path', 'public', false);\n")
        setup_file.close()


        

