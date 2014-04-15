#!/bin/sh

case "$1" in
	"hl2") 
		cd ~/win32/stalker
		X :1 -terminate &
		DISPLAY=:1 nice -20 wine bin/XR_3DA.exe
		DISPLAY=:0
	;;

	"hl2ep1") 
		#
	;;

	"hl2ep2") 
		#
	;;

	* )
		exit 0
	;;
esac
