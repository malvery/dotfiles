#!/bin/sh
cd ~/win32/skyrim
X :1 -terminate &
DISPLAY=:1 nice -20 wine TESV.exe
DISPLAY=:0
