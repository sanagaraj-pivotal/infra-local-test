FROM maven:3.8-eclipse-temurin-17-alpine
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl" && \
    chmod u+x ./kubectl && \
    mv ./kubectl /usr/bin
RUN curl -LO "https://github.com/vmware-tanzu/carvel-ytt/releases/download/v0.44.0/ytt-linux-amd64" \
    && mv ./ytt-linux-amd64 ytt && \
    chmod u+x ./ytt && \
    mv ./ytt /usr/bin
RUN apk add jq
RUN curl -LO "https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.8.0/kp-linux-amd64-0.8.0" \
    && mv ./kp-linux-amd64-0.8.0 kp && \
    chmod u+x ./kp && \
    mv ./kp /usr/bin
RUN apk add git
RUN apk add yq
COPY push-only-if-changes-found.sh /usr/bin
RUN chmod u+x /usr/bin/push-only-if-changes-found.sh
RUN curl -LO "https://github.com/vmware-tanzu/carvel-kapp/releases/download/v0.54.1/kapp-linux-amd64" \
    && mv ./kapp-linux-amd64 kapp && \
    chmod u+x ./kapp && \
    mv ./kapp /usr/bin
