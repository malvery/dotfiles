#!/bin/sh

/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &
xsettingsd &
dunst &
pulseaudio --start &
lxpolkit &
clipit &
~/src/touchpad_settings.sh &
syndaemon -t -R -i 0.1 &
redshift-gtk &
#nm-applet &
#wicd-gtk -t &
thunderbird &
slack &
atom &
lxterminal &
shutter  --min_at_startup &
#light-locker &
xss-lock -- i3lock -c 000000 &
xsetroot -solid "#323232" &
#compton --backend glx --vsync opengl &

