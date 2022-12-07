#!/usr/bin/env bash
git status | grep -q modified
if [ $? -eq 0 ]
then
    git push origin HEAD:main
    echo "New changes"
else
    echo "No changes since last run"
fi