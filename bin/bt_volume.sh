#!/bin/sh

BT_DEV_MIXER='MONITOR BLUETOOTH - A2DP'

INC_SIZE=5
CARD_ID=1
CARD_MIXER='Master'

case "$1" in
	"up")
		amixer -D bluealsa set "$BT_DEV_MIXER" $INC_SIZE%+ unmute || amixer -c $CARD_ID set "$CARD_MIXER" $INC_SIZE%+ unmute
	;;

  "down")
    amixer -D bluealsa set "$BT_DEV_MIXER" $INC_SIZE%- unmute || amixer -c $CARD_ID set "$CARD_MIXER" $INC_SIZE%- unmute
  ;;

  "mute")
		amixer -D bluealsa set "$BT_DEV_MIXER" toggle || amixer -c $CARD_ID set "$CARD_MIXER" toggle
  ;;

  * )
		exit 0
  ;;
esac

pkill -RTMIN+10 i3blocks

