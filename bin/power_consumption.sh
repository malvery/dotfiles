#!/bin/bash

SYS_PATH='/sys/class/power_supply'
BAT_ID='BAT0'

if [ -f ${SYS_PATH}/${BAT_ID}/current_now ]; then
    POWER_NOW='current_now'
    MULTIPLIER=100000
else
    POWER_NOW='power_now'
    MULTIPLIER=1000000
fi

B_VOLTAGE=$(cat $SYS_PATH/$BAT_ID/$POWER_NOW)
B_VOLTAGE=$(echo "scale=1;$B_VOLTAGE / $MULTIPLIER" | bc -l)

echo "${B_VOLTAGE}W"

