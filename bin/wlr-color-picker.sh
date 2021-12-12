#!/bin/bash
RESULT=$(grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -n 1)

case "$1" in
  -rgb)
    COLOR=$(echo $RESULT | awk '{print $4}')
    ;;
  -hex)
    COLOR=$(echo $RESULT | awk '{print $3}')
    ;;
  *)
    exit 1
    ;;
esac

echo $COLOR
echo $COLOR | wl-copy -n 
notify-send "picked color" "$COLOR"

