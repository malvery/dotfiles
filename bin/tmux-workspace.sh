#!/bin/bash

if [ -z "$1" ]; then
  tmux attach -t 0 && exit 0

  tmux new-session -d -s 0
  # tmux split-window -h
  # tmux split-window -v
  # tmux selectp -t 0
  tmux -2 attach-session -d

else
  ls $1 &> /dev/null || exit 2
  TARGET=${1%/}
  tmux attach -t $TARGET || tmux new -t $TARGET -c $TARGET

fi

