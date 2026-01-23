#!/bin/bash

LOCATION=$(curl -s http://ip-api.com/json?fields=lat,lon)
LAT=$(echo $LOCATION | jq -r '.lat')
LON=$(echo $LOCATION | jq -r '.lon')

wlsunset -l $LAT -L $LON -t 5000
