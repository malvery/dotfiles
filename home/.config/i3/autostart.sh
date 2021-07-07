#!/bin/bash
hsetroot -solid "#1C1C1C" &

# exit if NVIDIA_SESSION
if [[ -v NVIDIA_SESSION ]]; then
	exit
fi

light -N 1 &
xsettingsd &
dunst &

xss-lock -- xsecurelock & 
libinput-gestures-setup start &
clipmenud &
alttab &

blueman-applet &
#nm-applet &

alacritty -e tmux-workspace.sh &
thunderbird &
telegram-desktop &

