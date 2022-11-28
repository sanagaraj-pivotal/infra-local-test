#!/bin/bash

APP_NAME=spring-demo-app
GIT_COMMIT=$1
ReadyStatus=0
FailedStatus=0

####
# status
# status -> Unknown -> True
# status -> False -> Error
while [ $ReadyStatus -le 0 -a $FailedStatus -le 0 ]
do
echo "Image being built, waiting for image status to be ready..."
#get pod name
# inspect container logs
BuilderPodName=$(kubectl get build -o json | jq -r '.items[] | select(.spec.source.git.revision=="'$GIT_COMMIT'") | .status.podName')
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

# TODO Manage errors (init container failed)

sleep 2
# TODO: Dont be here forever, have an upper limit with count

ReadyStatus=$(kubectl get images $APP_NAME-$GIT_COMMIT -o json | jq '.status.conditions[] | select(.type=="Ready") | select(.status=="True")' | wc -c | bc)
FailedStatus=$(kubectl get images $APP_NAME-$GIT_COMMIT -o json | jq '.status.conditions[] | select(.type=="Ready")| select(.status=="False")' | wc -c | bc)

done

if [ $FailedStatus -gt 0 ]
then
  echo Failed
  exit 1
else
  echo "Image published"
  echo "******************** IMAGE ****************************"
  kubectl get images $APP_NAME-$GIT_COMMIT -o json | jq -r '.status.latestImage'
  echo "*******************************************************"
fi

