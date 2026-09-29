#!/usr/bin/env bash

PROFILES=("powersave" "balanced-battery" "throughput-performance")
NUM_PROFILES=${#PROFILES[@]}

get_display_name() {
    case "$1" in
        "powersave")
            echo "PS"
            echo "#86AD85" # color_good
            ;;
        "balanced")
            echo "BL"
            echo "#FE8600" # color_degraded
            ;;
        "throughput-performance")
            echo "PF"
            echo "#FF5500" # color_bad
            ;;
        *)
            echo "${1:-offline}"
            echo "#FF5500"
            ;;
    esac
}

CURRENT=$(tuned-adm active 2>/dev/null | awk '{print $NF}')

CURRENT_INDEX=-1
for i in "${!PROFILES[@]}"; do
    if [[ "${PROFILES[$i]}" == "$CURRENT" ]]; then
        CURRENT_INDEX=$i
        break
    fi
done

if [[ "$1" == "next" || "$1" == "prev" ]]; then
    if [[ "$1" == "next" ]]; then
        if [[ $CURRENT_INDEX -ge 0 ]]; then
            NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_PROFILES ))
        else
            NEXT_INDEX=0
        fi
    elif [[ "$1" == "prev" ]]; then
        if [[ $CURRENT_INDEX -ge 0 ]]; then
            NEXT_INDEX=$(( (CURRENT_INDEX - 1 + NUM_PROFILES) % NUM_PROFILES ))
        else
            NEXT_INDEX=$(( NUM_PROFILES - 1 ))
        fi
    fi

    TARGET_PROFILE="${PROFILES[$NEXT_INDEX]}"

    tuned-adm profile "$TARGET_PROFILE"

    get_display_name "$TARGET_PROFILE"

    pkill -u "$USER" -USR1 py3status 2>/dev/null

else
    get_display_name "$CURRENT"
fi
