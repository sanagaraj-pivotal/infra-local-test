#!/usr/bin/env bash
echo "New script"
git status | grep -q modified
echo $1
git status
if [ $? -eq 0 ]
then
    git commit -m $1
    git push origin HEAD:main
    echo "New changes"
else
    echo "No changes since last run"
fi