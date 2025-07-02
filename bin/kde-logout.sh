#!/bin/bash
set -e

kdialog --title "Logout" --warningyesno "Logout session?"

pkill -u ${USER} chromium
qdbus6 org.kde.Shutdown /Shutdown logout
