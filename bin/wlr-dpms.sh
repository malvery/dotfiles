#!/bin/bash

LOCK=${XDG_RUNTIME_DIR}/wlr-dpms.lock

case "$1" in
--off)
  COUNT=$(pgrep sway -xc)

  if [[ $COUNT != 1 ]]; then
    echo >${LOCK}
    exit
  fi

  wlr-randr --json | jq ".[] | select(.enabled==true) | .name" >${LOCK}
  cat ${LOCK} | xargs -I OUTPUT wlopm --off OUTPUT
  ;;

--on)
  cat ${LOCK} | xargs -I OUTPUT wlopm --on OUTPUT
  ;;

*)
  exit 1
  ;;

esac
