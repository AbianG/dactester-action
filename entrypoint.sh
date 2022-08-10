#!/bin/bash

output=$(
    for file in $(find /github/workspace/$1 -type f -name '*.md'); do
            echo "> Test $file";
            python3 /app/dactester/tester.py $file /github/workspace/ruleconfig.yml || exit 1;
    done
)
echo "### Compliance report :clipboard:" >> $GITHUB_STEP_SUMMARY
echo ">>>>>> Output of errors file start"
input='/app/errors.txt'
prefix="File: "
while IFS= read -r line
do
  if [[ $line =~ ^File* ]]; then
    doc_file=$line 
    fixed_docfile=$(echo $doc_file | sed -e "s/^$prefix//")
    echo $fixed_docfile
  fi
  if [[ $line =~ ^Title* ]]; then
    #echo "::error file={$fixed_docfile},title=COMPLIANCE FAILED::Errors found  in document"
    echo ":x: COMPLIANCE FAILED FOR DOCUMENT: $fixed_docfile" >> $GITHUB_STEP_SUMMARY
  else
    echo "::error file={$fixed_docfile},title=COMPLIANCE FAILED::$line"
    errors_found=1
  fi
done < "$input"
echo "<<<<<< Output of errors file end"

echo "### Complete testing log output"
echo "::set-output name=results::$output"

if [ $errors_found -eq 1 ]; then
    exit 1
else
    exit 0
fi
