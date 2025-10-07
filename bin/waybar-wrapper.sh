#!/bin/bash

while true; do
  waybar $@
  exit_status=$?

  echo "... exit code: ${exit_status}"
  echo "$(date): ${exit_status}" >> /tmp/waybar-${USER}.exit


  if [[ ${exit_status} -ne 0 && ${exit_status} -ne 1 && ${exit_status} -ne 137 && ${exit_status} -ne 143 ]]; then
    echo "... restarting waybar"

  else

    echo "... exit"
    break
  fi
done
