#!/bin/bash

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export XDG_CURRENT_DESKTOP=sway

set -E
sway

libinput-gestures-setup stop

echo "Logout after 120 sec."
sleep 120
exit 0
