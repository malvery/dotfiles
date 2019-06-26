#!/bin/bash
if [[ -z $WAYLAND_DISPLAY ]]; then
	xclip -i -selection clipboard
else
	wl-copy
fi
