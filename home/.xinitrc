[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

systemctl --user import-environment DISPLAY
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

echo "### START"
# autorandr -c --force

echo "### END"

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/geoclue-2.0/demos/agent &
xsettingsd &
picom &

sleep 0.5

export DMENU_ARGS="-i -fn Hack-11"
export MOZ_USE_XINPUT2=1
export XSECURELOCK_NO_COMPOSITE=1
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=0
export XSECURELOCK_PASSWORD_PROMPT=asterisks
export XSECURELOCK_FONT="Hack:style=Regular:size=11"
export LIBINPUT_GESTURES_TTY=$(cat /sys/class/tty/tty0/active)
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_ENABLE_HIGHDPI_SCALING=1

T=1800; xset s $T $T dpms $T $T $T
xset r rate 300 30

[ -f ~/.xprofile ] && . ~/.xprofile

exec i3
