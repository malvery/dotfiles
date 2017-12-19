hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
	hs.alert.show(hs.application.runningApplications())
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

-- hide to dock
hs.hotkey.bind({"alt", "shift"}, "i", function()
  local win = hs.window.focusedWindow()
	win:minimize()
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
hs.hotkey.bind({"alt", "shift"}, "w", function()
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


-- windows switch -----------------------------------
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

--  -----------------------------------
local chooser = hs.chooser.new(function(choice)
	if not (choice == nil) then
		--hs.alert.show(choice['text'])
		local window = hs.window.find(choice['id'])
		window:unminimize()
		window:focus()
	end
end)

chooser:searchSubText(true)
chooser:bgDark(true)

wf_min = hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}
hs.hotkey.bind({"alt", "ctrl"}, "i", function()
	local choices = {}
	for k,v in pairs(wf_min:getWindows()) do
		if v:isMinimized() then 
			table.insert(choices, {
				["text"] = v:application():name(),
				["subText"] = v:title(),
				["id"] = v:id()
			})
		end
	end

	chooser:choices(choices)
	chooser:show() 
end)
