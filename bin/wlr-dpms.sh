#!/bin/bash

LOCK=${XDG_RUNTIME_DIR}/wlr-dpms.lock

case "$1" in
--off)
  COUNT=$(pgrep sway -xc)

  if [[ $COUNT != 1 ]]; then
    rm ${LOCK} &>/dev/null || true
    touch ${LOCK}

    exit
  fi

  wlr-randr --json | jq ".[] | select(.enabled==true) | .name" >${LOCK}
  cat ${LOCK} | xargs -I OUTPUT wlopm --off OUTPUT
  brightnessctl -s
  ;;

--on)
  if [[ -s "$LOCK" ]]; then
    cat ${LOCK} | xargs -I OUTPUT wlopm --on OUTPUT
    sleep 0.5 && brightnessctl -r
  fi
  ;;

*)
  exit 1
  ;;

esac
