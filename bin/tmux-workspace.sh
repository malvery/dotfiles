#!/bin/bash

PREFIX="systemd-run --user --scope"

case "$1" in
-w)
  ls $2 &>/dev/null || exit 2
  TARGET=${2%/}

  tmux attach -t $TARGET || ${PREFIX} tmux new-session -t $TARGET -c $TARGET
  ;;
*)

  if [ -z "$1" ]; then
    TARGET=main
  else
    TARGET="$1"
  fi

  tmux attach -t $TARGET && exit 0
  ${PREFIX} tmux new-session -d -s $TARGET

  # tmux split-window -h
  # tmux split-window -v
  # tmux selectp -t 0
  tmux -2 attach-session -d

  ;;
esac
