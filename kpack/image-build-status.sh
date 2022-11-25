#!/bin/bash

APP_NAME=spring-demo-app
ReadyStatus=0


####
# status
# status -> Unknown -> True
while [ $ReadyStatus -le 0 ]
do
echo "Image being built, waiting for image status to be ready..."
ReadyStatus=$(kubectl get images $APP_NAME -o json | jq '.status.conditions[] | select(.type=="Ready") | select(.status=="True")' | wc -c | bc)
sleep 1
# TODO: when there is an error handle it
# TODO: Dont be here forever, have an upper limit with count
done

echo "Image is ready"
