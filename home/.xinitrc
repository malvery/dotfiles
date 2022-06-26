[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

systemctl --user import-environment DISPLAY
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

picom &
xmousepasteblock &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# /usr/lib/geoclue-2.0/demos/agent &
/usr/lib/gsd-xsettings &
sleep 0.5

[ -f ~/.xprofile ] && . ~/.xprofile

T=600; xset s $T $T dpms $T $T $T
exec i3
