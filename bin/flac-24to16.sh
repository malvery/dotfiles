#!/bin/sh

for flac in *.flac;
do
	echo "Resampling audio file: $flac"
	sox "$flac" -b 16 resampled.flac && mv resampled.flac "$flac" && echo "done \n" 
done
