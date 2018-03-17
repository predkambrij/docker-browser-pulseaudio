Chromium browser inside Docker
==============================

Run Chromium browser inside an isolated [Docker](http://www.docker.io) container on your Linux desktop. This setup was inspired from [jlund/docker-chrome-pulseaudio](https://github.com/jlund/docker-chrome-pulseaudio).


Instructions
============

1. Install [PulseAudio Preferences](http://freedesktop.org/software/pulseaudio/paprefs/). Debian/Ubuntu users can do this:

        sudo apt-get install paprefs

1. Launch PulseAudio Preferences, go to the "Network Server" tab, and check the "Enable network access to local sound devices" checkbox.

1. Restart PulseAudio

        sudo service pulseaudio restart

   On some distributions, it may be necessary to completely restart your computer. You can confirm that the settings have successfully been applied using the `pax11publish` command. You should see something like this (the important part is in bold):

   > Server: {ShortAlphanumericString}unix:/run/user/1000/pulse/native **tcp:YourHostname:4713 tcp6:YourHostname:4713**

   > Cookie: ReallyLongAlphanumericString

1. Install [Docker](http://docs.docker.io/en/latest/installation/) and [Docker Compose](https://docs.docker.com/compose/) if you haven't already

1. Clone this repository and get right in there

        git clone https://github.com/predkambrij/docker-chromium-pulseaudio.git && cd docker-chromium-pulseaudio

1. Prepare .env

        bash build_env.sh

1. Build the container

        docker-compose build browser

1. Run the container

        docker-compose up -d browser
