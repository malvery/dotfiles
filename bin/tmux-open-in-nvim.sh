#!/bin/bash
# cat -
INPUT=$(cat -)


case "$1" in
  base64)
    INPUT=$(echo ${INPUT} | base64 -d)
    ;;
  *)
    exit 1
    ;;
esac

foot /bin/bash -c "/usr/bin/echo ${INPUT} | /usr/bin/nvim"
