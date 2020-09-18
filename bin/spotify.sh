#!/bin/bash
LD_PRELOAD=/usr/lib/spotify-adblock.so:/usr/lib/spotifywm.so /usr/bin/spotify "$@"
