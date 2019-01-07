FROM alpine:3.8

ARG VERSION=2.12.0

ENV BASE_URL="https://storage.googleapis.com/kubernetes-helm"
ENV TAR_FILE="helm-v${VERSION}-linux-amd64.tar.gz"

RUN apk add --update --no-cache \
        curl \
        ca-certificates \
        gettext \
        && \
    curl -L ${BASE_URL}/${TAR_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x aws-iam-authenticator && \
    mv aws-iam-authenticator /usr/local/bin/aws-iam-authenticator && \
    apk del curl && \
    rm -f /var/cache/apk/*

COPY docker-entrypoint /docker-entrypoint/docker-entrypoint
COPY kubeconfig /docker-entrypoint/kubeconfig

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint/docker-entrypoint"]
CMD ["sh"]
