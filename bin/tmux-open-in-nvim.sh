#!/bin/bash
SH=/bin/bash
INPUT=$(cat -)

case "$1" in
base64)
  ${TERMINAL} -e ${SH} -c "echo $INPUT | base64 -d | ${EDITOR}"
  ;;
json)
  ${TERMINAL} -e ${SH} -c "echo $INPUT | jq | ${EDITOR}"
  ;;
*)
  exit 1
  ;;
esac
