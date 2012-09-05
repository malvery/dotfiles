#!/bin/sh

for ape in *.ape;
do
	wav=`echo $ape | cut -f1 -d.`.wav
	mac "$ape" $wav -d
	flac $wav
	rm $wav
done
