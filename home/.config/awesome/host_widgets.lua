local helpers = require("helpers")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local capi = {awesome = awesome}
local awpwkb = require("awpwkb")

-- ############################################################################################

conf = {
  ["thermal"] = {
    ["device"]  = 'coretemp-isa-0000',
    ["hight"]   = 75,
    ["medium"]  = 50
  },
  ["power"] = {
    ["device"]    = 'BAT0',
    ["critical"]  = 10
  },
  ["batt"] = {
    ["capacity"]    = 'capacity',
    ["power_now"]   = 'current_now',
    ["charge_now"]  = 'charge_now',
    ["charge_full"] = 'charge_full',
    ["multiplier"]  = 100000
  }
}

if helpers.hostname == "NB-ZAVYALOV2" then
  conf.thermal.hight  = 85
  conf.thermal.medium = 60
  conf.power.critical = 25

elseif helpers.hostname == "ux533f" then
  conf.batt.power_now   = "power_now"
  conf.batt.charge_now  = "energy_now"
  conf.batt.charge_full = "energy_full"
  conf.batt.multiplier  = 1000000
end

local color_n = beautiful.fg_normal
--local color_n = "#86AD85"
--local color_n = "#A8A8A8"
--local color_g = '#AFAF02'
local color_g = "#86AD85"
local color_m = '#FFAE00'
local color_h = '#FF5500'
local color_i = '#888888'

--local w_sep = '<span color="#888888"> | </span>'
local w_sep = '  '

-- ############################################################################################
-- clock
time_widget = wibox.widget.textclock(w_sep .. "%a %b %d, %H:%M:%S" .. w_sep, 1)

-- ############################################################################################
-- cpu
cpu_widget =  awful.widget.watch(
  'bash -c "echo $[100-$(vmstat 1 2|tail -1|awk \'{print $15}\')]"', 5,
  function(widget, stdout)
    val = tonumber(stdout)
    if      val > 80 then color = color_h
    elseif  val > 30 then color = color_m
    else  color = color_n end

    widget:set_markup(string.format(
      w_sep .. '<span color="%s">CPU: %.0f%%</span>' .. w_sep, color, val
    ))
end)

-- ############################################################################################
-- mem
mem_widget =  awful.widget.watch(
  'bash -c "free | grep Mem | awk \'{print $3/$2 * 100.0}\'"', 5,
  function(widget, stdout)
    val = tonumber(stdout)
    if      val > 90 then color = color_h
    elseif  val > 60 then color = color_m
    else  color = color_n end

    widget:set_markup(string.format(
      '<span color="%s">MEM: %.0f%%</span>' .. w_sep, color, val
    ))
end)

-- ############################################################################################
-- thermal
thermal_widget =  awful.widget.watch(
  string.format('bash -c "sensors -u %s | grep temp1_input | awk \'{print $2}\'"', conf.thermal.device), 5,
  function(widget, stdout)
    val = tonumber(stdout)

    if      val > conf.thermal.hight then color = color_h
    elseif  val > conf.thermal.medium then color = color_m
    else  color = color_n end

    widget:set_markup(string.format(
      '<span color="%s">TH: %.0f°C</span>' .. w_sep, color, val
    ))
end)

-- tooltip
local thermal_t = helpers.setTooltip(thermal_widget, "sensors | grep -i 'RPM'")

-- ############################################################################################
-- wifi
wifi_widget =  awful.widget.watch(
  'bash -c "cat /proc/net/wireless | tail -n 1 | awk \'{ print int($3 * 100 / 70) }\'"', 5,
  function(widget, stdout_w)
    awful.spawn.easy_async_with_shell("ip tuntap show | wc -l", function(stdout_ip)
      val = tonumber(stdout_w)
      --if not val then
      if val == 0 then
        widget:set_markup(string.format(
          '<span color="%s">WIFI: Down</span>' .. w_sep, color_h
        ))
        return
      end

      if    val < 40 then color = color_h
      elseif  val < 80 then color = color_m
      else  color = color_g end

      vpn_prefix = ''
      vpn_count = stdout_ip:gsub("\n$", "")

      if vpn_count ~= "0" then
        vpn_prefix = ' ^VPN'
      end

      widget:set_markup(string.format(
        '<span color="%s">WIFI: %.0f%%%s</span>' .. w_sep, color, val, vpn_prefix
      ))
    end)
end)

-- tooltip
local wifi_t = helpers.setTooltip(
  wifi_widget,
  'printf "$(iwgetid | sed -e \"s/:/:\\t/\" -e \"s/\\"//g\")\\n'
    .. '$(iwgetid -f)\\n'
    .. '$(iwgetid -c)" | '
    .. 'cut -f 1 -d " " --complement | '
    .. 'sed -e "s/^ *//" -e "s/:/:\\t/"'
)

-- ############################################################################################
-- volume
if helpers.hostname == "nbubnt185" then
  vol_widget, vol_widget_t =  awful.widget.watch(
    'pamixer --get-mute --get-volume', 2,
    function(widget, stdout)
      values = {}
      for str in string.gmatch(stdout, "([^  ]+)") do table.insert(values, str) end
      if values[2] then vol_v = tonumber(values[2]) else vol_v = 0 end
      vol_s = values[1]

      if      vol_v < 35 then color = color_n
      elseif  vol_v < 70 then color = color_m
      else    color = color_h end

      if vol_s:match("true") then
        widget:set_markup(string.format(
          '<span color="%s">VOL: Mute</span>' .. w_sep, color_i
        ))
        return
      end

      widget:set_markup(string.format(
        '<span color="%s">VOL: %.0f%%</span>' .. w_sep, color, vol_v
      ))
  end)

else
  vol_widget, vol_widget_t =  awful.widget.watch(
    'bash -c "(pactl get-sink-volume @DEFAULT_SINK@; pactl get-sink-mute @DEFAULT_SINK@)'
      .. ' | awk \'NR==1{a=$5}NR==3{print a,$2}\'"', 2,
    function(widget, stdout)
      values = {}
      for str in string.gmatch(stdout, "([^  ]+)") do table.insert(values, str) end

      if values[1] then
        vol_v = tonumber(values[1]:sub(1,-2))
      else
        vol_v = 0
      end

      vol_s = values[2]

      if vol_v < 35 then
        color = color_n
      elseif vol_v < 70 then
        color = color_m
      else
        color = color_h
      end

      if vol_s:match("yes") then
        widget:set_markup(string.format(
          '<span color="%s">VOL: Mute</span>' .. w_sep, color_i
        ))
        return
      end

      widget:set_markup(string.format(
        '<span color="%s">VOL: %.0f%%</span>' .. w_sep, color, vol_v
      ))
  end)
end

-- buttons
helpers.setVolTimer(vol_widget_t)
vol_widget:buttons(gears.table.join(
  awful.button({ }, 2, function() awful.spawn('pavucontrol')  end),
  awful.button({ }, 3, function() helpers.volume("toggle")    end),
  awful.button({ }, 4, function() helpers.volume("inc")       end),
  awful.button({ }, 5, function() helpers.volume("dec")       end)
))

-- ############################################################################################
-- batt
local power_supply = '/sys/class/power_supply/' .. conf.power.device
bat_widget =  awful.widget.watch(
  string.gsub(
    string.format(
      'cat $p/%s $p/%s $p/%s $p/%s',
      conf.batt.capacity,
      conf.batt.power_now,
      conf.batt.charge_full,
      conf.batt.charge_now
    ),
    '$p', power_supply), 3, function(widget, stdout)

    val = {}
    for str in stdout:gmatch("([^\n]+)") do
      table.insert(val, str)
    end
    val_c = tonumber(val[1])
    val_p = tonumber(val[2]) / conf.batt.multiplier

    charge_full = tonumber(val[3])
    charge_now = tonumber(val[4])
    if charge_now and charge_full then
      val_c = charge_now / (charge_full / 100)

      if      val_c < 35 then color = color_h
      elseif  val_c < 70 then color = color_m
      else  color = color_g end

      widget:set_markup(string.format(
        '<span color="%s">BAT: %.0f%% ^%.1fW</span>' .. w_sep,
        color, val_c, val_p
      ))
    end
end)

-- tooltip
local bat_t_command = 'echo "Brightness: $(light | cut -d \'.\' -f1)%"'
local bat_t = helpers.setTooltip(bat_widget, bat_t_command)
helpers.setBatteryT(bat_t, bat_t_command)

-- buttons
bat_widget:buttons(gears.table.join(
  awful.button({ }, 4, function() backlight("inc") end),
  awful.button({ }, 5, function() backlight("dec") end)
))

-- ############################################################################################
-- keyboard layout
keyboard_widget = wibox.widget.textbox()
local kbdd_locales = {[0] = 'EN', [1] = 'RU'}

kb = awpwkb.get()
kb.on_layout_change = function (layout)
  keyboard_widget.markup = string.format(
    '<span color="%s">%s</span>' .. w_sep, color_m, kbdd_locales[layout.idx]
  )
end

-- ############################################################################################

return {
  time_widget     = time_widget,
  cpu_widget      = cpu_widget,
  mem_widget      = mem_widget,
  thermal_widget  = thermal_widget,
  wifi_widget     = wifi_widget,
  vol_widget      = vol_widget,
  bat_widget      = bat_widget,
  keyboard_widget = keyboard_widget
}
