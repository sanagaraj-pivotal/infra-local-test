# infra-local-test

# Service and Deployment
ytt -f gitops/dev/spring-demo-app/ --data-value  image=index.docker.io/omocquais/spring-demo-app:6da6c8df7a4343eea8f8276307526e35c316e037-b1.20221205.151545 | kapp deploy -a spring-boot-app --yes -f -
kapp delete -a spring-boot-app

# Ingress

# NGINX Ingress Controller

## Installation
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml

## Deployment
kapp deploy -a my-ingress -f gitops/dev/ingress/ingress.yaml

kapp delete -a my-ingress

# Port Forward
kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8085:80

# Use brower
http://demo.localdev.me:8085/actuator


kubectl create ingress demo-localhost -n backend --class=nginx \
--rule="demo.localdev.me/*=spring-demo-app:80"


kubectl create ingress demo-localhost -n backend --class=nginx \
--rule="demo.localdev.me/*=spring-demo-app:80" --dry-run=client -o yaml