[[ -f ~/.bashrc ]] && . ~/.bashrc

# set PATH so it includes user's private bin if it exists
[[ -d ${HOME}/bin ]]        &&  PATH="${HOME}/bin:${PATH}"
[[ -d ${HOME}/.local/bin ]] &&  PATH="${HOME}/.local/bin:${PATH}"

# ENV -------------------------------------------------------------------------
export BEMENU_OPTS="--fn 'hack 11' -B 1 -i"
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct

export MOZ_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=auto

# export WLR_RENDER_NO_EXPLICIT_SYNC=1
# export WLR_SCENE_DISABLE_DIRECT_SCANOUT=1
export WLR_RENDERER=vulkan

# -----------------------------------------------------------------------------
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  sway

  echo "Stop flatpak apps..."
  flatpak ps | awk '{print $3}' | uniq | xargs -n 1 flatpak kill
  pkill hypridle
  echo "Logout after 3 sec." && sleep 3 && exit
fi
