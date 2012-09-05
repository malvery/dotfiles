#!/bin/bash
MUSIC="/home/malvery/Music"

FILE=`cmus-remote -Q | grep file | sed s/'file '//g`
TITLE=`cmus-remote -Q | grep 'tag title' | sed s/'tag title '//g`
ARTIST=`cmus-remote -Q | grep 'tag artist' | sed s/'tag artist '//g`

mkdir "$MUSIC/$ARTIST/" 2>/dev/null
cp "$FILE" "$MUSIC/$ARTIST/$ARTIST - $TITLE.flac" 
notify-send "added: \"$MUSIC/$ARTIST/$ARTIST - $TITLE.flac\""
