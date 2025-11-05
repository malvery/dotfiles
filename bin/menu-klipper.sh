#!/bin/bash

qdbus6 org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardHistoryMenu | bemenu -l 20 -p clipboard | wl-copy -n
