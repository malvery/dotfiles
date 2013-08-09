#!/bin/bash
cd "$1"

IMG=`ls *.ape` > /dev/null 2>&1 || IMG=`ls *.flac` > /dev/null 2>&1 || IMG=`ls *.wv` > /dev/null 2>&1 || exit 1
CUE=`ls *.cue`

enconv -L russian -x UTF-8 "$CUE"

cuebreakpoints "$CUE" | shnsplit -o flac	"$IMG" && rm "$IMG"
cuetag "$CUE" split-track*.flac && rm "$CUE" 
