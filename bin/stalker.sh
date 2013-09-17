#!/bin/sh
cd ~/win32/stalker
X :1 -terminate &
DISPLAY=:1 nice -20 wine bin/XR_3DA.exe
DISPLAY=:0
