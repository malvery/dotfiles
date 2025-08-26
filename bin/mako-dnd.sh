#!/bin/bash

COUNT=$(makoctl list | grep "^Notification" | wc -l)
ENABLED='{"text": "", "alt": "on", "class":"on"}'
DISABLED='{"text": "", "alt": "off", "class":"off"}'

if [[ $COUNT != 0 ]]; then
  DISABLED=$(printf '{"text": " %s", "alt": "off", "class":"off"}' ${COUNT})
fi

if [[ $(makoctl mode | grep do-not-disturb) != "do-not-disturb" ]]; then
  echo $ENABLED
else
  echo $DISABLED
fi
