#!/usr/bin/env bash
DIVIDER="---------"
GO_BACK="Back"
EXIT="Exit"
CONNECTED_ICON="***"
LAUNCHER="bemenu -l 20"
MENU_PROMNT="Bluetooth:"

# Checks if bluetooth controller is powered on
power_on() {
    if bluetoothctl show | grep -F -q "Powered: yes"; then
        return 0
    else
        return 1
    fi
}

# Toggles power state
toggle_power() {
    if power_on; then
        bluetoothctl power off
        show_menu
    else
        if rfkill list bluetooth | grep -F -q 'blocked: yes'; then
            rfkill unblock bluetooth && sleep 3
        fi
        bluetoothctl power on
        show_menu
    fi
}

# Checks if controller is scanning for new devices
scan_on() {
    if bluetoothctl show | grep -F -q "Discovering: yes"; then
        echo "Scan: on"
        return 0
    else
        echo "Scan: off"
        return 1
    fi
}

# Toggles scanning state
toggle_scan() {
    if scan_on; then
        kill "$(pgrep -f "bluetoothctl scan on")"
        bluetoothctl scan off
        show_menu
    else
        bluetoothctl scan on &
        echo "Scanning..."
        sleep 5
        show_menu
    fi
}

# Checks if controller is able to pair to devices
pairable_on() {
    if bluetoothctl show | grep -F -q "Pairable: yes"; then
        echo "Pairable: on"
        return 0
    else
        echo "Pairable: off"
        return 1
    fi
}

# Toggles pairable state
toggle_pairable() {
    if pairable_on; then
        bluetoothctl pairable off
        show_menu
    else
        bluetoothctl pairable on
        show_menu
    fi
}

# Checks if controller is discoverable by other devices
discoverable_on() {
    if bluetoothctl show | grep -F -q "Discoverable: yes"; then
        echo "Discoverable: on"
        return 0
    else
        echo "Discoverable: off"
        return 1
    fi
}

# Toggles discoverable state
toggle_discoverable() {
    if discoverable_on; then
        bluetoothctl discoverable off
        show_menu
    else
        bluetoothctl discoverable on
        show_menu
    fi
}

# Checks if a device is connected
device_connected() {
    if bluetoothctl info "$1" | grep -F -q "Connected: yes"; then
        return 0
    else
        return 1
    fi
}

# Toggles device connection
toggle_connection() {
    if device_connected "$1"; then
        bluetoothctl disconnect "$1"
        # device_menu "$device"
    else
        bluetoothctl connect "$1"
        # device_menu "$device"
    fi
}

# Checks if a device is paired
device_paired() {
    if bluetoothctl info "$1" | grep -F -q "Paired: yes"; then
        echo "Paired: yes"
        return 0
    else
        echo "Paired: no"
        return 1
    fi
}

# Toggles device paired state
toggle_paired() {
    if device_paired "$1"; then
        bluetoothctl remove "$1"
        device_menu "$device"
    else
        bluetoothctl pair "$1"
        device_menu "$device"
    fi
}

# Checks if a device is trusted
device_trusted() {
    if bluetoothctl info "$1" | grep -F -q "Trusted: yes"; then
        echo "Trusted: yes"
        return 0
    else
        echo "Trusted: no"
        return 1
    fi
}

# Toggles device connection
toggle_trust() {
    if device_trusted "$1"; then
        bluetoothctl untrust "$1"
        device_menu "$device"
    else
        bluetoothctl trust "$1"
        device_menu "$device"
    fi
}

# Prints a short string with the current bluetooth status
# Useful for status bars like polybar, etc.
print_status() {
    if power_on; then
        printf ''

        mapfile -t paired_devices < <(bluetoothctl paired-devices | grep -F Device | cut -d ' ' -f 2)
        counter=0

        for device in "${paired_devices[@]}"; do
            if device_connected "$device"; then
                device_alias="$(bluetoothctl info "$device" | grep -F "Alias" | cut -d ' ' -f 2-)"

                if [ $counter -gt 0 ]; then
                    printf ", %s" "$device_alias"
                else
                    printf " %s" "$device_alias"
                fi

                ((counter++))
            fi
        done
        printf "\n"
    else
        echo ""
    fi
}

# A submenu for a specific device that allows connecting, pairing, and trusting
device_menu() {
    device="$1"

    # Get device name and mac address
    device_name="$(echo "$device" | cut -d ' ' -f 3-)"
    mac="$(echo "$device" | cut -d ' ' -f 2)"

    # Build options
    if device_connected "$mac"; then
        connected="Connected: yes"
    else
        connected="Connected: no"
    fi
    paired="$(device_paired "$mac")"
    trusted="$(device_trusted "$mac")"
    options="$connected\n$paired\n$trusted\n$DIVIDER\n$GO_BACK\n$EXIT"

    # Open dmenu menu, read chosen option
    chosen="$(echo -e "$options" | run_dmenu "$device_name")"

    # Match chosen option to command
    case $chosen in
        "" | "$DIVIDER")
            echo "No option chosen."
            ;;
        "$connected")
            toggle_connection "$mac"
            ;;
        "$paired")
            toggle_paired "$mac"
            ;;
        "$trusted")
            toggle_trust "$mac"
            ;;
        "$GO_BACK")
            show_menu
            ;;
    esac
}

# Opens a dmenu menu with current bluetooth status and options to connect
show_menu() {
    # Get menu options
    if power_on; then
        power="Power: on"

        # Human-readable names of devices, one per line
        # If scan is off, will only list paired devices
        if [[ -n "$CONNECTED_ICON" ]]; then
            devices="$(bluetoothctl devices | grep -F Device | while read -r device; do
                device_name="$(echo "$device" | cut -d ' ' -f 3-)"
                mac="$(echo "$device" | cut -d ' ' -f 2)"
                icon=""

                if device_connected "$mac" && [[ -n $CONNECTED_ICON ]]; then
                    icon=" $CONNECTED_ICON"
                fi

                echo "$device_name${icon}"
            done)"
        else
            devices="$(bluetoothctl devices | grep -F Device | cut -d ' ' -f 3-)"
        fi

        # Get controller flags
        scan="$(scan_on)"
        pairable="$(pairable_on)"
        discoverable="$(discoverable_on)"

        # Options passed to dmenu
        [[ -n $devices ]] && devices_part="$devices\n$DIVIDER\n"
        options="$devices_part$power\n$scan\n$pairable\n$discoverable\n$EXIT"
    else
        power="Power: off"
        options="$power\n$EXIT"
    fi

    # Open dmenu menu, read chosen option
    chosen="$(echo -e "$options" | run_dmenu "Bluetooth")"

    # Match chosen option to command
    case $chosen in
        "" | "$DIVIDER")
            echo "No option chosen."
            ;;
        "$power")
            toggle_power
            ;;
        "$scan")
            toggle_scan
            ;;
        "$discoverable")
            toggle_discoverable
            ;;
        "$pairable")
            toggle_pairable
            ;;
        *)
            if [[ -n "$CONNECTED_ICON" ]]; then
                chosen="${chosen%% ${CONNECTED_ICON}}"
            fi
            device="$(bluetoothctl devices | grep -F "$chosen")"
            # Open a submenu if a device is selected
            if [[ -n "$device" ]]; then device_menu "$device"; fi
            ;;
    esac
}

run_dmenu() {
    $LAUNCHER -i -p "$MENU_PROMNT" "${dmenu_args[@]}"
}

command_present() {
    command -v "$1" >/dev/null 2>&1
}

error() {
    echo "$1. $2." >&2
    command_present notify-send && notify-send "$1" "$2."
}

# Check if bluetooth daemon is running. Start it if possible.
if command_present systemctl; then
    systemctl is-active --quiet bluetooth
    case $? in
        3)
            error "Bluetooth daemon is not running" "Start it to use this script"
            systemctl start bluetooth || exit 3
            ;;
        4)
            error "Bluetooth daemon is not present" "On Arch Linux install bluez and bluez-utils packages"
            exit 4
            ;;
    esac
fi

show_menu
