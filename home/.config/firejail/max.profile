# Firejail profile for mattermost-desktop
# This file is overwritten after every install/update
# Persistent local customizations
include max.local
# Persistent global definitions
include globals.local

# Disabled until someone reported positive feedback
ignore apparmor
ignore dbus-user none
ignore dbus-system none

env XDG_CURRENT_DESKTOP=GNOME
env NO_AT_BRIDGE=1
# env QT_USE_PHYSICAL_DPI=1
env QT_AUTO_SCREEN_SCALE_FACTOR=1
env QT_ENABLE_HIGHDPI_SCALING=1

include disable-shell.inc

mkdir ${HOME}/.config/MAX
mkdir ${HOME}/.local/share/ONEME

whitelist ${HOME}/.config/MAX
whitelist ${HOME}/.cache/MAX
whitelist ${HOME}/.local/share/ONEME
whitelist /usr/share/max
whitelist ${HOME}/Camera
whitelist ${HOME}/Downloads
whitelist ${HOME}/Pictures/Screenshots

private-etc alternatives,ca-certificates,crypto-policies,fonts,ld.so.cache,ld.so.conf,ld.so.conf.d,ld.so.preload,machine-id,nsswitch.conf,pki,resolv.conf,ssl

ignore noexec ${HOME}

# Not tested
dbus-user filter
dbus-user.talk org.freedesktop.Notifications
dbus-user.talk org.kde.StatusNotifierWatcher
dbus-user.talk org.freedesktop.portal.Desktop
dbus-user.talk org.freedesktop.secrets
dbus-user.talk org.a11y.Bus
dbus-system none

# Redirect
include electron-common.profile
