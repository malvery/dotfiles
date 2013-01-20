#!/bin/bash
#SYNC_DIR=$HOME/sync
#for args in $*
#do
#	if find $args | grep $HOME/ &> /dev/null
#	then
#		ARG_DIR=`dirname $args | sed "s/\/home\/malvery//"`
#		mkdir -p  $SYNC_DIR/test/home$ARG_DIR
#		cp -R $args $SYNC_DIR/test/home$ARG_DIR
#	else
#		cp -R $args $SYNC_DIR/test/etc/
#	fi
#done
cd ~/sync
git add .
git commit -a -m "`date`" 
git push
