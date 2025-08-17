#!/bin/bash

DPI=$1
DPI_M=$((${DPI} * 1024))

xrandr --output eDP-1 --dpi ${DPI}

sed -i -e "s/^.*DPI.*$/Xft\/DPI ${DPI_M}/g" ~/.xsettingsd
killall -u ${USER} -HUP xsettingsd

if [[ $(pgrep -U $(whoami) i3) ]]; then
  I3SOCK=$(i3 --get-socketpath)

  i3-msg restart
  dunstctl reload
fi
