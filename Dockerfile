ARG VERSION=0.0.0
FROM dexels/navajo:$VERSION
MAINTAINER Frank Lyaruu
COPY --chown=431.433 ./navajo /storage/repositories/navajo
ENV FILE_REPOSITORY_PATH=/storage/repositories/navajo/
ENV FILE_REPOSITORY_TYPE=multitenant
ENV FILE_REPOSITORY_MONITORED=scripts,config,resources,reactive
ENV FILE_REPOSITORY_FILEINSTALL=config
ENV HAZELCAST_SIMPLE=true
