#!/bin/bash

dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

set -E
sway 

killall redshift 
killall clipman 
libinput-gestures-setup stop

echo "Logout after 120 sec."
sleep 120
exit 0
