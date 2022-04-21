#!/bin/sh -l

for file in $(find ./folderToTest -type f -name '*.md'); do
            echo "> Test $file";
            python3 app/dactester/tester.py $file || exit 1;
          done

echo "Testing for workspace"
ls /github/workspace
cat /github/workspace/readme.md
