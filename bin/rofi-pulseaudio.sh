#!/bin/sh

outputs() {
    OUTPUT=$(pactl list short sinks | cut  -f 2 | rofi -dmenu -p "Audio output" )
    pactl set-default-sink "$OUTPUT" >/dev/null 2>&1
}

inputs() {
    INPUT=$(pactl list short sources | cut  -f 2 | grep input | rofi -dmenu -p "Audio input" )
    pactl set-default-source "$INPUT" >/dev/null 2>&1
}

case "$1" in
    --output)
        outputs
    ;;

    --input)
        inputs
    ;;

    *)
        echo "Wrong argument"
    ;;
esac
