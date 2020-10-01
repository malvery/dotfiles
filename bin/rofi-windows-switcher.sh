#!/bin/bash

rofi \
    -show windowcd  \
    -kb-cancel "Alt+Escape,Escape" \
    -kb-accept-entry "!Alt-Tab,Return"\
    -kb-row-down "Alt+Tab,Alt+Down" \
    -kb-row-up "Alt+Shift+Tab,Alt+Up" &

