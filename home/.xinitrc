[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

systemctl --user import-environment DISPLAY
dbus-update-activation-environment --systemd DISPLAY
# eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
# export SSH_AUTH_SOCK

picom &
xsettingsd &

export LIBINPUT_GESTURES_TTY=$(cat /sys/class/tty/tty0/active)

[ -f ~/.xprofile ] && . ~/.xprofile

T=3600; xset s $T $T dpms $T $T $T
exec i3
