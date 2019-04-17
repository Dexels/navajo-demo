#!/bin/sh
docker run -p 8181:8181 -it --rm \
	-e INTERACTIVE=true \
	-e FILE_REPOSITORY_DEPLOYMENT=develop \
	--name navajo-example \
	dexels/navajo-demo:1
