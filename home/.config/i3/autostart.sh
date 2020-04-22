#!/bin/bash
light -N 1 &
xsettingsd &
nitrogen --restore &
dunst &

#xss-lock -- i3lock -c 222f42 & 
#xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock.sh &
xss-lock -- xsecurelock.sh & 
libinput-gestures-setup start &
/usr/lib/gpaste/gpaste-daemon &

blueman-applet &
nm-applet &
redshift-gtk &

thunderbird &
telegram-desktop &
