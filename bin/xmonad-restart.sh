#!/bin/sh
xmonad --restart &

sleep 1
xprop -root -remove _NET_WORKAREA
