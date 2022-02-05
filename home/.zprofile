export PATH=$PATH:~/.local/bin
export GOPATH=~/src/go

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  # exec ~/.config/sway/run.sh
  startx
  echo "Logout after 10 sec." && sleep 10 && exit
fi

