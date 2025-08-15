#!/bin/bash

__restart () {
    pkill -u ${USER} -f $1 && eval $@ &
}

makoctl reload
# __restart pcmanfm-qt --desktop
# __restart gammastep-indicator
# __restart waybar
