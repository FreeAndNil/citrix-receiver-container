set -x

ICA_ROOT_HOST="$HOME/.config/citrix-receiver-container/root/.ICAClient"
mkdir -p $ICA_ROOT_HOST

# cat /proc/sys/net/ipv4/ip_local_port_range
PULSE_AUDIO_BRIDGE_PORT="53971"
LANG=c PULSE_AUDIO_BRIDGE_INDEX="$(pactl load-module module-native-protocol-tcp  port=$PULSE_AUDIO_BRIDGE_PORT auth-ip-acl=127.0.0.1)"

podman run --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 \
  -v $XAUTHORITY:/xauth \
  -e XAUTHORITY=/xauth \
  --ipc=host \
  --hostname citrix-receiver-container \
  --name citrix \
  -e TZ="Europe/Berlin" \
  --net=host \
  -e PULSE_SERVER=tcp:127.0.01:$PULSE_AUDIO_BRIDGE_PORT \
  -e USE_FIREFOX_FOR_SELFSERVICE \
  -v $ICA_ROOT_HOST:/root/.ICAClient \
  citrix "$@"

pactl unload-module $PULSE_AUDIO_BRIDGE_INDEX
