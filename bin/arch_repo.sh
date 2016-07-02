#!/bin/bash

cd ~/sync
echo `pwd`

cat etc/pacman.conf >> /etc/pacman.conf


pacman-key -r 962DDE58
pacman-key --lsign-key 962DDE58
