#!/bin/bash

__restart () {
    pkill -u ${USER} $1
    eval $@ &
}

makoctl reload
__restart waybar
__restart pcmanfm-qt --desktop
