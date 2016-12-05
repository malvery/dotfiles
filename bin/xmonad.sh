#!/bin/sh
sleep 3
xmonad --replace &
compton --xrender-sync-fence &
#nitrogen --restore &
