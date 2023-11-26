[[ -f ~/.bashrc ]] && . ~/.bashrc

# set PATH so it includes user's private bin if it exists
[[ -d ${HOME}/bin ]]        &&  PATH="${HOME}/bin:${PATH}"
[[ -d ${HOME}/.local/bin ]] &&  PATH="${HOME}/.local/bin:${PATH}"

# ENV -------------------------------------------------------------------------
export BEMENU_OPTS="--fn 'hack 11' -B 1 -i"
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME=qt5ct

export XSECURELOCK_NO_COMPOSITE=1
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=0
export XSECURELOCK_PASSWORD_PROMPT=asterisks
export XSECURELOCK_FONT="Hack:style=Regular:size=12"

export WINIT_X11_SCALE_FACTOR=1

# -----------------------------------------------------------------------------
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  # sway
  startx
  echo "Logout after 3 sec." && sleep 3 && exit
fi
