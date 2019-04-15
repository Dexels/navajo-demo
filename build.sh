#!/bin/sh
LATEST_RELEASE=$(curl -s "https://circleci.com/api/v1.1/project/github/Dexels/navajo-platform?circle-token=${CIRCLE_TOKEN}&offset=0&filter=successful" | jq '[.[]| select(.workflows.job_name == "package_navajo")][0].build_num')
echo "LATEST_RELEASE: ${LATEST_RELEASE}"
IMAGE=dexels/navajo.example
BASE_VERSION=0.1
echo "Building version ${IMAGE}:${BASE_VERSION}.${LATEST_RELEASE}"
docker build . --build-arg VERSION=${BASE_VERSION}.${LATEST_RELEASE} -t ${IMAGE}:${BASE_VERSION}.${LATEST_RELEASE} -t ${IMAGE}:latest 
docker push ${IMAGE}:${BASE_VERSION}.${LATEST_RELEASE} 
docker push ${IMAGE}:latest          

