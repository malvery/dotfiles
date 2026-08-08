[[ -f ~/.bashrc ]] && . ~/.bashrc

# set PATH so it includes user's private bin if it exists
[[ -d ${HOME}/bin ]]        &&  PATH="${HOME}/bin:${PATH}"
[[ -d ${HOME}/.local/bin ]] &&  PATH="${HOME}/.local/bin:${PATH}"

# -----------------------------------------------------------------------------
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  # ---------------------------------------------------------------------------
  export BEMENU_OPTS="--fn 'hack 11' -B 1 -i"
  export _JAVA_AWT_WM_NONREPARENTING=1
  export TERMINAL='foot'

  export MOZ_ENABLE_WAYLAND=1
  export ELECTRON_OZONE_PLATFORM_HINT=auto
  export GTK_THEME=Breeze-Dark

  # ---------------------------------------------------------------------------
  export QT_QPA_PLATFORMTHEME=qt6ct
  export WLR_RENDERER=vulkan
  # export WLR_DRM_NO_ATOMIC=1
  # export WLR_RENDER_NO_EXPLICIT_SYNC=1

  export XDG_CURRENT_DESKTOP=sway
  sway

  echo "Stop session..."
  systemctl --user stop graphical-session.target

  # ---------------------------------------------------------------------------
  # export KWIN_DRM_DISABLE_TRIPLE_BUFFERING=1
  # /usr/libexec/plasma-dbus-run-session-if-needed /usr/bin/startplasma-wayland

  # ---------------------------------------------------------------------------
  echo "Logout after 3 sec." && sleep 3 && exit
fi
