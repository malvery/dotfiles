#!/usr/bin/bash

while :; do
  if [[ $(xprintidle) -gt 180000 ]] && ! [[ $(pgrep -U $(whoami) i3lock) ]]; then
    X=$(($RANDOM % 1920 + 1))
    Y=$(($RANDOM % 1080 + 1))
    xdotool mousemove $X $Y
  fi

  sleep 30
done
