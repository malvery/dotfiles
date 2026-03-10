#!/bin/sh
TTY_CURRENT=$(cat /sys/class/tty/tty0/active)
TTY_RUN_ON=${LIBINPUT_GESTURES_TTY:-tty1}

echo "!!!: ${TTY_RUN_ON} == ${TTY_CURRENT}"

if [[ $TTY_CURRENT == $TTY_RUN_ON ]]; then
  case "$1" in
  next)
    wtype -M win -M ctrl -P right
    ;;
  prev)
    wtype -M win -M ctrl -P left
    ;;
  kill)
    wtype -M win -M shift -P c
    ;;
  esac
fi
