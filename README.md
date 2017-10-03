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

1. [Install Docker](http://docs.docker.io/en/latest/installation/) if you haven't already

1. Clone this repository and get right in there

        git clone https://github.com/predkambrij/docker-chromium-pulseaudio.git && cd docker-chromium-pulseaudio

1. Build the container

        docker build --build-arg TIMEZONE="Europe/Ljubljana" --build-arg ARG_UID="$(id -u)" --build-arg ARG_GID="$(id -g)" -t predkambrij/browser .

1. Run the container

        dockerip=$(ip addr | grep inet.*docker|awk '{print $2}'|awk -F/ '{print $1}')
        pulse_socket=(tcp:$dockerip:$((pax11publish || xprop -root PULSE_SERVER)|grep -Eo 'tcp:[^ ]*'|awk -F: '{print $3}'))

        docker run -d --name=browser \
            --shm-size=512m \
            -h browser.localdomain \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY -e PULSE_SERVER=$pulse_socket -e PULSE_COOKIE=/run/pulse/cookie \
            -v ~/.config/pulse/cookie:/run/pulse/cookie \
            -v chromium_home:/home/user \
            --user user predkambrij/browser

