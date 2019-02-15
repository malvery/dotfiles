#!/bin/bash
TAG_C=$(wmctrl -d | grep '*' | awk '{print $1}')
TAG_L=$(wmctrl -l | awk '{print $2}' | sort -u)

case "$1" in
	"next")
		INDEX='1'
	;;

  "prev")
		INDEX='-1'
  ;;

  * )
		exit 0
  ;;
esac

TAG_N=$(echo "scale=1;$TAG_C + $INDEX" | bc -l)
if [[ $TAG_L == *"$TAG_N"* ]]; then
	wmctrl -s $TAG_N
fi
