#!/bin/bash
cd "$1"

IMG=`ls *.ape` > /dev/null 2>&1 || IMG=`ls *.flac` > /dev/null 2>&1 || IMG=`ls *.wv` > /dev/null 2>&1 || echo "Cannot find lossless image"
CUE=`ls *.cue`

enconv -x UTF-8 "$CUE"

cuebreakpoints "$CUE" | shnsplit -o flac	"$IMG" && rm "$IMG"
cuetag.sh "$CUE" split-track*.flac && rm "$CUE"
