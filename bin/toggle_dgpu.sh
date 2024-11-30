#!/bin/bash
usage="Usage: ./graphic_card [option] \nOPTION: \n- off \n- on"

CONTROLLER_BUS_ID=0000:00:01.0
DEVICE_BUS_ID=0000:01:00.0
BUS_RESCAN_WAIT_SEC=1
MODULES_LOAD=(nvidia nvidia_uvm nvidia_modeset "nvidia_drm modeset=1")
MODULES_UNLOAD=(nvidia_drm nvidia_modeset nvidia_uvm nvidia)

function turn_off_gpu {
  echo 'Removing Nvidia bus from the kernel'
  sudo tee /sys/bus/pci/devices/${DEVICE_BUS_ID}/remove <<<1

  echo 'Enabling powersave for the PCIe controller'
  sudo tee /sys/bus/pci/devices/${CONTROLLER_BUS_ID}/power/control <<<auto

  for module in "${MODULES_UNLOAD[@]}"
  do
      echo "Unloading module ${module}"
    sudo modprobe -r ${module}
  done
}

function turn_on_gpu {
  echo 'Turning the PCIe controller on to allow card rescan'
  sudo tee /sys/bus/pci/devices/${CONTROLLER_BUS_ID}/power/control <<<on

  echo 'Waiting 1 second'
  sleep 1

  if [[ ! -d /sys/bus/pci/devices/${DEVICE_BUS_ID} ]]; then
    echo 'Rescanning PCI devices'
    sudo tee /sys/bus/pci/rescan <<<1
    echo "Waiting ${BUS_RESCAN_WAIT_SEC} second for rescan"
    sleep ${BUS_RESCAN_WAIT_SEC}
  fi

  echo 'Turning the card on'
  sudo tee /sys/bus/pci/devices/${DEVICE_BUS_ID}/power/control <<<on

  for module in "${MODULES_LOAD[@]}"
  do
      echo "Loading module ${module}"
    sudo modprobe ${module}
  done
}

if [ $# -ne 1 ]; then
    echo -e $usage
else
    if [ $1 = 'on' ]; then
      turn_on_gpu

    elif [ $1 = 'off' ]; then
      turn_off_gpu

    else
      echo -e $usage
    fi
fi
