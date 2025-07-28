#!/bin/bash
SH=/bin/bash
TERMINAL=/usr/bin/foot
EDITOR=/usr/bin/nvim

INPUT=$(cat -)

case "$1" in
base64)
  ${TERMINAL} ${SH} -c "echo $INPUT | base64 -d | ${EDITOR}"
  ;;
*)
  exit 1
  ;;
esac
