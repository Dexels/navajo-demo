ARG VERSION=0.0.0
FROM dexels/navajo-container:${VERSION}

MAINTAINER Frank Lyaruu

USER 431:433
COPY --chown=431:433 navajo /storage/repositories/navajo/

ENV FILE_REPOSITORY_PATH=/storage/repositories/navajo/
ENV FILE_REPOSITORY_TYPE=multitenant
ENV FILE_REPOSITORY_MONITORED=scripts,config,resources,reactive
ENV FILE_REPOSITORY_FILEINSTALL=config
ENV NO_REDIS=true
ENV HAZELCAST_SIMPLE=true
