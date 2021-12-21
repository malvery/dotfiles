#!/bin/bash
intern=eDP-1
extern=DP-2

if xrandr | grep "$extern disconnected"; then
  xrandr --output "$extern" --off --output "$intern" --auto
  gsettings set org.gnome.desktop.interface text-scaling-factor  1.17
else
  gsettings set org.gnome.desktop.interface text-scaling-factor  1.06
  xrandr --output "$intern" --off --output "$extern" --mode 2560x1440 --rate 75
fi

i3-msg restart
