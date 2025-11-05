#!/bin/bash

if [[ $(pgrep -U $(whoami) -x clipcatd) ]]; then
  pkill -u $(whoami) -x clipcatd

  if [ -f ${XDG_RUNTIME_DIR}/clipcatd.pid ]; then
    rm ${XDG_RUNTIME_DIR}/clipcatd.pid
  fi
fi

clipcatd &
