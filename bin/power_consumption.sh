#!/bin/bash
SYS_PATH='/sys/class/power_supply'
BATT_ID='BAT0'

B_LEVEL=$(cat $SYS_PATH/$BATT_ID/capacity)
B_VOLTAGE=$(cat $SYS_PATH/$BATT_ID/current_now)
B_STATUS=$(cat $SYS_PATH/$BATT_ID/status)

B_VOLTAGE=$(echo "scale=1;$B_VOLTAGE / 100000" | bc -l)

echo "${B_VOLTAGE}W"

