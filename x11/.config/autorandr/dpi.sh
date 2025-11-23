#!/bin/bash

DPI=$1
SCALE=$2
CURSOR_SIZE=$3
DPI_M=$((${DPI} * 1024))

xrandr --dpi ${DPI}

sed -i -e "s/^.*dpi.*$/Xft.dpi: ${DPI}/g" ~/.Xresources
xrdb -merge ~/.Xresources

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gdk/WindowScalingFactor': <${SCALE}>, 'Xft/DPI': <${DPI_M}>}"
gsettings set org.gnome.desktop.interface cursor-size ${CURSOR_SIZE}


if [[ $(pgrep -U $(whoami) i3) ]]; then
  I3SOCK=$(i3 --get-socketpath)

  i3-msg restart
  dunstctl reload
fi
