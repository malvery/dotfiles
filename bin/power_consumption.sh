#!/bin/bash

SYS_PATH='/sys/class/power_supply'
BATT_ID='BAT0'

if [ "$HOSTNAME" = tpneo14 ]; then
    POWER_NOW='power_now'
    MULTIPLIER=1000000
else
    POWER_NOW='current_now'
    MULTIPLIER=100000
fi

B_VOLTAGE=$(cat $SYS_PATH/$BATT_ID/$POWER_NOW)
B_VOLTAGE=$(echo "scale=1;$B_VOLTAGE / $MULTIPLIER" | bc -l)

echo "${B_VOLTAGE}W"

