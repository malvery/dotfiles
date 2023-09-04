#!/bin/bash

if [ -z "$1" ]; then
  DEFAULT=main
  tmux attach -t $DEFAULT && exit 0
  systemd-run --user --scope tmux new-session -d -s $DEFAULT

  tmux split-window -h
  # tmux split-window -v
  tmux selectp -t 0
  tmux -2 attach-session -d

else
  ls $1 &> /dev/null || exit 2
  TARGET=${1%/}
  tmux attach -t $TARGET || systemd-run --user --scope tmux new -t $TARGET -c $TARGET
fi

