local awful = require("awful")
--local naughty = require("naughty")

-- ############################################################################################

--function printNotify(text)
--    naughty.notify({text = text})
--end

function getHostName()
	local f = io.popen("/bin/hostname")
	local hostname = f:read("*a") or ""
	f:close()
	hostname = string.gsub(hostname, "\n$", "")

	return hostname
end

function runOnce(cmd, sleep)
	findme = cmd
	firstspace = cmd:find(" ")
	if firstspace then
		findme = cmd:sub(0, firstspace-1)
	end
	
	if sleep ~= nil then
		cmd = "sleep " .. tostring(sleep) .. " && " .. cmd
	end

	awful.spawn.with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")", false)
end

function runCmdSync(cmd)
	local prog = io.popen(cmd)
	local result = prog:read('*all')
	prog:close()
	return result
end

-- ############################################################################################

local vol_widget_t = nil
function setVolTimer(timer) vol_widget_t = timer end

local battery_t = nil
function setBatteryT(tooltip, command)
	battery_t = {
		["tooltip"] = tooltip,
		["command"] = command
	}
end

function setTooltip(widget, command)
	local tooltip = awful.tooltip({
		preferred_alignments = "middle",
		objects = {widget},
		mode = "outside",
		margins = 8,
	})

	widget:connect_signal("mouse::enter", function()
		awful.spawn.easy_async_with_shell(command, function(stdout)
			tooltip.text = stdout:gsub("\n$", "")
		end)
	end)

	return tooltip
end


-- ############################################################################################

function backlight(action)
	if action == "inc" then
		command = "light -A 2"
	elseif action == "dec" then
		command = "light -U 2"
	end

	awful.spawn.easy_async_with_shell(command, function()
		if battery_t then 
			awful.spawn.easy_async_with_shell(battery_t.command, function(stdout)
				battery_t.tooltip.text = stdout:gsub("\n$", "")
			end)
		end
	end)
end

function volume(action)
	if action == "inc" then
		command = "pamixer -i 2"
	elseif action == "dec" then
		command = "pamixer -d 2"
	elseif action == "toggle" then
		command = "pamixer -t"
	end

	awful.spawn.easy_async_with_shell(command, function()
		if vol_widget_t then vol_widget_t:emit_signal("timeout") end
	end)
end

-- ############################################################################################

function promptRun (message, command)
	awful.prompt.run {
	  prompt	   = message .. " (type 'yes' to confirm) ",
	  textbox	   = awful.screen.focused().mypromptbox.widget,
	  exe_callback = function (t)
		 if string.lower(t) == "yes" then
			awesome.emit_signal("exit", nil)
			if type(command) == "function"
				then command()
				else awful.spawn(command)
			end
		 end
	  end,
	  completion_callback = function (t, p, n)
		 return awful.completion.generic(t, p, n, {"no", "NO", "yes", "YES"})
	  end
   }
end

local function nonEmptyTag (direction)
	local s	= awful.screen.focused()
	local function onlyMinimizedClients(clients)
		for k, c in pairs(clients) do
			if not c.minimized then return false end
		end
		return true
	end
	
	if direction == 1 then last = #s.tags else last = 1 end
	for i = s.selected_tag.index + direction, last, direction do
		local clients = s.tags[i]:clients()
		if #clients > 0 and not onlyMinimizedClients(clients) then
			s.tags[i]:view_only()
			return
		end
	end
end


-- ############################################################################################

return {
	hostname	=	getHostName(),
	printNotify	=	printNotify,
	runOnce		=	runOnce,
	backlight	=	backlight,
	volume		=	volume,
	promptRun	=	promptRun,
	nonEmptyTag	=	nonEmptyTag,
	setVolTimer	=	setVolTimer,
	setTooltip	=	setTooltip,
	setBatteryT	=	setBatteryT,
}
