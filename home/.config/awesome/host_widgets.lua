local helpers = require("helpers")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local capi = {awesome = awesome}

-- ############################################################################################

if helpers.hostname == "xps9570" then
    wifi_device     =   "wlp59s0"
	thermal_chip	=	"coretemp-isa-0000"

elseif helpers.hostname == "NB-ZAVYALOV2" then
    wifi_device     =   "wlp3s0"
	thermal_chip	=	"coretemp-isa-0000"
end

-- local color_h	=	'#FF0000'
local color_h	=	'#FF5500'
local color_m	=	'#FFAE00'
local color_g	=	'#A8FF00'
local color_n	=	beautiful.fg_normal

-- ############################################################################################
-- clock
time_widget = wibox.widget.textclock(" %a %b %d, %H:%M:%S ", 1)

-- ############################################################################################
-- cpu
cpu_widget =  awful.widget.watch('bash -c "echo $[100-$(vmstat 1 2|tail -1|awk \'{print $15}\')]"', 5,
	function(widget, stdout)
		val = tonumber(stdout)
		if val > 80 then color = color_h elseif val > 30 then color = color_m else color = color_n end
		widget:set_markup(string.format(' <span color="%s">CPU: %.0f%%  </span>', color, val))
	end
)

-- ############################################################################################
-- mem
mem_widget =  awful.widget.watch('bash -c "free | grep Mem | awk \'{print $3/$2 * 100.0}\'"', 5,
	function(widget, stdout)
		val = tonumber(stdout)
		if val > 90 then color = color_h elseif val > 60 then color = color_m else color = color_n end
		widget:set_markup(string.format('<span color="%s">MEM: %.0f%%  </span>', color, val))
	end
)

-- ############################################################################################
-- thermal
thermal_widget =  awful.widget.watch(
	string.format('bash -c "sensors -u %s | grep temp1_input | awk \'{print $2}\'"', thermal_chip), 5,
	function(widget, stdout)
		val = tonumber(stdout)
		if val > 75 then color = color_h elseif val > 50 then color = color_m else color = color_n end
		widget:set_markup(string.format('<span color="%s">TH: %.0f°C  </span>', color, val))
	end
)

-- ############################################################################################
-- wifi
wifi_widget =  awful.widget.watch(
	string.format('bash -c "cat /proc/net/wireless | grep %s | awk \'{ print int($3 * 100 / 70) }\'"', wifi_device), 5,
	function(widget, stdout)
		val = tonumber(stdout)
		if not val then val = 0 end
		if val < 40 then color = color_h elseif val < 80 then color = color_m else color = color_g end
		widget:set_markup(string.format('<span color="%s">WIFI: %.0f%%  </span>', color, val))
end)

-- ############################################################################################
-- volume
vol_widget, vol_widget_t =  awful.widget.watch(
	'bash -c "amixer -D pulse get Master | grep \'Left:\'  | awk -F \'[][]\' \'{print $2 $4}\'"', 2,
	function(widget, stdout)
		values = {}
		for str in string.gmatch(stdout, "([^%%]+)") do table.insert(values, str) end
		if values[1] then vol_v = tonumber(values[1]) else vol_v = 0 end
		vol_s = values[2]

		if vol_v >= 50 then color = color_m else color = color_n end
		if vol_s:match("off") then color = color_h end

		widget:set_markup(string.format('<span color="%s">VOL: %.0f%%  </span>', color, vol_v))
end)

helpers.setVolumeWidgetTimer(vol_widget_t)
vol_widget:buttons(gears.table.join(
	awful.button({ }, 3, function()	helpers.volume("toggle")	end),
	awful.button({ }, 4, function()	helpers.volume("+")			end),
	awful.button({ }, 5, function()	helpers.volume("-")			end)
))

-- ############################################################################################
-- batt
local power_supply = '/sys/class/power_supply/' .. 'BAT0'

power_widget =  awful.widget.watch(string.format('cat %s/current_now', power_supply), 5, function(widget, stdout)
	val = tonumber(stdout) / 100000
	if val > 40 then color = color_h else color = color_n end
	widget:set_markup(string.format('<span color="%s">PC: %.1fW</span>  ', color, val))
end)

bat_widget =  awful.widget.watch(string.format('cat %s/capacity', power_supply), 15, function(widget, stdout)
	val = tonumber(stdout)
	if val < 35 then color = color_h elseif val < 70 then color = color_m else color = color_g end
	widget:set_markup(string.format('<span color="%s">BAT: %.0f%%</span>  ', color, val))
end)

bat_widget:buttons(gears.table.join(
	awful.button({ }, 4, function() backlight("inc") end),
	awful.button({ }, 5, function() backlight("dec") end)
))

-- ############################################################################################
-- keyboard layout
keyboard_widget = wibox.widget.textbox()

local dbus_cmd = 'dbus-send --print-reply=literal --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.getCurrentLayout'
local kbdd_locales = {[0] = 'EN', [1] = 'RU'}
capi.awesome.connect_signal("xkb::group_changed", function ()
	awful.spawn.easy_async(dbus_cmd, function(stdout, stderr, reason, exit_code)
		kbdd_value = tonumber(string.match(stdout, ' %d+'))
		keyboard_widget.markup = string.format('<span color="%s">%s</span>  ', color_m, kbdd_locales[kbdd_value])
		-- keyboard_widget.text = '  ' .. kbdd_locales[kbdd_value] .. ' '
	end)
end)

-- ############################################################################################

return {
    time_widget     =   time_widget,
    cpu_widget      =   cpu_widget,
    mem_widget      =   mem_widget,
    thermal_widget  =   thermal_widget,
    wifi_widget     =   wifi_widget,
    vol_widget      =   vol_widget,
	bat_widget		=	bat_widget,
	power_widget	=	power_widget,
	keyboard_widget	=	keyboard_widget
}
