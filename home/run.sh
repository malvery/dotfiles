#!/bin/sh
sleep 5
xmonad --replace &
compton --xrender-sync-fence &
#nitrogen --restore &

sleep 1

chromium &
clementine &
google-chrome-stable --incognito &
skypeforlinux &
thunderbird &
/home/malvery/bin/urxvt.sh &
pycharm &

sleep 3
xprop -root -remove _NET_WORKAREA
