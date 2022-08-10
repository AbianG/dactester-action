#!/bin/sh -l

output=$(
    for file in $(find /github/workspace/$1 -type f -name '*.md'); do
            echo "> Test $file";
            python3 /app/dactester/tester.py $file /github/workspace/ruleconfig.yml || exit 1;
    done
)
echo "### Compliance report :clipboard:" >> $GITHUB_STEP_SUMMARY
echo ">>>>>> Output of errors file start"
input='/app/errors.txt'
while IFS= read -r line
do
  echo "$line"
done < "$input"
echo "<<<<<< Output of errors file end"
