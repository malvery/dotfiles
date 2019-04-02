local naughty = require("naughty")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local helpers = require("helpers")
local theme_assets = require("beautiful.theme_assets")

-- ############################################################################################
local HOSTNAME = helpers.hostname

local APPS = {
			["terminal"]			=	"lxterminal",
			["lock_manager"]	=	"slock",
			["file_manager"]	=	"pcmanfm",
			["browser"]				=	"firefox",
}

local TITLEBAR_SIZE = 22
if HOSTNAME == "NB-ZAVYALOV2" then
	TITLEBAR_SIZE = 30
end

-- ############################################################################################
-- Theme
function initTheme()
	beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
	beautiful.useless_gap	= 1

	local color_f = "#285577"
	local color_n = "#5f676a"
	local color_u = "#FF5500"

	beautiful.bg_focus = color_f
	beautiful.fg_focus = beautiful.fg_normal

	-- menu icon
	beautiful.awesome_icon = theme_assets.awesome_icon(
    beautiful.menu_height, beautiful.bg_normal , beautiful.fg_focus
	)

	-- urgent
	beautiful.bg_urgent = beautiful.bg_normal
	beautiful.fg_urgent = color_u

	-- borders
	beautiful.border_focus = color_f
	beautiful.border_normal = color_n

	-- tasklist
	beautiful.tasklist_fg_focus = '#d3d7cf'
	beautiful.tasklist_bg_focus = beautiful.bg_normal

	beautiful.fg_minimize   = beautiful.bg_minimize
	beautiful.bg_minimize   = beautiful.bg_normal

	-- titlebar
	beautiful.titlebar_bg_focus = color_f
	beautiful.titlebar_bg_normal = beautiful.bg_normal

	-- notifications
	beautiful.notification_bg = color_f
	beautiful.notification_fg = "#ffffff"
	beautiful.notification_border_color = "#aaaaaa"

	-- disable default wallpaper
	beautiful.wallpaper = nil
	gears.wallpaper.set("#1e231f")

	if HOSTNAME == "xps9570" then
		beautiful.xresources.set_dpi(128)
		beautiful.font			= "Ubuntu Bold 9"
		beautiful.border_width	= 3
		beautiful.wibar_height	= 22

		beautiful.notification_width = 300
		beautiful.systray_icon_spacing = 2

	elseif HOSTNAME == "NB-ZAVYALOV2" then
		beautiful.xresources.set_dpi(170)
		beautiful.font			= "Ubuntu Medium 10"
		beautiful.border_width	= 5
		beautiful.wibar_height	= 35

		beautiful.notification_max_width = 600
	end
end

-- ############################################################################################
-- Menu
function getMenu()
	awesome_menu = {
		{"Restart", awesome.restart},
		{"Exit", function() awesome.quit() end}
	}

	exit_menu = {
		{"Shutdowm", "systemctl poweroff"},
		{"Reboot", "systemctl reboot"},
		{"Suspend", "systemctl suspend"},
	}

	main_menu = awful.menu({
		items = {
			{"Awesome", awesome_menu, beautiful.awesome_icon},
			{"Applications", "rofi -no-click-to-exit -me-select-entry '' -me-accept-entry 'MousePrimary' -show drun"},
			{"File Manager", APPS.file_manager},
			{"Calculator", "gnome-calculator"},
			{"Terminal", APPS.terminal},
			{"System", exit_menu},
			{"Lock", APPS.lock_manager}
		}
	})

	return main_menu
end

-- ############################################################################################
-- Hotkeys
function getHotkeys()
		hotkeys = gears.table.join(
			awful.key({ modkey,           }, "r",		function () awful.spawn('rofi -show run')		end),
			awful.key({ modkey, "Shift"   }, "d",		function () awful.spawn('rofi -show windowcd')	end),
			awful.key({ modkey, "Shift"   }, "p",		function () awful.spawn(APPS.file_manager)		end),
			awful.key({ modkey, "Shift"   }, "F12",		function () awful.spawn(APPS.lock_manager)		end),

			awful.key({ }, "XF86AudioRaiseVolume",	function () helpers.volume("+")			end),
			awful.key({ }, "XF86AudioLowerVolume",	function () helpers.volume("-")			end),
			awful.key({ }, "XF86AudioMute",			function () helpers.volume("toggle")	end),
			awful.key({ }, "XF86MonBrightnessUp",	function () helpers.backlight("inc")	end),
			awful.key({ }, "XF86MonBrightnessDown",	function () helpers.backlight("dec")	end),

			awful.key({ modkey,           }, "Up",		function () awful.client.focus.bydirection("up")	end),
			awful.key({ modkey,           }, "Down",	function () awful.client.focus.bydirection("down")	end),
			awful.key({ modkey,           }, "Left",	function () awful.client.focus.bydirection("left")	end),
			awful.key({ modkey,           }, "Right",	function () awful.client.focus.bydirection("right")	end),

			awful.key({ modkey,           }, "s",	function () awful.screen.focused().tags[9]:view_only()	end),
			awful.key({ modkey,           }, "g",	function () awful.screen.focused().tags[8]:view_only()	end),

			awful.key({ modkey,  "Shift"  }, "/", 		hotkeys_popup.show_help),
			awful.key({ 'Ctrl',           }, "space",	naughty.destroy_all_notifications)
	)

	if HOSTNAME == "xps9570" then
	elseif HOSTNAME == "NB-ZAVYALOV2" then
	end

	return hotkeys
end

-- ############################################################################################
-- Tags layouts
function getLayouts()
	layouts = {}
	for i = 1, 9 do layouts[i] = awful.layout.suit.tile end

	layouts[2] = awful.layout.suit.max

	if HOSTNAME == "NB-ZAVYALOV2" then
		layouts[3] = awful.layout.suit.max
		layouts[4] = awful.layout.suit.max
		layouts[5] = awful.layout.suit.max
		layouts[8] = awful.layout.suit.max
	end

	return layouts
end

-- ############################################################################################
-- Client rules
function getClientRules(client_rules)
	client_rules = gears.table.join(client_rules, {
		{ rule_any = {
        class = {
					"Nm-connection-editor",
					"Shutter",
					"Google Play Music Desktop Player",
					"Chromium-browser",
					"Chromium",
					"Pavucontrol",
					"Nitrogen"
        }
			}, properties = {floating = true}},

		{rule_any	= {type	= {"normal"}},				properties = {titlebars_enabled = false}},
		{rule		= {class = "Gnome-calculator"},	properties = {floating = true, ontop = true}},
		{rule		= {class = "flameshot"},				properties = {floating = true, ontop = true}},
		{rule		= {class = "Thunderbird"},			properties = {screen = 1, tag = "9",
				callback=function(c)
					awful.client.setslave(c)
					awful.tag.incmwfact(0.05, c.first_tag)
				end,
		}},
	})

	if HOSTNAME == "xps9570" then
		client_rules = gears.table.join(client_rules, {
			{rule = {class = "TelegramDesktop"},	properties = {screen = 1, tag = "9"}},
		})
	elseif HOSTNAME == "NB-ZAVYALOV2" then
		client_rules = gears.table.join(client_rules, {
			{rule = {class = "TelegramDesktop"},	properties = {screen = 1, tag = "8", floating = true}},
			{rule = {class = "Slack"},						properties = {screen = 1, tag = "9"}},
		})
	end

	return client_rules
end

-- ############################################################################################
-- Autostart
function initAutostart()
	apps_list = {
		'xsettingsd',
		'clipit',
		'redshift-gtk',
		'nm-applet',
		'blueman-applet',
		'xss-lock -- ' .. APPS.lock_manager,
		'libinput-gestures-setup start',
		'pasystray',
	}
	if HOSTNAME == "xps9570" then
		awful.spawn.with_shell('setxkbmap -layout "us,ru" -option grp:caps_toggle')
		apps_list = gears.table.join(apps_list, {
			'compton --backend glx --vsync -f -D 2',
			'telegram-desktop',
			'thunderbird',
		})
	elseif HOSTNAME == "NB-ZAVYALOV2" then
		awful.spawn.with_shell('setxkbmap -layout "us,ru(mac)" -option grp:caps_toggle')
		apps_list = gears.table.join(apps_list, {
			'pulseaudio --start',
			'compton --backend glx --vsync opengl -f -D 2',
			'thunderbird',
			'slack',
			'flameshot'
		})
	end

	awful.spawn.with_shell('nitrogen --restore')
	for i, app_name in ipairs(apps_list) do helpers.runOnce(app_name) end

	awful.spawn.with_shell('kbdd')
end

-- ############################################################################################

return {
	apps			=	APPS,
	titlebar_size		= TITLEBAR_SIZE,
	initTheme				=	initTheme,
	initAutostart		=	initAutostart,
	getMenu					=	getMenu,
	getHotkeys			=	getHotkeys,
	getLayouts			=	getLayouts,
	getClientRules	=	getClientRules
}
