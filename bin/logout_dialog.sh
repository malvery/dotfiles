#!/bin/sh

ACTION=`zenity --width=90 --height=160 --list --text="Select logout action" --title="Logout" --column "Action" Lock Suspend Reboot Shutdown`

if [ -n "${ACTION}" ];then
 case $ACTION in
	Lock)
   slimlock
   ;;

	Suspend)
	 slimlock &
   systemctl suspend
   ;;

	Shutdown)
   systemctl poweroff
   ;;
	Reboot)
   systemctl reboot
   ;;
 esac
fi
