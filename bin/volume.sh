#!/bin/bash

killall xfce4-notifyd

set_icon ()
{
	LEVEL=`echo $OUT | sed -n '$p' | awk '{print $5}' | grep -o '[0-9]\+'`
	STATUS=`echo $OUT | sed -n '$p' | awk '{print $6}'`

	if [ $STATUS == "[on]" ]; then
		case "$LEVEL" in
			7[1-9]|[89][0-9]|100)
				ICON="notification-audio-volume-high"
			;;
		
			[56][0-9]|70)
				ICON="notification-audio-volume-medium"
			;;

			[1-9]|[1-4][0-9] )
				ICON="notification-audio-volume-low"
			;;

			"0")
				 ICON="notification-audio-volume-off"
			;;
		esac
	else
		ICON="notification-audio-volume-muted"
	fi
}

case "$1" in
	"up") 
		OUT="`amixer -D pulse set Master 5%+ unmute | sed '$!N;$!D'`"
		set_icon
		notify-send -i $ICON "Volume Up:" "$OUT"
	;;

	"down") 
		OUT="`amixer -D pulse set Master 5%- unmute | sed '$!N;$!D'`"
		set_icon
		notify-send -i $ICON "Volume Down:" "$OUT"
	;;

	"mute") 
		OUT="`amixer set Master toggle | sed '$!N;$!D'`"
		set_icon
		notify-send -i $ICON "Volume Mute:" "$OUT"
	;;

	* )
		exit 0
	;;
esac
