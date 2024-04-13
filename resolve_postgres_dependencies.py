
import os

test_path = "/home/keuscha/Documents/FS2024/AST/project/AST24-SQL-dialects-comparison/postgres_tests"  # TODO 

for fname in os.listdir(test_path):

    folder_path = os.path.join(test_path, fname)
    
    if os.path.isdir(folder_path) and fname != "data":
        print("Folder: ", fname)
    
        parallel_schedule_src = open("{}/parallel_schedule".format(test_path), "r")


        dependencies_file = open("{}/schedule_requirements".format(folder_path), "w")
        dependencies_file.write("test_setup\ncreate_index\n")

        setup_file = open("{}/setup.sql".format(folder_path), "w")

        for t in ["test_setup", "create_index"]:
            if(fname != t and fname != "test_setup"):
                with open("{}/{}/test.sql".format(test_path, t.strip()), "r") as scan: # TODO: catch error
                            setup_file.write("-- START setup from {} \n".format(t))
                            setup_file.write(scan.read())
                            setup_file.write("-- END setup from {} \n".format(t))


        lines = parallel_schedule_src.readlines()
    
        for line in lines:
            line_start = "# {} depends on".format(fname)
            if line_start in line:
                print(line)
                for t in ((line.split(line_start, 1)[1]).split(" and ",1)[0]).split(", "):
                    dependencies_file.write(t.strip())
                    dependencies_file.write("\n")

                    with open("{}/{}/test.sql".format(test_path, t.strip()), "r") as scan: # TODO: catch error
                        setup_file.write("-- START setup from {} \n".format(t))
                        setup_file.write(scan.read())
                        setup_file.write("-- END setup from {} \n".format(t))


        
        dependencies_file.close()
        parallel_schedule_src.close()
        setup_file.close()

        

