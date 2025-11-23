
systemctl --user import-environment DISPLAY
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# autorandr -c --force

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/geoclue-2.0/demos/agent &
/usr/lib/gsd-xsettings &
picom &

sleep 0.5

export MOZ_USE_XINPUT2=1
export MOZ_X11_EGL=1
export LIBINPUT_GESTURES_TTY=$(cat /sys/class/tty/tty0/active)
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_ENABLE_HIGHDPI_SCALING=1
export QT_QPA_PLATFORMTHEME=qt6ct

T=1800; xset s $T $T dpms $T $T $T
xset r rate 300 30

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[ -f ~/.xprofile ] && . ~/.xprofile

exec i3
