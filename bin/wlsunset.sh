#!/usr/bin/env sh

UPDATE="pkill -u ${USER} -USR1 py3status"
# UPDATE="waybar-signal sunset"

start() {

  LOCATION=$(curl -s http://ip-api.com/json?fields=lat,lon)
  LAT=$(echo $LOCATION | jq -r '.lat')
  LON=$(echo $LOCATION | jq -r '.lon')

  wlsunset -l $LAT -L $LON -t 5000 &
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
  echo "N"
else
  echo "D"
fi

# if pkill -u ${USER} -x -0 wlsunset; then
#   class="on"
#   text="location-based gamma correction"
# else
#   class="off"
#   text="no gamma correction"
# fi
# printf '{"alt":"%s","tooltip":"%s"}\n' "$class" "$text"
