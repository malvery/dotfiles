#!/bin/sh
TTY_CURRENT=$(cat /sys/class/tty/tty0/active)
TTY_RUN_ON=${LIBINPUT_GESTURES_TTY:-tty1}

echo "!!!: ${TTY_RUN_ON} == ${TTY_CURRENT}"

if [[ $TTY_CURRENT == $TTY_RUN_ON ]]; then
  case "$1" in
  next)
    i3-msg workspace next
    ;;
  prev)
    i3-msg workspace prev
    ;;
  next-force)
    i3-msg exec "pkill -SIGUSR1 -F ${XDG_RUNTIME_DIR}/i3ipc-switch-workspace.pid"
    ;;
  prev-force)
    i3-msg exec "pkill -SIGUSR2 -F ${XDG_RUNTIME_DIR}/i3ipc-switch-workspace.pid"
    ;;
  kill)
    i3-msg kill
    ;;
  esac
fi
