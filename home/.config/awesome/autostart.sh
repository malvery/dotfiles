#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

export $DCONF_PATH org.gnome.desktop.interface

gsettings set $DCONF_PATH gtk-theme            'Arc-Dark-solid'
gsettings set $DCONF_PATH icon-theme           'gnome'
gsettings set $DCONF_PATH monospace-font-name  'Hack 12'
gsettings set $DCONF_PATH document-font-name   'Ubuntu 12'
gsettings set $DCONF_PATH font-name            'Ubuntu 12'
# gsettings set $DCONF_PATH text-scaling-factor  1.08

run xss-lock -- xsecurelock
run libinput-gestures-setup start
run clipmenud
run light -N 1
run blueman-applet
run pasystray
run thunderbird
run firefox
run alacritty -e tmux-workspace.sh

(sleep 2 && run telegram-desktop) &
(sleep 2 && alttab) &
