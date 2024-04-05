#!/usr/bin/env bash

case "$1" in
    --connect)
            notify-send "Bluetooth" "Connecting to the any available device"
            bluetoothctl devices | awk '{print $2}' | xargs -n1 bluetoothctl connect
            sleep 3
        ;;
    --reset)
            STATE=$(bluetoothctl show | grep Powered | awk '{print $2}')

            if [[ $STATE == 'yes' ]]; then
                notify-send "Bluetooth" "Power off"

                bluetoothctl power off
                sleep 0.5

            else
                notify-send "Bluetooth" "Reset connected devices"

                bluetoothctl power on
                sleep 0.5
                bluetoothctl devices | awk '{print $2}' | xargs -n1 bluetoothctl connect
                sleep 3
            fi
        ;;
    --reconnect)
            notify-send "Bluetooth" "Reconnect devices"

            DEVICES=$(bluetoothctl devices Connected | awk '{print $2}')
            echo $DEVICES | xargs -n1 bluetoothctl disconnect
            sleep 3

            echo $DEVICES | xargs -n1 bluetoothctl connect
            sleep 3
        ;;
  *)
    exit 1
    ;;
esac

pkill -USR1 py3status
