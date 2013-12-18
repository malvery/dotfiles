#!/bin/sh

case $1 in
	halt)
		zenity --question --text "Are you sure you want to halt?" && sudo halt
		;;
  reboot)
    zenity --question --text "Are you sure you want to reboot?" && sudo reboot
    ;;
  suspend)
    zenity --question --text "Are you sure you want to suspend?" && sudo pm-suspend
    ;;
  logout)
    zenity --question --text "Are you sure you want to logout?" && awesome-client
    ;;
  lock)
    gnome-screensaver-command -l
    ;;
esac
