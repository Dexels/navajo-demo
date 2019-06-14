#!/bin/sh
MINORTAG=0.1
BASEBUILDNR=$(curl -s "https://circleci.com/api/v1.1/project/github/Dexels/navajo-example-test?circle-token=${CIRCLE_TOKEN}&offset=0&filter=successful" | jq '[.[]| select(.workflows.job_name == "build")][0].build_num')
IMAGE=dexels/navajo.example.test:latest
docker run -v $PWD/surefire-reports:/surefire-reports --network navajoexample_default $IMAGE

