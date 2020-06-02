#!/bin/bash
light -N 1 &
xsettingsd &
nitrogen --restore &
dunst &

xss-lock -- xsecurelock.sh & 
libinput-gestures-setup start &
/usr/lib/gpaste/gpaste-daemon &

blueman-applet &
nm-applet &
redshift-gtk &

alacritty -e tmux-s-main.sh &
thunderbird &
telegram-desktop &

