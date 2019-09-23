#!/bin/sh
export BASE_VERSION=$(curl -s "https://circleci.com/api/v1.1/project/github/Dexels/navajo-container?circle-token=${CIRCLE_TOKEN}&limit=1&offset=0&filter=successful" | jq '.[0].build_num')
export MINORVERSION=3.3
export VERSION=${MINORVERSION}.${BASE_VERSION}
echo "Version: ${VERSION}"
docker-compose pull --quiet
docker-compose build 
# --build-arg VERSION=3.3.${BASE_VERSION}
#docker build . --build-arg VERSION=3.3.${BASE_VERSION} -t dexels/navajo.example:local

