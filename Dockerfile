FROM ubuntu:18.04
MAINTAINER Alojzij Blatnik

ARG ARG_UID
ARG ARG_GID
ARG TIMEZONE

ENV DEBIAN_FRONTEND noninteractive

RUN \
    echo "user:x:${ARG_UID}:${ARG_GID}:User,,,:/home/user:/bin/bash" >> /etc/passwd && \
    echo "user:x:${ARG_UID}:" >> /etc/group && \
    mkdir /home/user && \
    chown user:user /home/user && \
    \
    apt-get update && \
    apt-get install -y \
        fonts-liberation \
        chromium-browser \
        pulseaudio \
        wget \
        tzdata \
        fonts-roboto \
        fonts-symbola \
        hicolor-icon-theme \
        libcanberra-gtk-module \
        libexif-dev \
        libgl1-mesa-dri \
        libgl1-mesa-glx \
        libpango1.0-0 \
        libv4l-0 \
        && \
    \
    echo "${TIMEZONE}" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    \
    wget https://fpdownload.macromedia.com/pub/labs/flashruntimes/flashplayer/linux64/flash_player_ppapi_linux.x86_64.tar.gz -P /tmp && \
    mkdir /flash/ && \
    tar xzf /tmp/flash_player_ppapi_linux.x86_64.tar.gz -C /flash/

USER user
VOLUME ["/home/user"]
CMD ["/usr/bin/chromium-browser", "--ppapi-flash-path=/flash/libpepflashplayer.so", "--ppapi-flash-version"]

