local naughty = require("naughty")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

-- ############################################################################################
function printDebug(text)
    naughty.notify({text = text})
end

function getHostName()
    local f = io.popen("/bin/hostname")
    local hostname = f:read("*a") or ""
    f:close()
    hostname = string.gsub(hostname, "\n$", "")

    return hostname
end

function runOnce(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.spawn.with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- ############################################################################################
local HOSTNAME = getHostName()

local APPS = {
			["terminal"]		= "lxterminal",
			["lock_manager"]	= "light-locker-command -l",
			["file_manager"]    = "pcmanfm",
			["browser"]			= "firefox"
}

-- ############################################################################################
-- Theme
function initTheme()
    beautiful.init(gears.filesystem.get_themes_dir() .. "zenburn/theme.lua")

    if HOSTNAME == "xps9570" then
        beautiful.font = "Ubuntu Bold 9"
        beautiful.border_width = 4
    elseif HOSTNAME == "mbp2016" then
    end
end

-- ############################################################################################
-- Menu
function getMenu()
    awesome_menu = {
        {"open terminal", APPS.terminal},
        {"restart", awesome.restart}
    }

    exit_menu = {
        {"Shutdowm", "systemctl poweroff"},
        {"Reboot", "systemctl reboot"},
        {"Suspend", "systemctl suspend"},
        {"Logout", function() awesome.quit() end}
    }

    main_menu =
        awful.menu(
        {
            items = {
                {"Awesome", awesome_menu, beautiful.awesome_icon},
                {"Exit", exit_menu},
                {"Lock", "light-locker-command -l"}
            }
        }
    )

    return main_menu
end

-- ############################################################################################
-- Hotkeys
function getHotkeys()
    hotkeys = gears.table.join(
        awful.key({ modkey,           }, "r",	function () awful.util.spawn('rofi -show run')  end),
        awful.key({ modkey, "Shift"   }, "d",	function () awful.util.spawn('rofi -show drun') end),

        awful.key({ modkey, "Shift"   }, "p",	function () awful.util.spawn(APPS.file_manager) end),
        awful.key({ modkey, "Shift"   }, "F12",	function () awful.util.spawn(APPS.lock_manager) end),

		-- awful.key({ }, "XF86AudioRaiseVolume",	function () volume("+") end),
		-- awful.key({ }, "XF86AudioLowerVolume",	function () volume("-") end),
		-- awful.key({ }, "XF86AudioMute",			function () volume("toggle") end),

		-- awful.key({ }, "XF86MonBrightnessUp",	function () backlight("inc") end),
        -- awful.key({ }, "XF86MonBrightnessDown",	function () backlight("dec") end)

		awful.key({ modkey,           }, "Up",		function () awful.client.focus.bydirection("up")	end),	
		awful.key({ modkey,           }, "Down",	function () awful.client.focus.bydirection("down")	end),
		awful.key({ modkey,           }, "Left",	function () awful.client.focus.bydirection("left")	end),	
		awful.key({ modkey,           }, "Right",	function () awful.client.focus.bydirection("right")	end),

		awful.key({ modkey,           }, "s",	function () awful.tag.viewonly(awful.tag.gettags(awful.tag.getscreen())[9])	end),
		awful.key({ modkey,           }, "g",	function () awful.tag.viewonly(awful.tag.gettags(awful.tag.getscreen())[8])	end)
    )

    if HOSTNAME == "xps9570" then
        hotkeys = gears.table.join(hotkeys,    awful.key({ modkey,  "Shift"  }, "/",      hotkeys_popup.show_help))
    elseif HOSTNAME == "mbp2016" then
    end

    return hotkeys
end

-- ############################################################################################
-- Client rules
function getClientRules()
end

-- ############################################################################################
-- Autostart
function initAutostart()
    apps_list = {
        'kbdd',
        'xsettingsd',
        'clipit',
        'redshift-gtk',
        'nm-applet',
        'blueman-applet',
        'light-locker',
        'compton --backend glx --vsync opengl -f -D 2',
        'libinput-gestures-setup start',
    }
    if HOSTNAME == "xps9570" then
        awful.spawn('setxkbmap -layout "us,ru" -option grp:caps_toggle')
        apps_list = gears.table.join(apps_list, {
            -- 'thunderbird',
            -- 'telegram-desktop'
        })
    elseif HOSTNAME == "mbp2016" then
    end

    for i, app_name in ipairs(apps_list) do
        runOnce(app_name)
    end
end

-- ############################################################################################

return {
    apps = APPS,
    initTheme = initTheme,
    initAutostart = initAutostart,
    getMenu = getMenu,
    getHotkeys = getHotkeys,
    getClientRules = getClientRules
}
