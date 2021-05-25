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

export XSECURELOCK_NO_COMPOSITE=1
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=0
export XSECURELOCK_PASSWORD_PROMPT=asterisks
export XSECURELOCK_FONT="Hack:style=Regular:size=12"

picom &
x11-fix-clipboard.sh &

T=600; xset s $T $T dpms $T $T $T
exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr

pkill clipmenud
