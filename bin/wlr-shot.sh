#!/bin/bash
set -e

if [[ -z $WAYLAND_DISPLAY ]]; then
  (>&2 echo Wayland is not running)
  exit 1
fi

SHOT_DIR="$(xdg-user-dir PICTURES)/Screenshots"
SHOT_TIME=$(date "+${SWAYSHOT_DATEFMT:-%F_%H-%M-%S}")
SHOT_PATH="$SHOT_DIR"/screenshot_${SHOT_TIME}.png

[[ ! -d ${SHOT_DIR} ]] && mkdir ${SHOT_DIR}

# take screenshot
case "$1" in
-r)
  grim -g "$(slurp -w 3 -d)" "$SHOT_PATH"
  ;;
*)
  grim -o "$(swaymsg --type get_outputs --raw | jq --raw-output '.[] | select(.focused) | .name')" "$SHOT_PATH"
  ;;
esac
echo $SHOT_PATH

# upload to imgur
if [ "$2" == "-u" ]; then
  URL=$(imgur.sh $SHOT_PATH | head -1)
  echo $URL | wl-copy -n
  notify-send "screenshot" "${URL}"

# edit shot
else
  echo ${SHOT_PATH} | wl-copy -n
  notify-send "screenshot" "${SHOT_PATH}"

  swappy -f ${SHOT_PATH}
fi
