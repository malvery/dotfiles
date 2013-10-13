#!/bin/bash
#/usr/bin/echo "test" >> /home/malvery/cron
DIR=~/pictures/wallpapers

env DISPLAY=:0 pcmanfm -w "$(find $DIR -type f | shuf -n1)"
#awsetbg -r $DIR
#nitrogen --set-auto "$(find $DIR -type f | shuf -n1)"
