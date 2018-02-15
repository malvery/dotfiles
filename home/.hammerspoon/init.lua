-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
-- 	hs.alert.show('test alert')
-- end)

-- setup animations params
hs.window.animationDuration = 0

----------------------------------------------------
-- apps runner
----------------------------------------------------
hs.hotkey.bind({"alt", "shift"}, "t", function()
	hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"alt", "shift"}, "p", function()
	hs.application.launchOrFocus("Finder")
end)

----------------------------------------------------
-- window actions
----------------------------------------------------
-- close
hs.hotkey.bind({"alt", "shift"}, "c", function()
	local win = hs.window.focusedWindow()
	win:close()
end)

-- maximize
hs.hotkey.bind({"alt", "shift"}, "m", function()
	local win = hs.window.focusedWindow()
	local frame = win:screen():frame()
	local win_size = win:size()
	local win_frame = win:frame()

	if (frame.w == win_size.w and frame.h == win_size.h) then
		if (frame.x ~= win_frame.x or frame.y ~= win_frame.y) then
			hs.grid.maximizeWindow(win)
		else
			w_frame = win:frame()
			w_frame.w = frame.w / 1.3
			w_frame.h = frame.h / 1.3
			win:setFrame(w_frame)
		end
	else
		hs.grid.maximizeWindow(win)
		--win:maximize()
	end
end)

-- toggle fullscreen
hs.hotkey.bind({"alt", "shift"}, "f", function()
	local win = hs.window.focusedWindow()
	--win:toggleZoom()
	win:toggleFullScreen()
end)

-- center
hs.hotkey.bind({"alt", "shift"}, "return", function()
	local win = hs.window.focusedWindow()
	local frame = win:screen():frame()
	local win_size = win:size()

	if not (frame.w == win_size.w and frame.h == win_size.h) then
		win:centerOnScreen()
	end
end)

----------------------------------------------------
-- GRID
----------------------------------------------------
--- grid params
hs.grid.setGrid('5x4')
hs.grid.setMargins({0, 0})

hs.grid.ui.highlightColor = {0,0.8,0.5,0.2}
hs.grid.ui.cyclingHighlightColor = {0,0.8,0.5,0.2}
hs.grid.ui.textSize = 100
hs.grid.ui.cellStrokeWidth = 3
hs.grid.ui.highlightStrokeWidth = 1
hs.grid.ui.showExtraKeys = false

-- show grid selector
hs.hotkey.bind({"alt", "shift"}, "g", function()
	hs.grid.toggleShow()
end)

-- resize
hs.hotkey.bind({"alt", "shift"}, "h", function()
	local win = hs.window.focusedWindow()
	hs.grid.resizeWindowThinner(win)
end)
hs.hotkey.bind({"alt", "shift"}, "j", function()
	local win = hs.window.focusedWindow()
	hs.grid.resizeWindowTaller(win)
end)
hs.hotkey.bind({"alt", "shift"}, "k", function()
	local win = hs.window.focusedWindow()
	hs.grid.resizeWindowShorter(win)
end)
hs.hotkey.bind({"alt", "shift"}, "l", function()
	local win = hs.window.focusedWindow()
	hs.grid.resizeWindowWider(win)
end)

-- move
hs.hotkey.bind({"alt", "ctrl"}, "h", function()
	local win = hs.window.focusedWindow()
	hs.grid.pushWindowLeft(win)
end)
hs.hotkey.bind({"alt", "ctrl"}, "j", function()
	local win = hs.window.focusedWindow()
	hs.grid.pushWindowUp(win)
end)
hs.hotkey.bind({"alt", "ctrl"}, "k", function()
	local win = hs.window.focusedWindow()
	hs.grid.pushWindowDown(win)
end)
hs.hotkey.bind({"alt", "ctrl"}, "l", function()
	local win = hs.window.focusedWindow()
	hs.grid.pushWindowRight(win)
end)


----------------------------------------------------
-- windows switcher
----------------------------------------------------
-- hs.window.switcher.ui.highlightColor = {0.4,0.4,0.8,0.8}
-- hs.window.switcher.ui.backgroundColor = {0.3,0.3,0.3,0.0}
--
-- hs.window.switcher.ui.showThumbnails = false
-- hs.window.switcher.ui.showSelectedThumbnail = false
-- hs.window.switcher.ui.showSelectedTitle = false
-- hs.window.switcher.ui.showTitles = false
-- hs.window.switcher.ui.thumbnailSize = 128
--
-- switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})
-- hs.hotkey.bind({'alt'}, 'tab', function()
-- 	switcher:next()
-- end)

----------------------------------------------------
-- choosers for minimized to dock windows
----------------------------------------------------
-- callback func for selected window
local windows_chooser = hs.chooser.new(function(windows_choices)
	if not (windows_choices == nil) then
		local window = hs.window.find(windows_choices['id'])

		window:unminimize()
		window:focus()
	end
end)

-- chooser params
windows_chooser:searchSubText(true)
windows_chooser:bgDark(true)

-- window filter
curr_space_wf = hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}

-- bind hotkey
hs.hotkey.bind({"alt", "shift"}, "i", function()
	local windows_choices = {}

	-- windows from filter -> chooser
	for k,window in pairs(curr_space_wf:getWindows()) do
		if window:isMinimized() then
			table.insert(windows_choices, {
				["text"] = window:application():name(),
				["subText"] = window:title(),
				["id"] = window:id(),
			})
		end
	end

	-- show chooser
	windows_chooser:choices(windows_choices)
	windows_chooser:show()
end)

----------------------------------------------------
-- workspaces - dynamic
----------------------------------------------------
local spaces = require("hs._asm.undocumented.spaces")

function get_key_for_value(t, value)
	for k,v in pairs(t) do
		if v==value then
			return k
		end
	end
	return nil
end

function get_current_layout()
	local win = hs.window.focusedWindow()
	local uuid = win:screen():spacesUUID()
	local layout = spaces.layout()[uuid]

	-- local layout_parsed = {}
	-- for k,v in pairs(layout) do
	-- 	layout_parsed[v] = k
	-- end

	return layout
end

last_space_id = 1
curr_space_id = 1

space_watcher = hs.spaces.watcher.new(function(space_id)
	last_space_id = curr_space_id
	curr_space_id = get_key_for_value(get_current_layout(), spaces.activeSpace())
end)
space_watcher:start()

hs.hotkey.bind({"alt"}, "ESCAPE", function()
	hs.eventtap.keyStroke({'alt'}, tostring(last_space_id))
end)

hs.hotkey.bind({"alt"}, "g", function()
	hs.eventtap.keyStroke({'alt'}, tostring(#get_current_layout() - 1))
end)

hs.hotkey.bind({"alt"}, "s", function()
	hs.eventtap.keyStroke({'alt'}, tostring(#get_current_layout()))
end)

----------------------------------------------------
-- workspaces - static
----------------------------------------------------
-- local spaces = require("hs._asm.undocumented.spaces")
--
-- LAST_SPACE_ID = 1
-- CURR_SPACE_ID = 1
--
-- function get_current_screen_layout()
-- 	local uuid = hs.screen.mainScreen():spacesUUID()
-- 	local layout = spaces.layout()[uuid]
--
-- 	local layout_parsed = {}
-- 	for k,v in pairs(layout) do
-- 		layout_parsed[v] = k
-- 	end
--
-- 	return layout_parsed
-- end
--
-- SCREEN_LAYOUT = get_current_screen_layout()
-- space_watcher = hs.spaces.watcher.new(function(space_id)
-- 	LAST_SPACE_ID = CURR_SPACE_ID
-- 	CURR_SPACE_ID = SCREEN_LAYOUT[spaces.activeSpace()]
-- 	-- SCREEN_LAYOUT = get_current_screen_layout()
-- end)
-- space_watcher:start()
--
-- hs.hotkey.bind({"alt"}, "ESCAPE", function()
-- 	hs.eventtap.keyStroke({'alt'}, tostring(LAST_SPACE_ID))
-- end)
--
-- DESKTOP_G = tostring(#SCREEN_LAYOUT - 2)
-- hs.hotkey.bind({"alt"}, "g", function()
-- 	hs.eventtap.keyStroke({'alt'}, DESKTOP_G)
-- end)
--
-- DESKTOP_S = tostring(#SCREEN_LAYOUT - 1)
-- hs.hotkey.bind({"alt"}, "s", function()
-- 	hs.eventtap.keyStroke({'alt'}, DESKTOP_S)
-- end)

----------------------------------------------------
-- resize window
----------------------------------------------------
-- -- dec size
-- hs.hotkey.bind({"alt", "shift"}, ",", function()
-- 	local win = hs.window.focusedWindow()
--
-- 	hs.grid.resizeWindowThinner(win)
-- 	hs.grid.resizeWindowShorter(win)
-- end)
--
-- -- inc size
-- hs.hotkey.bind({"alt", "shift"}, ".", function()
-- 	local win = hs.window.focusedWindow()
--
-- 	hs.grid.resizeWindowTaller(win)
-- 	hs.grid.resizeWindowWider(win)
-- end)

----------------------------------------------------
-- helpers
----------------------------------------------------

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
