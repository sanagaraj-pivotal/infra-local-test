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
#get pod name
# inspect container logs
BuilderName=$(kubectl get build -o json | jq -r '.items[] | select(.spec.source.git.revision=="189be85b248b8dbfcca44eede0e1f7ff9d8fc812") | .metadata.name')
BuilderPodName=$(echo $BuilderName-build-pod)
sleep 2
kubectl logs -f $BuilderPodName -c analyze
sleep 2
kubectl logs -f $BuilderPodName -c build
sleep 2
kubectl logs -f $BuilderPodName -c completion
sleep 2
kubectl logs -f $BuilderPodName -c detect
sleep 2
kubectl logs -f $BuilderPodName -c export
sleep 2
kubectl logs -f $BuilderPodName -c prepare
sleep 2
kubectl logs -f $BuilderPodName -c restore

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

