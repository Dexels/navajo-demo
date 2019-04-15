ARG VERSION=0.1.148
FROM dexels/navajo:$VERSION
MAINTAINER Frank Lyaruu
ADD navajo navajo/
ENV FILE_REPOSITORY_PATH=/navajo
ENV FILE_REPOSITORY_TYPE=multitenant
ENV FILE_REPOSITORY_MONITORED=scripts,config,resources,reactive
ENV FILE_REPOSITORY_FILEINSTALL=config
ENV HAZELCAST_SIMPLE=true
#RUN chown -R navajouser:navajouser /navajo
