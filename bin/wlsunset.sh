#!/usr/bin/env sh

if pgrep -u ${USER} waybar > /dev/null; then
  UPDATE="pkill -RTMIN+6 waybar"
  MSG_NIGHT=""
  MSG_DAY=""
else
  UPDATE="pkill -u ${USER} -USR1 py3status"
  MSG_NIGHT="N"
  MSG_DAY="D"
fi

start() {

  LOCATION=$(curl -s http://ip-api.com/json?fields=lat,lon)
  LAT=$(echo $LOCATION | jq -r '.lat')
  LON=$(echo $LOCATION | jq -r '.lon')

  wlsunset -l $LAT -L $LON -t 5500 &
}

case $1'' in

'stop')
  pkill -u ${USER} -x wlsunset
  $UPDATE
  ;;

'start')
  start
  $UPDATE
  ;;

'toggle')
  if pkill -u ${USER} -x -0 wlsunset; then
    pkill -u ${USER} -x wlsunset
  else
    start
  fi
  $UPDATE
  ;;

'check')
  command -v wlsunset
  exit $?
  ;;
esac

if pkill -u ${USER} -x -0 wlsunset; then
  echo $MSG_NIGHT
else
  echo $MSG_DAY
fi

