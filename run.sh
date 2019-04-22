#!/bin/sh
LATEST_RELEASE=$(curl -s "https://circleci.com/api/v1.1/project/github/Dexels/navajo.example?circle-token=${CIRCLE_TOKEN}&offset=0&filter=successful" | jq '.[].build_num')
IMAGE=dexels/navajo.example
MINORVERSION=0.1
docker run -p 8181:8181 -it --rm -e FILE_REPOSITORY_DEPLOYMENT=test \
	-e INTERACTIVE=true \
	-e NO_REDIS=true \
	--name navajo-example \
	--name navajo-container-example_default \
	dexels/navajo.example:local
	

