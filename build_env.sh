#!/usr/bin/env bash
pulse_socket=$((pax11publish || xprop -root PULSE_SERVER)|grep -Eo 'unix:[^ ]+'|awk -F: '{print $2}')

echo "ARG_UID=$(id -u)" >  .env
echo "ARG_GID=$(id -g)" >> .env
echo "pulse_socket=$pulse_socket" >> .env

