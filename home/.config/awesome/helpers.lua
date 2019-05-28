local awful = require("awful")
local naughty = require("naughty")

-- ############################################################################################

function printNotify(text)
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

function runCmdSync(cmd)
	local prog = io.popen(cmd)
	local result = prog:read('*all')
	prog:close()
	return result
end

-- ############################################################################################

function backlight(action)
	if action == "inc" then
		awful.spawn.with_shell("light -A 2")
	elseif action == "dec" then
		awful.spawn.with_shell("light -U 2")
	end
end

local vol_widget_t = nil
function setVolumeWidgetTimer(timer) vol_widget_t = timer end

function volume(action)
	-- if action == "+" or action == "-" then
	-- 	awful.spawn.with_shell("amixer -D pulse set Master 2%" .. action .. " unmute")
	-- elseif action == "toggle" then
	-- 	awful.spawn.with_shell("amixer -D pulse set Master toggle")
	-- end
	
	if action == "+" or action == "-" then
		awful.spawn.with_shell("pulsemixer --change-volume " .. action .. "2")
	elseif action == "toggle" then
		awful.spawn.with_shell("pulsemixer --toggle-mute")
	end

	-- if vol_widget_t then vol_widget_t.timeout = 0 end
end

-- ############################################################################################

return {
	hostname	=	getHostName(),
	printNotify	=	printNotify,
	runOnce		=	runOnce,
	backlight	=	backlight,
	volume		=	volume,
	setVolumeWidgetTimer	=	setVolumeWidgetTimer,
}
