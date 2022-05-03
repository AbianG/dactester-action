#!/bin/sh -l
output=()
for file in $(find /github/workspace/$1 -type f -name '*.md'); do
            echo "> Test $file";
            output+=$(python3 /app/dactester/tester.py $file /github/workspace/ruleconfig.yml) || exit 1;
            echo "::set-output name=results::$output"
done
