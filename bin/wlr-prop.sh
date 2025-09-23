#!/usr/bin/env sh

SWAY_TREE=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?)')
SELECTION=$(echo $SWAY_TREE | jq -r '.rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)

X=$(echo $SELECTION | awk -F'[, x]' '{print $1}')
Y=$(echo $SELECTION | awk -F'[, x]' '{print $2}')
W=$(echo $SELECTION | awk -F'[, x]' '{print $3}')
H=$(echo $SELECTION | awk -F'[, x]' '{print $4}')

echo $SWAY_TREE | jq -r --argjson x $X --argjson y $Y --argjson w $W --argjson h $H \
  '. | select(.rect.x == $x and .rect.y == $y and .rect.width == $w and .rect.height == $h)'
