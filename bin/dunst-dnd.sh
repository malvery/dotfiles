#!/bin/bash

COUNT=$(dunstctl count waiting)
ENABLED='{"text": "", "alt": "on", "class":"on"}'
DISABLED='{"text": "", "alt": "off", "class":"off"}'

if [ $COUNT != 0 ];
then
    DISABLED=$(printf '{"text": "%s", "alt": "off", "class":"off"}' ${COUNT})
fi

if dunstctl is-paused | grep -q "false" ; then echo $ENABLED; else echo $DISABLED; fi
