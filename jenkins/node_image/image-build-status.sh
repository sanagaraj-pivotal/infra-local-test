#!/bin/bash

source lib/waitForContainer.sh

APP_NAME=spring-demo-app
GIT_COMMIT=$1
FailedStatus=0


echo "Wait till image is submitted"
sleep 5

echo "Image Deployment successful"
echo "Initiating building Image"
echo "Image being built, waiting for image status to be ready..."
#get pod name
# inspect container logs
BuilderPodName=$(kubectl get build -o json | jq -r '.items[] | select(.spec.source.git.revision=="'$GIT_COMMIT'") | .status.podName')
echo "Builder pod name: $BuilderPodName"
waitAndLogInitContainer $BuilderPodName analyze 10
waitAndLogInitContainer $BuilderPodName detect 10
waitAndLogInitContainer $BuilderPodName restore 10
waitAndLogInitContainer $BuilderPodName build 10
waitAndLogInitContainer $BuilderPodName export 10

echo "******************** IMAGE ****************************"
kubectl get images $APP_NAME-$GIT_COMMIT -o json | jq -r '.status.latestImage'
echo "*******************************************************"
# TODO Manage errors (init container failed)

sleep 2
# TODO: Dont be here forever, have an upper limit with count
