#!/bin/bash

case "$1" in
	icons)
		gsettings set org.gnome.desktop.interface icon-theme $2
		gconftool-2 --set /desktop/gnome/interface/icon_theme --type string $2
		;;

	font)
		gsettings set org.gnome.desktop.interface font-name $2
		;;

  theme)
		gconftool-2 --set --type string /desktop/gnome/interface/gtk_theme $2
		;;

	*)
		echo "Error"
esac
