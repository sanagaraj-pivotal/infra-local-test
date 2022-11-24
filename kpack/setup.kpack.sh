#!/bin/bash
echo "Enter docker username"
read dockerUserName
echo "enter docker password"
read dockerPassword

kubectl apply -f https://github.com/pivotal/kpack/releases/download/v0.8.1/release-0.8.1.yaml
kubectl create secret docker-registry spring-demo-credentials \
    --docker-username=$dockerUserName \
    --docker-password=$dockerPassword \
    --docker-server=https://index.docker.io/v1/ \
    --namespace default
kubectl apply -f service-account.yaml
kubectl apply -f store.yaml
kubectl apply -f stack.yaml
kubectl apply -f builder.yaml
ytt -f image.yaml --data-value dockerusername=$dockerUserName | kubectl apply -f -
