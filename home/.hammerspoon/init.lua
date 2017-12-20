hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
	hs.alert.show('test alert')
end)

-- setup animations params
hs.window.animationDuration = 0

----------------------------------------------------
-- apps runner
----------------------------------------------------
hs.hotkey.bind({"alt", "shift"}, "t", function()
	hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"alt", "shift"}, "e", function()
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

	if (frame.w == win_size.w and frame.h == win_size.h) then
		w_frame = win:frame()
		w_frame.w = frame.w / 1.3
		w_frame.h = frame.h / 1.3
		win:setFrame(w_frame)
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
hs.grid.setMargins({0, 0})

hs.grid.ui.highlightColor = {0,0.8,0.5,0.2}
hs.grid.ui.cyclingHighlightColor = {0,0.8,0.5,0.2}

hs.grid.ui.textSize = 100
hs.grid.ui.cellStrokeWidth = 3
hs.grid.ui.highlightStrokeWidth = 1

hs.grid.ui.showExtraKeys = false

--hs.grid.setGrid('16x9', '2560x1440')
--hs.grid.setGrid('32x18', '2560x1440')

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
--[[hs.window.switcher.ui.highlightColor = {0.4,0.4,0.8,0.8}]]
--hs.window.switcher.ui.backgroundColor = {0.3,0.3,0.3,0.0}

--hs.window.switcher.ui.showThumbnails = false
--hs.window.switcher.ui.showSelectedThumbnail = false
--hs.window.switcher.ui.showSelectedTitle = false
--hs.window.switcher.ui.showTitles = false
--hs.window.switcher.ui.thumbnailSize = 128

--switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) include minimized/hidden windows, current Space only

--hs.hotkey.bind({'alt'}, 'tab', function()
	--switcher:next()
--[[end)]]

----------------------------------------------------
-- choosers for minimized to dock windows
----------------------------------------------------
-- callback func for selected window
local min_windows_chooser = hs.chooser.new(function(windows_choices)
	if not (windows_choices == nil) then
		local window = hs.window.find(windows_choices['id'])
		window:unminimize()
		window:focus()
	end
end)

-- chooser params
min_windows_chooser:searchSubText(true)
min_windows_chooser:bgDark(true)

-- window filter
curr_space_wf = hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}
all_wf = hs.window.filter.new():setDefaultFilter{}

-- bind hotkey
hs.hotkey.bind({"alt", "shift"}, "i", function()
	local windows_choices = {}
	
	-- windows from filter -> chooser
	for k,window in pairs(curr_space_wf:getWindows()) do
		if window:isMinimized() then 
			table.insert(windows_choices, {
				["text"] = window:application():name(),
				["subText"] = window:title(),
				["id"] = window:id()
			})
		end
	end
	
	-- show chooser
	min_windows_chooser:choices(windows_choices)
	min_windows_chooser:show() 
end)

hs.hotkey.bind({"alt", "shift"}, "a", function()
	local windows_choices = {}
	
	-- windows from filter -> chooser
	for k,window in pairs(all_wf:getWindows()) do
		table.insert(windows_choices, {
			["text"] = window:application():name(),
			["subText"] = window:title(),
			["id"] = window:id()
		})
	end
	
	-- show chooser
	min_windows_chooser:choices(windows_choices)
	min_windows_chooser:show() 
end)

----------------------------------------------------
-- ??? 
----------------------------------------------------
-- dec size
--[[hs.hotkey.bind({"alt", "shift"}, ",", function()]]
  --local win = hs.window.focusedWindow()
  --local f = win:frame()
	--local screen = win:screen()
  --local max = screen:frame()
	--local offset = 30

  --f.w = f.w - offset
  --f.h = f.h - offset
	--if max.x < f.x then f.x = f.x + offset / 2 end
	--if max.y < f.y then f.y = f.y + offset / 2 end

  --win:setFrame(f)
--[[end)]]

-- inc size
--[[hs.hotkey.bind({"alt", "shift"}, ".", function()]]
  --local win = hs.window.focusedWindow()
  --local f = win:frame()
	--local screen = win:screen()
  --local max = screen:frame()
	--local offset = 30

  --f.w = f.w + offset
  --f.h = f.h + offset 
	--if max.x < f.x then f.x = f.x - offset / 2 end
	--if max.y < f.y then f.y = f.y - offset / 2 end
  
	--win:setFrame(f)
--[[end)]]

