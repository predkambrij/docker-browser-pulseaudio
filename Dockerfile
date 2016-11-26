FROM ubuntu:14.04
MAINTAINER Alojzij Blatnik

ARG ARG_UID
ARG ARG_GID

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y chromium-browser pulseaudio sudo && \
    \
    echo "user:x:${ARG_UID}:${ARG_GID}:User,,,:/home/user:/bin/bash" >> /etc/passwd && \
    echo "user:x:${ARG_UID}:" >> /etc/group && \
    echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user && \
    mkdir /home/user && \
    chown user:user /home/user

VOLUME ["/home/user"]
CMD ["/usr/bin/chromium-browser"]
