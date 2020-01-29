#!/bin/sh

#
# Uses the CIRCLE_TOKEN environment variable to securely access CircleCI.
# VERSION refers to latest dexels/navajo-container version.
#

export PREFIX=3.3

export BUILD=$(curl -s "https://circleci.com/api/v1.1/project/github/Dexels/navajo-container?circle-token=${CIRCLE_TOKEN}&limit=1&offset=0&filter=successful" | jq '.[0].build_num')
export VERSION="${PREFIX}.${BUILD}"

echo "Version: '${VERSION}'"

docker-compose  pull
docker-compose  build 
