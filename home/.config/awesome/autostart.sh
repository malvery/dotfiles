#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run xss-lock -- xsecurelock
run libinput-gestures
run clipmenud
run light -N 1
run blueman-applet
run pasystray
run nm-applet --indicator
run firefox
run alacritty -e tmux-workspace.sh

(sleep 2 && run telegram-desktop) &
(sleep 2 && alttab) &

if [[ $(hostname) == "nbubnt185" ]]; then
  run nm-applet

  # flatpak run org.gnome.Evolution &
  # flatpak run com.slack.Slack &
  # flatpak run us.zoom.Zoom &
else
  run thunderbird
fi
