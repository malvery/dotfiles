local naughty       = require("naughty")
local awful         = require("awful")
local beautiful     = require("beautiful")
local gears         = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers       = require("helpers")

-- ############################################################################
local HOSTNAME = helpers.hostname

local APPS = {
  ["terminal"]      = "alacritty",
  ["lock_manager"]  = "xsecurelock",
  ["lock_command"]  = "loginctl lock-session",
  ["file_manager"]  = "pcmanfm",
  ["browser"]       = "firefox",
}

local TITLEBAR_SIZE = 22

if HOSTNAME == "nbubnt185" then
  APPS["file_manager"] = "nautilus -w"
  local xdgmenu = {}

else
  -- generate and load applications menu
  local os = require("os")
  os.execute(
    "xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu >"
    .. awful.util.getdir("config")
    .. "/archmenu.lua"
  )
  local xdg_menu = require("archmenu")
end

-- ############################################################################
-- Theme
function initTheme()
  beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
  beautiful.useless_gap = 1

  -- menu
  beautiful.menu_border_width = 1
  beautiful.menu_submenu_icon = nil
  beautiful.menu_submenu      = "> "
  beautiful.menu_height       = 25
  beautiful.menu_width        = 160
  beautiful.menu_border_color = beautiful.fg_normal

  -- tooltips
  beautiful.tooltip_border_color = beautiful.fg_normal
  beautiful.tooltip_border_width = 0.8

  -- disable default wallpaper
  beautiful.wallpaper = nil
  gears.wallpaper.set("#151515")

  -- env
  beautiful.font                    = "Ubuntu Condensed Bold 11"
  beautiful.border_width            = 3
  beautiful.wibar_height            = 20
  beautiful.notification_max_width  = 350
  beautiful.systray_icon_spacing    = 2
end

-- ############################################################################
-- Menu
function getMenu()
  awesome_menu = {
    {"Restart", awesome.restart},
    {"Exit",  function() helpers.promptRun("exit ?", awesome.quit) end}
  }

  exit_menu = {
    {"Suspend",     "systemctl suspend -i"},
    {"Shutdown",  function() helpers.promptRun("shutdown ?",  "systemctl poweroff -i" ) end},
    {"Reboot",    function() helpers.promptRun("reboot ?",    "systemctl reboot -i" ) end},
  }

  main_menu = awful.menu({
    items = {
      {"Awesome",       awesome_menu, beautiful.awesome_icon},
      {"Applications",  xdgmenu},
      {"File Manager",  APPS.file_manager},
      {"System",        exit_menu},
      {"Lock Screen",   APPS.lock_command}
    }
  })

  return main_menu
end

-- ############################################################################
-- Hotkeys
function getHotkeys()
    hotkeys = gears.table.join(
      awful.key({ modkey,         },  "r",    function () awful.spawn('rofi -show run')           end),
      awful.key({ modkey, "Shift" },  "d",    function () awful.spawn('rofi -show drun')          end),
      awful.key({ modkey, "Shift" },  "p",    function () awful.spawn(APPS.file_manager,  false)  end),
      awful.key({ modkey, "Shift" },  "F12",  function () awful.spawn(APPS.lock_command,  false)  end),

      awful.key({ }, "XF86AudioRaiseVolume",  function () helpers.volume("inc")     end),
      awful.key({ }, "XF86AudioLowerVolume",  function () helpers.volume("dec")     end),
      awful.key({ }, "XF86AudioMute",         function () helpers.volume("toggle")  end),
      awful.key({ }, "XF86MonBrightnessUp",   function () helpers.backlight("inc")  end),
      awful.key({ }, "XF86MonBrightnessDown", function () helpers.backlight("dec")  end),

      awful.key({ }, "XF86AudioPlay", function () awful.spawn('playerctl play-pause', false)  end),
      awful.key({ }, "XF86AudioPrev", function () awful.spawn('playerctl previous',   false)  end),
      awful.key({ }, "XF86AudioNext", function () awful.spawn('playerctl next',       false)  end),

      awful.key({ modkey,     }, "Left",  function () awful.client.focus.byidx( -1) end),
      awful.key({ modkey,     }, "Right", function () awful.client.focus.byidx(  1) end),

      awful.key({ modkey,     }, "g", function () awful.screen.focused().tags[8]:view_only()  end),
      awful.key({ modkey,     }, "s", function () awful.screen.focused().tags[9]:view_only()  end),

      awful.key({ modkey, "Shift" }, "/",     hotkeys_popup.show_help),
      awful.key({ 'Ctrl',         }, "space", naughty.destroy_all_notifications),

      -- clipboard
      awful.key({ modkey,     }, "grave", function () awful.spawn.with_shell('clipmenu') end)
  )

  return hotkeys
end

-- ############################################################################
-- Tags layouts
function getLayouts()
  layouts = {}
  for i = 1, 9 do layouts[i] = awful.layout.suit.tile end

  layouts[1] = awful.layout.suit.max
  layouts[2] = awful.layout.suit.max
  layouts[3] = awful.layout.suit.max
  layouts[5] = awful.layout.suit.floating
  layouts[8] = awful.layout.suit.floating
  layouts[9] = awful.layout.suit.floating

  return layouts
end

-- ############################################################################
-- Client rules
function getClientRules(client_rules)
  -- float apps list
  float_apps = {
    "Nm-connection-editor",
    "Com.cisco.anyconnect.gui",
    "Pavucontrol",
    "Blueman-manager",
    "Spotify",
    "qBittorrent",
    "mpv",
    "explorer.exe",
    "zoom"
  }
  float_apps_top = {
    "flameshot",
    "Gcolor3"
  }

  if HOSTNAME == "nbubnt185" then
    client_rules = gears.table.join(client_rules, {
      {
        rule = {class = "Slack"},
        properties = {
          screen = 1, tag = "9",
          placement = awful.placement.no_offscreen + awful.placement.top_left
        }
      },
      { rule = {class = "TelegramDesktop"}, properties = { screen = 1, tag = "8" }}
    })

  else
    client_rules = gears.table.join(client_rules, {
      {
        rule = {class = "TelegramDesktop"},
        properties = {
          screen = 1, tag = "9",
          placement = awful.placement.no_offscreen + awful.placement.top_left
        }
      }
    })

  end

  -- additional settings
  client_rules = gears.table.join(client_rules, {
    { rule = {class = "zoom"},                     properties = { screen = 1, tag = "5" }},
    { rule = {class = "Com.cisco.anyconnect.gui"}, properties = { screen = 1, tag = "8" }},
    {
      rule_any = {class = {"Thunderbird", "Evolution*"}},
      properties = {screen = 1, tag = "9", placement = awful.placement.bottom_right}
    }
  })

  -- set window rules
  client_rules = gears.table.join(client_rules, {
    -- disable titlebars
    {rule_any = {type = {"normal", "dialog"}}, properties = {titlebars_enabled = false}},

    -- set floating
    {rule_any = {class = gears.table.join(float_apps, float_apps_top)},
    properties = {floating = true}},

    -- set on-top
    {rule_any = {class = float_apps_top}, properties = {ontop = true}},
  })

  return client_rules
end

-- ############################################################################################
-- Fixes
client.connect_signal("request::geometry", function(c)
  if client.focus then
    if not client.focus.fullscreen then
      client.focus.border_width = beautiful.border_width
    end
  end
end)

-- ############################################################################################
-- Autostart
function initAutostart()
  awful.spawn.with_shell('setxkbmap -layout "us,ru" -option grp:caps_toggle')
  awful.spawn.with_shell("~/.config/awesome/autostart.sh")

  -- setup tags
  awful.tag.incmwfact(0.05, awful.tag.find_by_name(awful.screen.focused(), "9"))
end

-- ############################################################################

return {
  apps            = APPS,
  titlebar_size   = TITLEBAR_SIZE,
  initTheme       = initTheme,
  initAutostart   = initAutostart,
  getMenu         = getMenu,
  getHotkeys      = getHotkeys,
  getLayouts      = getLayouts,
  getClientRules  = getClientRules
}
