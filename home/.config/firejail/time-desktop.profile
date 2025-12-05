# Firejail profile for mattermost-desktop
# This file is overwritten after every install/update
# Persistent local customizations
include time-desktop.local
# Persistent global definitions
include globals.local

# Disabled until someone reported positive feedback
ignore apparmor
ignore dbus-user none
ignore dbus-system none

noblacklist ${HOME}/.config/TiMe

include disable-shell.inc

mkdir ${HOME}/.config/TiMe
whitelist ${HOME}/.config/TiMe
whitelist ${HOME}/src/time-desktop
whitelist ${HOME}/Pictures
whitelist ${HOME}/Downloads

private-etc alternatives,ca-certificates,crypto-policies,fonts,ld.so.cache,ld.so.conf,ld.so.conf.d,ld.so.preload,machine-id,nsswitch.conf,pki,resolv.conf,ssl

ignore noexec ${HOME}

# Not tested
dbus-user filter
dbus-user.own com.mattermost.Desktop
dbus-user.talk org.freedesktop.Notifications
dbus-user.talk org.kde.StatusNotifierWatcher
dbus-user.talk org.freedesktop.portal.Desktop
dbus-system none

# Redirect
include electron-common.profile
