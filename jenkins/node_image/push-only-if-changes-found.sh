#!/usr/bin/env bash
git status | grep -q modified
IS_DIFF=$(git diff origin/main main | wc -c | bc)
if [ $IS_DIFF -eq 0 ]
then
    echo "No changes since last run"
else
    git commit -m "$1"
    git push origin HEAD:main
    echo "New changes"
fi
