#!/bin/bash

command="waybar"

until $command; do
    echo "Exited with $?. Restarting..."
done
