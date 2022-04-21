#!/bin/sh -l

echo "Testing for workspace"
ls /github/workspace
ls /github/workspace/tests

echo "Specified path is"
echo $1
for file in $(find /github/workspace/$1 -type f -name '*.md'); do
            echo "> Test $file";
            python3 /app/dactester/tester.py $file || exit 1;
          done
