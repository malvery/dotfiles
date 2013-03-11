#!/bin/bash
MUSIC=~/music

mkdir -p "$MUSIC/$1"
cp "$2" "$MUSIC/$1/" && notify-send "Done: $1"
