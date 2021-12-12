#!/bin/bash

case "$1" in
  copy)
    if [[ -z $WAYLAND_DISPLAY ]]; then
      xclip -i -selection clipboard
    else
      wl-copy
    fi
    ;;
  paste)
    if [[ -z $WAYLAND_DISPLAY ]]; then
      xclip -o -selection clipboard
    else
      wl-paste
    fi
    ;;
  *)
    exit 1
    ;;
esac


