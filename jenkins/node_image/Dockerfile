FROM maven:3.8-eclipse-temurin-17-alpine
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl" && \
    chmod u+x ./kubectl && \
    mv ./kubectl /usr/bin
RUN curl -LO "https://github.com/vmware-tanzu/carvel-ytt/releases/download/v0.44.0/ytt-linux-amd64" \
    && mv ./ytt-linux-amd64 ytt && \
    chmod u+x ./ytt && \
    mv ./ytt /usr/bin \
RUN apk add jq
