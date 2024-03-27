#!/bin/bash
#
set -e
BASE="gsettings set org.gnome"

###############################################################################
# settings
###############################################################################

CMD=${BASE}.desktop.input-sources
${CMD} mru-sources  "[('xkb', 'us')]"
${CMD} per-window   true
${CMD} sources      "[('xkb', 'us'), ('xkb', 'ru')]"
${CMD} xkb-options  "['grp:caps_toggle']"


CMD=${BASE}.desktop.interface
${CMD} color-scheme             'prefer-dark'
${CMD} font-antialiasing        'rgba'
${CMD} font-hinting             'slight'
${CMD} gtk-theme                'adw-gtk3-dark'
${CMD} monospace-font-name      'Hack 11'
${CMD} show-battery-percentage  true


CMD=${BASE}.desktop.peripherals.touchpad
${CMD} tap-to-click                 true
${CMD} two-finger-scrolling-enabled true


CMD=${BASE}.settings-daemon.plugins.power
${CMD} power-button-action          'interactive'
${CMD} sleep-inactive-ac-type       'nothing'
${CMD} sleep-inactive-battery-type  'nothing'

###############################################################################
# hotkeys
###############################################################################

CMD=${BASE}.desktop.wm.keybindings
${CMD} begin-resize                   "['<Shift><Super>r']"
${CMD} cycle-windows                  "['<Alt>Escape']"
${CMD} cycle-windows-backward         "['<Alt><Super>Escape']"
${CMD} move-to-workspace-1            "['<Super><Shift>1']"
${CMD} move-to-workspace-2            "['<Super><Shift>2']"
${CMD} move-to-workspace-3            "['<Super><Shift>3']"
${CMD} move-to-workspace-4            "['<Super><Shift>4']"
${CMD} move-to-workspace-5            "['<Super><Shift>5']"
${CMD} move-to-workspace-6            "['<Super><Shift>6']"
${CMD} move-to-workspace-7            "['<Super><Shift>7']"
${CMD} move-to-workspace-8            "['<Super><Shift>8']"
${CMD} move-to-workspace-9            "['<Super><Shift>9']"
${CMD} switch-applications            "['<Alt>Tab']"
${CMD} switch-applications-backward   "['<Shift><Alt>Tab']"
${CMD} switch-group                   "['<Alt>grave']"
${CMD} switch-group-backward          "['<Shift><Alt>grave']"
${CMD} switch-to-workspace-1          "['<Super>1']"
${CMD} switch-to-workspace-2          "['<Super>2']"
${CMD} switch-to-workspace-3          "['<Super>3']"
${CMD} switch-to-workspace-4          "['<Super>4']"
${CMD} switch-to-workspace-5          "['<Super>5']"
${CMD} switch-to-workspace-6          "['<Super>6']"
${CMD} switch-to-workspace-7          "['<Super>7']"
${CMD} switch-to-workspace-8          "['<Super>8']"
${CMD} switch-to-workspace-9          "['<Super>9']"
${CMD} switch-windows                 "['<Super>Tab']"
${CMD} switch-windows-backward        "['<Shift><Super>Tab']"
${CMD} toggle-fullscreen              "['<Shift><Super>f']"
${CMD} toggle-maximized               "['<Shift><Super>m']"


CMD=${BASE}.shell.keybindings
${CMD} switch-to-application-1  "@as []"
${CMD} switch-to-application-2  "@as []"
${CMD} switch-to-application-3  "@as []"
${CMD} switch-to-application-4  "@as []"
${CMD} switch-to-application-5  "@as []"
${CMD} switch-to-application-6  "@as []"
${CMD} switch-to-application-7  "@as []"
${CMD} switch-to-application-8  "@as []"
${CMD} switch-to-application-9  "@as []"

CMD=${BASE}.mutter
${CMD} overlay-key  'Super_R'


CMD=${BASE}.settings-daemon.plugins.media-keys
${CMD} home     "['<Shift><Super>e']"
${CMD} search   "['<Super>r']"
# ${CMD} custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"


# CMD=${BASE}.settings-daemon.plugins.media-keys.custom-keybindings.custom0
# ${CMD} binding  '<Shift><Super>Return'
# ${CMD} command  'foot'
# ${CMD} name     'foot'

###############################################################################
# extensions
###############################################################################

# CMD=${BASE}.shell
# ${CMD} enabled-extensions "['gnome-shell-go-to-last-workspace@github.com', 'disable-workspace-animation@ethnarque', 'dash-to-dock@micxgx.gmail.com', 'auto-move-windows@gnome-shell-extensions.gcampax.github.com', 'GPaste@gnome-shell-extensions.gnome.org', 'super-key@tommimon.github.com']"


CMD=${BASE}.GPaste
${CMD} open-centered              false
${CMD} show-history               "<Super>grave"
${CMD} sync-clipboard-to-primary  ''
${CMD} sync-primary-to-clipboard  ''
${CMD} track-changes              true
${CMD} track-extension-state      true
${CMD} upload                     ''


# CMD=${BASE}.shell.extensions.auto-move-windows
# ${CMD} application-list "['firefox.desktop:2', 'org.mozilla.Thunderbird.desktop:3', 'org.gnome.Evolution.desktop:3', 'org.telegram.desktop.desktop:3']"

