#!/bin/bash

if test -f /tmp/swayidle-block; then
  exit 1
fi

focused_class=$(swaymsg -t get_tree | jq -r '
.. | (.nodes? // empty)[] 
| select(.focused==true) 
.window_properties.class')

function xwayland_inhibit () {
  if [ $1 == $focused_class ]; then
    pa_sink_count=$(pacmd list-sink-inputs \
      | awk '/state:/ {print $0} /process.binary/ {print $0}' \
      | grep -B 1 -i $focused_class \
      | grep RUNNING \
      | wc -l
    )

    if [ $pa_sink_count -gt 0 ]; then
      exit 1
    fi
  fi
}

xwayland_inhibit "firefox"
xwayland_inhibit "Chromium"

swaymsg "output * dpms off"
#swaylock -f -c $1
