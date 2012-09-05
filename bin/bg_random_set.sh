#!/bin/sh
#sleep 5
DIR="/home/malvery/wallpapers/"
#while true; do nitrogen --set-auto "$(find $DIR -name *.jpg | shuf -n 1)"; sleep 20m; done &

while true;
do
  awsetbg -r $DIR 
  sleep 20m
done &
