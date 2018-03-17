dockerip=$(ip addr | grep inet.*docker|awk '{print $2}'|awk -F/ '{print $1}')
pulse_socket=(tcp:$dockerip:$((pax11publish || xprop -root PULSE_SERVER)|grep -Eo 'tcp:[^ ]*'|awk -F: '{print $3}'))

echo "ARG_UID=$(id -u)" >  .env
echo "ARG_GID=$(id -g)" >> .env
echo "dockerip=$dockerip" >> .env
echo "pulse_socket=$pulse_socket" >> .env


