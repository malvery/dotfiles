#!/bin/sh

FRONT_LEFT=`amixer -D pulse get Master | grep 'Front Left:'`
FRONT_RIGHT=`amixer -D pulse get Master | grep 'Front Right:'`

FR_L=`echo $FRONT_LEFT | awk '{print $5}' |  cut -c 2- | rev | cut -c 2- | rev`
FR_R=`echo $FRONT_RIGHT | awk '{print $5}' |  cut -c 2- | rev | cut -c 2- | rev`
FR_S=`echo $FRONT_RIGHT | awk '{print $6}' |  cut -c 2- | rev | cut -c 2- | rev`

echo
echo "   OUT Status :  $FR_S"
echo "   Front Left:     $FR_L  "
echo "   Front Right:   $FR_R   "
