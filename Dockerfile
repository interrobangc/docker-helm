FROM alpine:3.13

ARG VERSION=2.17.0

ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${VERSION}-linux-amd64.tar.gz"

RUN apk add --update --no-cache \
    bash \
    curl \
    ca-certificates \
    gettext \
    py-pip \
    && \
    pip --no-cache-dir install \
    awscli \
    && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    curl -L ${BASE_URL}/${TAR_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x aws-iam-authenticator && \
    mv aws-iam-authenticator /usr/local/bin/aws-iam-authenticator && \
    apk del curl && \
    rm -f /var/cache/apk/*

COPY docker-entrypoint /docker-entrypoint/docker-entrypoint
COPY kubeconfig /docker-entrypoint/kubeconfig

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint/docker-entrypoint"]
CMD ["sh"]
