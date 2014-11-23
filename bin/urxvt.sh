#!/bin/sh
xrdb -merge ~/.Xdefaults
urxvt -name tmux-main -e /home/malvery/bin/tmux.sh
