#!/bin/sh
for mp3 in *.mp3;
do
	cp "$mp3" /media/sdc1/$RANDOM".mp3"
done

