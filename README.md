Chromium browser inside Docker
==============================

Run Chromium browser inside an isolated [Docker](http://www.docker.io) container on your Linux desktop. This setup was inspired from [jlund/docker-chrome-pulseaudio](https://github.com/jlund/docker-chrome-pulseaudio).


Instructions
============

1. Install [Docker](http://docs.docker.io/en/latest/installation/) and [Docker Compose](https://docs.docker.com/compose/) if you haven't already

1. Clone this repository and get right in there

        git clone https://github.com/predkambrij/docker-chromium-pulseaudio.git && cd docker-chromium-pulseaudio

1. Prepare .env

        ./build_env.sh

1. Build the container

        docker-compose build browser

1. Run the container

        docker-compose up -d browser
