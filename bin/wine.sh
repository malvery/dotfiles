#!/bin/sh

case "$1" in
	"q4") 
		cd ~/win32/quake4
		X :1 -terminate &
		DISPLAY=:1 nice -20 wine Quake4.exe
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
