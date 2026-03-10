#!/bin/bash

case "$1" in
copy)
  if [ "$(uname -s)" = "Darwin" ]; then
    pbcopy
  elif [[ -z $WAYLAND_DISPLAY ]]; then
    xclip -i -selection clipboard
  else
    wl-copy
  fi
  ;;
paste)
  if [ "$(uname -s)" = "Darwin" ]; then
    pbpaste
  elif [[ -z $WAYLAND_DISPLAY ]]; then
    xclip -o -selection clipboard
  else
    wl-paste
  fi
  ;;
*)
  exit 1
  ;;
esac
