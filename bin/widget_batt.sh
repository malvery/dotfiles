#!/bin/sh

STATE=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E state | awk '{print $2}'`
TIME_INFO=`upower -i /org/freedesktop/UPower/devices/battery_BAT0  | grep -E "time\ to\ full|empty" | grep 'time to'`

echo
echo "    state:                       $STATE  "
echo "$TIME_INFO "
echo "    backlight:               `cat /sys/class/backlight/intel_backlight/brightness`"

