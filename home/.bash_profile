[[ -f ~/.bashrc ]] && . ~/.bashrc

# set PATH so it includes user's private bin if it exists
[[ -d ${HOME}/bin ]]        &&  PATH="${HOME}/bin:${PATH}"
[[ -d ${HOME}/.local/bin ]] &&  PATH="${HOME}/.local/bin:${PATH}"

# ENV -------------------------------------------------------------------------
export BEMENU_OPTS="--fn 'hack 11' -B 1 -i"
export MOZ_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=auto
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME=qt5ct
# export KWIN_DRM_DISABLE_TRIPLE_BUFFERING=1

# -----------------------------------------------------------------------------
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  sway
  echo "Logout after 3 sec." && sleep 3 && exit
fi
