#!/bin/bash
echo "shell dockerusername dockerpassword gitrevision"
kubectl apply -f https://github.com/pivotal/kpack/releases/download/v0.8.1/release-0.8.1.yaml
kubectl create secret docker-registry spring-demo-credentials \
    --docker-username=$1 \
    --docker-password=$2 \
    --docker-server=https://index.docker.io/v1/ \
    --namespace default
kubectl apply -f service-account.yaml
kubectl apply -f store.yaml
kubectl apply -f stack.yaml
ytt -f builder.yaml --data-value dockerusername=$1 | kubectl apply -f -
#ytt -f image.yaml --data-value dockerusername=$1 --data-value gitrevision=$3 | kubectl apply -f -
#ytt -f image-angular.yaml --data-value dockerusername=$1 --data-value gitrevision=$3 | kubectl apply -f -
# To build angular image use angular-demo-app/build-image.sh
