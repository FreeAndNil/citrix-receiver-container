podman run --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 \
  -v $XAUTHORITY:/xauth \
  --ipc=host \
  citrix
