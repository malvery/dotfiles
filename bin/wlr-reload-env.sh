#!/bin/bash

__restart () {
    pkill -u ${USER} $1
    eval $@ &
}

makoctl reload
__restart pcmanfm-qt --desktop
# __restart waybar
