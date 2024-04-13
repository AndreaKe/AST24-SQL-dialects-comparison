#!/bin/bash

srcPath=$1 #path to regress folder of the postgres test suite
srcTestPath=${srcPath%/*}
srcExpectedPath=$srcTestPath/expected
srcDataPath=$srcTestPath/data
srcTestPath=$srcTestPath/sql
targetTestPath=$2 # path to postgres_tests folder
targetTestPath=${targetTestPath%/*}

# echo "Delete and re-create test folder"
# rm -r $targetTestPath
# mkdir $targetTestPath

# echo "Copy data folder"
# cp -r $srcDataPath $targetTestPath

echo "Extract execution plan"
input="${srcPath}parallel_schedule"
while IFS= read -r line
do
    echo $line
    if [[ $line == test:* ]];
    then
        echo "yes"
    fi
done < "$input"

# for filepath in $(find $srcTestPath -name '*.sql'); do 
#     filename_with_ext=$(basename "$filepath")
#     filename=${filename_with_ext%.*}
#     currTestFolder=$targetTestPath/$filename

#     echo "Extracting test $filename into $currTestFolder"

#     mkdir $currTestFolder
#     cp $filepath $currTestFolder/test.sql
#     cp $srcTestPath/test_setup.sql $currTestFolder/setup.sql
#     cp $srcExpectedPath/$filename.out $currTestFolder/result.txt
# done
