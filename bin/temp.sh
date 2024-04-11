#!/bin/bash

CHIP="coretemp-isa-0000"
SENSOR="Package id 0"
INPUT="temp1_input"

VALUE=$(sensors ${CHIP} -j | jq ".\"${CHIP}\".\"${SENSOR}\".${INPUT}")
VALUE=$(printf "%.0f\n" ${VALUE})


if [ "$VALUE" -gt "70" ]; then
    ZONE=zone3

elif [ "$VALUE" -gt "50" ]; then
    ZONE=zone2
else
    ZONE=zone1
fi

echo "{\"text\": \"${VALUE}\", \"alt\": \"${ZONE}\", \"class\":\"${ZONE}\"}"

