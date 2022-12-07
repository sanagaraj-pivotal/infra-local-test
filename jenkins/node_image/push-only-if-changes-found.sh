#!/usr/bin/env bash
IS_DIFF=$(git diff origin/main main | wc -c | bc)
if [ $IS_DIFF -eq 0 ]
then
    echo "No changes since last run"
else
    git push origin HEAD:main
    echo "New changes"
fi
