#!/bin/bash

output=$(
    for file in $(find /github/workspace/$1 -type f -name '*.md'); do
            echo "> Test $file";
            python3 /app/dactester/tester.py $file /github/workspace/ruleconfig.yml || exit 1;
    done
)
#echo "### Compliance report :clipboard:" >> $GITHUB_STEP_SUMMARY
echo ">>>>>> Output of errors file start"
# Need to perform some filtering to better present the filename and document title
input='/app/errors.txt'
prefix="File: "
title_prefix="Title: "
# Errors file reading loop
while IFS= read -r line
do
  if [[ $line =~ ^File* ]]; then
    doc_file=$line 
    fixed_docfile=$(echo $doc_file | sed -e "s/^$prefix//")
  elif [[ $line =~ ^Title* ]]; then
    doc_title=$line
    fixed_doctitle=$(echo $doc_title | sed -e "s/^$title_prefix//")
  else
    echo "::error file={$fixed_docfile},title=ERROR::$line"
    #echo ":x: COMPLIANCE FAILED FOR DOCUMENT: $fixed_doctitle" >> $GITHUB_STEP_SUMMARY
    errors_found=1
  fi
done < "$input"
echo "<<<<<< Output of errors file end"
# Present the full application log output 
echo ">>>>>> Output of full application log start"
echo "::set-output name=results::$output"
echo "<<<<<< Output of full application log end"

# Fail the action if errors are detected
if [ $errors_found -eq 1 ]; then
    exit 1
else
    exit 0
fi
