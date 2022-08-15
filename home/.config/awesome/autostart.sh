#!/usr/bin/env bash

function run {
  if ! pgrep -U $(id -u) -f $1 ;
  then
    $@&
  fi
}

run xss-lock -- xsecurelock
run libinput-gestures
run /usr/lib/gpaste/gpaste-daemon
run light -N 1
run blueman-applet
run pasystray
run nm-applet --indicator
run firefox
run alacritty -e tmux-workspace.sh
run thunderbird

(sleep 2 && run telegram-desktop) &
(sleep 2 && alttab) &

if [[ $(hostname) == "nbubnt185" ]]; then
  # flatpak run org.gnome.Evolution &
  # flatpak run com.slack.Slack &
  # flatpak run us.zoom.Zoom &

elif [[ $(id -u) == "1001" ]]; then
  run lxc start nbubnt185
  run hsetroot -solid "#457468"
  run davmail
  run telegram-desktop
  run time-desktop.sh

  flatpak run us.zoom.Zoom
  sudo -u malvery /usr/local/bin/libinput-gestures-control.sh stop
else
  true
fi
