local helpers = require("helpers")
local vicious = require("vicious")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

-- ############################################################################################

if helpers.hostname == "xps9570" then
    wifi_device     =   "wlp59s0"
    thermal_zone    =   "hwmon2"
    thermal_source  =   "hwmon" 

elseif helpers.hostname == "NB-ZAVYALOV2" then
    wifi_device     =   "wlp59s0"
    thermal_zone    =   "hwmon2"
    thermal_source  =   "hwmon"
end

-- ############################################################################################
-- clock
time_widget = wibox.widget.textclock(" %a %b %d, %H:%M:%S ", 1)

-- ############################################################################################
-- cpu
cpu_widget = wibox.widget.textbox()
vicious.register(cpu_widget, vicious.widgets.cpu, "  CPU: $1%  ")

-- ############################################################################################
-- mem
mem_widget = wibox.widget.textbox()
vicious.register(mem_widget, vicious.widgets.mem, "MEM: $1%  ", 10)

-- ############################################################################################
-- thermal
thermal_widget = wibox.widget.textbox()
vicious.register(thermal_widget, vicious.widgets.thermal, "TH: $1°C  ", 10, {thermal_zone, thermal_source})


-- ############################################################################################
-- eth
wifi_widget = wibox.widget.textbox() 
vicious.register(wifi_widget, vicious.widgets.wifi, "WLAN: ${linp}%  ", 5, wifi_device)

-- ############################################################################################
-- volume
vol_widget = wibox.widget.textbox() 
vicious.register(vol_widget, vicious.widgets.volume, "VOL: $1%  ", 2, {"Master", "-D", "pulse"})

helpers.setVolumeWidget(vol_widget)
vol_widget:buttons(gears.table.join(
	awful.button({ }, 3, function()
		helpers.volume("toggle")
	end),
	awful.button({ }, 4, function()
		helpers.volume("+")
	end),
	awful.button({ }, 5, function()
		helpers.volume("-")
	end)
))

-- ############################################################################################
-- batt
bat_widget = wibox.widget.textbox()
vicious.register(bat_widget, vicious.widgets.bat, "DIS: $5W  BAT: $2%  :: ", 5, "BAT0")

bat_widget:buttons(gears.table.join(
	awful.button({ }, 4, function()
		backlight("inc")
	end),
	awful.button({ }, 5, function()
		backlight("dec")
	end)
))

-- ############################################################################################

return {
    time_widget     =   time_widget,
    cpu_widget      =   cpu_widget,
    mem_widget      =   mem_widget,
    thermal_widget  =   thermal_widget,
    wifi_widget     =   wifi_widget,
    vol_widget      =   vol_widget,
    bat_widget      =   bat_widget,
}