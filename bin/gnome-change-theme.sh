#!/bin/bash

case "$1" in
	icons)
		gsettings set org.gnome.desktop.interface icon-theme $2
		;;

	font)
		gsettings set org.gnome.desktop.interface font-name $2
		;;

 # theme)
		#echo "test2"
		#;;

	#decorations)
		#echo "test2"
		#;;

	*)
		echo "Error"
esac
