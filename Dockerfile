FROM docker:latest as docker

FROM ubuntu:20.04

LABEL version="1.0" maintainer="Majo Richter <majo418@coreunit.net>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apt-utils --no-install-recommends && \
    apt-get full-upgrade -y && \
    apt-get install -y --no-install-recommends \
        apt-transport-https ca-certificates \
        curl lxc iptables gnupg && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

COPY --from=docker /usr/local/bin/ /usr/local/bin/
COPY ./deamon.json /etc/docker/daemon.json

VOLUME /var/lib/docker
USER root

CMD ["dockerd"]
