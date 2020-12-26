#!/bin/bash
light -N 1 &
xsettingsd &
hsetroot -solid "#1C1C1C" &
dunst &

xss-lock -- xsecurelock.sh & 
libinput-gestures-setup start &
clipmenud &
alttab &

blueman-applet &
#nm-applet &

alacritty -e tmux-session-main.sh &
thunderbird &
telegram-desktop &

