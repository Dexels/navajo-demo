#!/bin/sh
BASEBUILDNR=$(curl -s "https://circleci.com/api/v1.1/project/github/Dexels/navajo-platform?circle-token=${CIRCLE_TOKEN}&offset=0&filter=successful" | jq '[.[]| select(.workflows.job_name == "package_navajo")][0].build_num') 
echo $BASEBUILDNR
docker-compose build --build-arg VERSION=0.1.${BASEBUILDNR}
#docker build . --build-arg VERSION=0.1.${BASEBUILDNR} -t dexels/navajo.example:local

