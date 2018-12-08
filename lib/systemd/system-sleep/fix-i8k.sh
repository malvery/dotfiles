#!/bin/sh
case $1/$2 in
  pre/*)
		systemctl stop i8kmon.service
    ;;
  post/*)
		systemctl start i8kmon.service
    ;;
esac
