#!/bin/sh
xrdb -merge ~/.Xdefaults
urxvt -name tmux-main -e ~/bin/tmux.sh
