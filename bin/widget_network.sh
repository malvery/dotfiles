#!/bin/sh

echo

case "$1" in
	"desktop")
		ifconfig
	;;

	"notebook")
		iwconfig wlp8s0
		ifconfig enp7s0
	;;

esac
