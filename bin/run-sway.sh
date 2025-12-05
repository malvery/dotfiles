#!/bin/bash

export QT_QPA_PLATFORMTHEME=qt6ct
export WLR_RENDERER=vulkan
# export WLR_DRM_NO_ATOMIC=1
# export WLR_RENDER_NO_EXPLICIT_SYNC=1

sway

echo "Stop background apps..."
pkill -u ${USER} hypridle

# pkill -u ${USER} clipcatd
# flatpak ps | awk '{print $3}' | uniq | xargs -n 1 flatpak kill || true
