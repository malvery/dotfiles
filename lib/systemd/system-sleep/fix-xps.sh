#!/bin/sh
case $1/$2 in
  pre/*)
		rmmod bbswitch
		systemctl stop i8kmon.service NetworkManager.service
    ;;
  post/*)
		modprobe bbswitch
		systemctl start i8kmon.service NetworkManager.service
    ;;
esac
