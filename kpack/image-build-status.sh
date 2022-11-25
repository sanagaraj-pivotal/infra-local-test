#!/bin/bash

APP_NAME=spring-demo-app
ReadyStatus=0
FailedStatus=0

####
# status
# status -> Unknown -> True
# status -> False -> Error
while [ $ReadyStatus -le 0 -a $FailedStatus -le 0 ]
do
echo "Image being built, waiting for image status to be ready..."
ReadyStatus=$(kubectl get images $APP_NAME -o json | jq '.status.conditions[] | select(.type=="Ready") | select(.status=="True")' | wc -c | bc)
FailedStatus=$(kubectl get images $APP_NAME -o json | jq '.status.conditions[] | select(.type=="Ready")| select(.status=="False")' | wc -c | bc)

sleep 2
# TODO: Dont be here forever, have an upper limit with count
done

if [ $FailedStatus -gt 0 ]
then
  echo Failed
  exit 1
else
  echo "Image published"
fi

