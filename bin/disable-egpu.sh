#!/bin/bash
set -e

DEVICE_BUS_ID=0000:04:00.0
MODULES_UNLOAD=(nvidia_drm nvidia_modeset nvidia_uvm nvidia)

DGPU_NODE="$(ls -d /sys/bus/pci/devices/${DEVICE_BUS_ID}/drm/card*)"
CARD_ID="${DGPU_NODE: -5}"
CARD_DEVICE=/dev/dri/${CARD_ID}

sudo udevadm trigger --verbose --type=devices --action=remove --subsystem-match=drm --property-match="DEVNAME=${CARD_ID}"

sleep 3
for module in "${MODULES_UNLOAD[@]}"
do
  echo "Unloading module ${module}"
sudo modprobe -r ${module}
done
