#!/bin/bash

curr=$(powerprofilesctl get)

case "$1" in
  --next)

      case "$curr" in
        power-saver)
            powerprofilesctl set balanced
          ;;
        balanced)
            powerprofilesctl set performance
          ;;
      esac

    ;;

  --prev)

      case "$curr" in
        performance)
            powerprofilesctl set balanced
          ;;
        balanced)
            powerprofilesctl set power-saver
          ;;
      esac

    ;;

  *)
    case "$curr" in
      power-saver)
        echo S
        echo "#FE8600"
        ;;
      balanced)
        echo "B"
        echo "#86AD85"
        ;;
      performance)
        echo P
        echo "#FF5500"
        ;;
      *)
        echo "NULL"
        ;;
    esac
    exit 0
    ;;
esac

pkill -USR1 py3status
