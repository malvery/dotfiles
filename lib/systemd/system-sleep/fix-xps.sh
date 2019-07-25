#!/bin/sh
case $1/$2 in
  pre/*)
		true
    ;;
  post/*)
		# fix nvidia card power
		tee /sys/bus/pci/rescan <<<1
		sleep 1
		tee /sys/bus/pci/devices/0000:01:00.0/remove <<<1
		tee /sys/bus/pci/devices/0000:00:01.0/power/control <<<auto
    ;;
esac
