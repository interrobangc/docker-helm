#!/usr/bin/env sh

IMAGE=interrobangc/docker-helm

declare -a versions=(
    "2.17.0"
    "2.16.10"
    "2.12.0"
    "2.11.0"
    "3.5.3"
)

TAG_LATEST=1
for version in "${versions[@]}"
do
    docker build --no-cache --build-arg VERSION=${version} -t ${IMAGE}:${version} .
    docker push ${IMAGE}:${version}
    if [ "$TAG_LATEST" = "1" ]; then
        docker tag ${IMAGE}:${version} ${IMAGE}:latest
        docker push ${IMAGE}:latest
        TAG_LATEST=0
    fi
done
