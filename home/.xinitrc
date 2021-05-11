[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

systemctl --user import-environment DISPLAY
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

export CM_SELECTIONS=clipboard
export CM_DIR=${HOME}/.local/share/clipmenud
export CM_MAX_CLIPS=100
export CM_HISTLENGTH=15
export CM_LAUNCHER=rofi

picom &
x11-fix-clipboard.sh &
exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
pkill clipmenud
