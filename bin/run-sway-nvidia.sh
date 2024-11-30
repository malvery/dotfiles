#!/bin/bash
set -e

DEVICE_BUS_ID=0000:04:00.0
MODULES_UNLOAD=(nvidia_drm nvidia_modeset nvidia_uvm nvidia)

DGPU_NODE="$(ls -d /sys/bus/pci/devices/${DEVICE_BUS_ID}/drm/card*)"
CARD_ID="${DGPU_NODE: -5}"
CARD_DEVICE=/dev/dri/${CARD_ID}

WLR_DRM_DEVICES=${CARD_DEVICE} sway --unsupported-gpu -c ~/.config/sway/config-nvidia

${HOME}/bin/disable-egpu.sh
