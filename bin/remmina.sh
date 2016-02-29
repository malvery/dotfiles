#!/bin/bash
remmina -i &
sleep 2

cd ~/.local/share/remmina
ls -1 *.remmina | while read a; do
	remmina -c ~/.local/share/remmina/$a

       #N=`grep '^name=' "$a" | cut -f2 -d=`;
			 #       [ "$a" == "$N.remmina" ] || mv "$a" "$N".remmina;
done
