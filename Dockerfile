ARG VERSION=3.3.947
FROM dexels/navajo-container:${VERSION}

USER 431:433
COPY --chown=431:433 navajo /storage/repositories/navajo/

ENV FILE_REPOSITORY_FILEINSTALL=config
ENV FILE_REPOSITORY_MONITORED=scripts,config,resources,reactive
ENV FILE_REPOSITORY_PATH=/storage/repositories/navajo/
ENV FILE_REPOSITORY_TYPE=multitenant
ENV HAZELCAST_SIMPLE=true
ENV NO_REDIS=true

