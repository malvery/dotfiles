#!/usr/bin/env bash

case "$1" in
    --power)
            if bluetoothctl show | grep 'Powered: no' -q; then
                rfkill unblock 1
                bluetoothctl power on
            else
                bluetoothctl power off
            fi
        ;;
    --connect)
            if bluetoothctl show | grep 'Powered: yes' -q; then
                notify-send "Bluetooth" "Connecting to the any available devices"
                # bluetoothctl devices | awk '{print $2}' | xargs -n1 bluetoothctl connect

                CONNECTED=$(bluetoothctl devices Connected | awk '{print $2}')
                PAIRED=$(bluetoothctl devices Paired | awk '{print $2}')

                for DEVICE in ${PAIRED}; do
                    if ! $(echo $CONNECTED | grep -w -q ${DEVICE})
                    then
                        DEVICE_NAME=$(bluetoothctl devices Paired | grep ${DEVICE})
                        notify-send "Bluetooth" "Trying to connect to the ${DEVICE_NAME}"
                        bluetoothctl connect ${DEVICE}
                    fi
                done
                sleep 3
            fi
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
