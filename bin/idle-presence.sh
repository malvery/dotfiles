#!/usr/bin/bash
#requires:
# 'xprintidle' for inactivity check (in ms)
# 'rand' for generating random number (screen resolution)
# 'xdotool' to move the mouse pointer

#parameters:
# 100000 idle time in ms before executing the mousemove
# 800 / 600: your screen resolution, at at least the moving range for the mouse pointer

while :; do
    if  [[ $(xprintidle) -gt 180000 ]] && ! [[ $(pgrep xsecurelock) ]]
    then
        xdotool mousemove `rand -M 1920` `rand -M 1080`;
    fi

    sleep 30
done
