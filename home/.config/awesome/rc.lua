-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

vicious = require("vicious")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")
--beautiful.init("/home/malvery/.config/awesome/themes/default.lua")
beautiful.init("/home/malvery/.config/awesome/themes/arc.lua")
--beautiful.init("/home/malvery/.config/awesome/themes/sl-dark.lua")
theme.wallpaper = "/home/malvery/pictures/wallpapers/setka-linii-tekstura-seryy.jpg"

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
		awful.layout.suit.max,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and add in main menu

awful.util.spawn_with_shell("xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu >~/.config/awesome/archmenu.lua")
xdg_menu = require("archmenu")

myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
	 { "quit", awesome.quit },
   { "restart", awesome.restart }
}

--[[exit_menu = {
	 { "Logout", awesome.quit },
	 { "Suspend", "systemctl suspend" },
	 { "Reboot", "systemctl reboot" },
	 { "Shutdowm", "systemctl poweroff" }
}]]

mymainmenu = awful.menu({ items = { 
		{ "Awesome", myawesomemenu, beautiful.awesome_icon },
		{ "Apps", xdgmenu	},	

		{ "" },
		{ "Browser", "chromium" },
		{ "URXvt", "urxvt" },
		{ "HTop", "urxvt -e htop" },
		
		{ "" },
		{ "Lock", "slimlock" },
		--{ "Exit", exit_menu }
		{ "Exit", "/home/malvery/bin/logout_dialog.sh" }
  }
})

mylauncher = awful.widget.launcher(
	{ 
		image = beautiful.awesome_icon,
    menu = mymainmenu 
	}
)


-- {{{ Wibox
-- Custom widget
-- kbdd
kbdwidget = wibox.widget.textbox("| LANG: Eng ")
kbdwidget.border_width = 1
kbdwidget.border_color = beautiful.fg_normal
kbdwidget:set_text(" ::  LANG: Eng ")

kbdstrings = {[0] = " ::  LANG: Eng ", 
              [1] = " ::  LANG: Rus "}

dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.connect_signal("ru.gentoo.kbdd", function(...)
    local data = {...}
    local layout = data[2]
    kbdwidget:set_markup(kbdstrings[layout])
    end
)

-- mem
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, " MEM: $1% |", 13)

-- cpu
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, " | CPU: $1% |")

-- volume
volwidget = wibox.widget.textbox() 
vicious.register(volwidget, vicious.widgets.volume, " VOL: $1% :: ", 2, "Master")

volwidget_tip = awful.tooltip({ objects = { volwidget }})
function volume(action)
	if action == "+" or action == "-" then
		awful.util.spawn("amixer -D pulse set Master 5%" .. action .. " unmute")
	elseif action == "toggle" then
		awful.util.spawn("amixer -D pulse set Master toggle")
	end

	volwidget_tip:set_text(awful.util.pread("~/bin/widget_volume.sh"))
end

volwidget:connect_signal(
	"mouse::enter",
	function() 
		volwidget_tip:set_text(awful.util.pread("~/bin/widget_volume.sh")) 
	end
)

volwidget:buttons(awful.util.table.join(
	awful.button({ }, 3, function()
		volume("toggle")
	end),
	awful.button({ }, 4, function()
		volume("+")
	end),
	awful.button({ }, 5, function()
		volume("-")
	end)
))
-- network
netwidget = wibox.widget.textbox() 
vicious.register(netwidget, vicious.widgets.net, " NET: ${enp1s0f0 down_kb}Kb/s |", 13)

netwidget_tip = awful.tooltip({ objects = { netwidget }})
netwidget:connect_signal(
	"mouse::enter",
	function() 
		netwidget_tip:set_text(awful.util.pread("~/bin/widget_network.sh desktop")) 
	end
)
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    		
		right_layout:add(kbdwidget)
		right_layout:add(cpuwidget)
		right_layout:add(memwidget)
		right_layout:add(netwidget)
		right_layout:add(volwidget)
		
		if s == 1 then right_layout:add(wibox.widget.systray()) end

		right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    --awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    --awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, "Shift"   }, "m", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),



    -- Standard program
    awful.key({ modkey, "Shift"   }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Shift"   }, "r", awesome.restart),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Shift"   }, "n", awful.client.restore),

		-- Custom hotkeys
	  awful.key({ modkey, "Shift"   }, "p",			function () awful.util.spawn("pcmanfm") end),
		awful.key({ modkey, "Shift"   }, "F12",			function () awful.util.spawn("slimlock") end),

		awful.key({	}, "XF86AudioRaiseVolume",	function () awful.util.spawn("amixer -D pulse set Master 5%+ unmute") end),
		awful.key({ }, "XF86AudioLowerVolume",	function () awful.util.spawn("amixer -D pulse set Master 5%- unmute") end),
		awful.key({ }, "XF86AudioMute",					function () awful.util.spawn("amixer -D pulse set Master toggle") end),
		
		-- Custom client manipulation
		awful.key({ modkey,           }, "Up",		function () awful.client.focus.bydirection("up")		end),	
		awful.key({ modkey,           }, "Down",	function () awful.client.focus.bydirection("down")	end),
		awful.key({ modkey,           }, "Left",	function () awful.client.focus.bydirection("left")	end),	
		awful.key({ modkey,           }, "Right",	function () awful.client.focus.bydirection("right")	end),

		awful.key({ modkey,           }, "s",	function () awful.tag.viewonly(awful.tag.gettags(2)[9])	end),
		awful.key({ modkey,           }, "g",	function () awful.tag.viewonly(awful.tag.gettags(1)[9])	end),



		-- Screen manipulation
		--awful.key({ modkey,           }, "[",			function () awful.screen.focus_relative(-1) end),	
		--awful.key({ modkey,           }, "]",			function () awful.screen.focus_relative( 1) end),
		--awful.key({ modkey, "Shift"   }, "[",			function (c) awful.client.movetoscreen(c, -1) end),
		--awful.key({ modkey, "Shift"   }, "]",			function (c) awful.client.movetoscreen(c,  1) end),

		awful.key({ modkey,           }, "w",			function () awful.screen.focus_relative(-1) end),	
		awful.key({ modkey,           }, "e",			function () awful.screen.focus_relative( 1) end),
		awful.key({ modkey, "Shift"   }, "w",			function (c) awful.client.movetoscreen(c, -1) end),
		awful.key({ modkey, "Shift"   }, "e",			function (c) awful.client.movetoscreen(c,  1) end),

    -- Prompt
    --awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end)
		awful.key({ modkey },            "r",     function () awful.util.spawn("gmrun") end)
		--awful.key({ modkey },            "F2",     function () awful.util.spawn("dmenu-launch") end)

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()			                   end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey,           }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),

    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Kmix" },
      properties = { floating = true } },
		{ rule = { class = "VirtualBox" },
      properties = { floating = true } },
		{ rule = { class = "Xfce4-appfinder" },
      properties = { floating = true } },
    { rule = { class = "Skype" },
      properties = { floating = true } },
    { rule = { class = "Shutter" },
      properties = { floating = true } },
    
	  { rule = { name = "tmux-main" },
      properties = { tag = tags[2][1] } },

    { rule = { class = "VirtualBox" },
      properties = { tag = tags[1][0] } },
    { rule = { class = "Shutter" },
      properties = { tag = tags[1][0] } },
    { rule = { class = "Skype" },
      properties = { tag = tags[2][9] } },
		{ rule = { class = "transmission" },
      properties = { tag = tags[2][7] } },
		
		{ rule = { class = "Krdc" },
      properties = { tag = tags[2][3] } },
		{ rule = { class = "Clementine" },
      properties = { tag = tags[2][8] } },

	 --[[ { rule = { class = "chromium" },]]
      --[[properties = { tag = tags[1][3] } },]]
		{ rule = { class = "chromium" },
      properties = { tag = tags[1][2] } },
    { rule = { class = "google-chrome" },
      properties = { tag = tags[1][3] } },
    
		{ rule = { class = "Thunderbird" },
      properties = { tag = tags[1][9] } },
		{ rule = { class = "Firefox" },
      properties = { tag = tags[1][2] } },
    }
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

--{{ Custom functions

--}}

awful.util.spawn_with_shell("compton")
--awful.util.spawn_with_shell("kbdd")

-- Autostart

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once('/home/malvery/bin/urxvt.sh')
run_once('nm-applet')
run_once('numlockx')
run_once('clipit')
run_once('pulseaudio --start')
run_once('redshift-gtk')
run_once('google-chrome-stable --incognito')
run_once('chromium')
run_once('thunderbird')
run_once('skype')
run_once('shutter --min_at_startup')
run_once('clementine')
--run_once('pycharm')

awful.util.spawn_with_shell("killall kbdd || true")
awful.util.spawn_with_shell("kbdd")

-- }}}
