#!/bin/bash
focused=$(swaymsg -t get_workspaces -r | jq -r '.[] | select( .focused == true) | .name')

if [[ $1 == 'prev' && $focused -gt 1 ]]; then
  offset='-1'
elif [[ $1 == 'next' && $focused -lt 9 ]]; then
  offset='1'
else
	exit 0
fi

new_workspace=$(echo "scale=1;$focused + $offset" | bc -l)
swaymsg "workspace $new_workspace"

