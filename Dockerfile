FROM ubuntu:14.04
MAINTAINER Alojzij Blatnik

ARG ARG_UID
ARG ARG_GID

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y fonts-liberation chromium-browser pulseaudio sudo wget && \
    wget https://fpdownload.adobe.com/pub/flashplayer/pdc/23.0.0.207/flash_player_ppapi_linux.x86_64.tar.gz -P /tmp && \
    mkdir /flash/ && \
    tar xzf /tmp/flash_player_ppapi_linux.x86_64.tar.gz -C /flash/ && \
    \
    echo "user:x:${ARG_UID}:${ARG_GID}:User,,,:/home/user:/bin/bash" >> /etc/passwd && \
    echo "user:x:${ARG_UID}:" >> /etc/group && \
    echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user && \
    mkdir /home/user && \
    chown user:user /home/user

VOLUME ["/home/user"]
CMD ["/usr/bin/chromium-browser", "--ppapi-flash-path=/flash/libpepflashplayer.so", "--ppapi-flash-version"]
