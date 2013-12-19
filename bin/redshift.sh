#!/bin/sh
killall SIGHKILL redshift && sleep 3
redshift -l 53.36:58.99 -m vidmode -t 5500:4000
