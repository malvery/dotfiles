[[ -f ~/.bashrc ]] && . ~/.bashrc

# set PATH so it includes user's private bin if it exists
[[ -d ${HOME}/bin ]]        &&  ${PATH}="${HOME}/bin:${PATH}"
[[ -d ${HOME}/.local/bin ]] &&  ${PATH}="${HOME}/.local/bin:${PATH}"

# graphic session
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec ~/.config/sway/run.sh
  # startx

  echo "Logout after 10 sec." && sleep 10 && exit
fi
