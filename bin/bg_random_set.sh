#!/bin/sh
DIR=~/pictures/wallpapers
SLEEP=20m

while true;
do
  #awsetbg -r $DIR 
	#nitrogen --set-auto "$(find $DIR -type f | shuf -n1)"
	pcmanfm -w "$(find $DIR -type f | shuf -n1)"
  sleep $SLEEP
done &
