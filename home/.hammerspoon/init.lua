hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  --hs.alert.show("Hello World!")
	hs.hints.windowHints()
end)

-- setup animations params
hs.window.animationDuration = 0

----------------------------------------------------
-- window actions 
----------------------------------------------------
-- close
hs.hotkey.bind({"alt", "shift"}, "C", function()
  local win = hs.window.focusedWindow()
	win:close()
end)

-- maximize
hs.hotkey.bind({"alt", "shift"}, "m", function()
  local win = hs.window.focusedWindow()
	--win:maximize()
	hs.grid.maximizeWindow(win)
end)

-- toggle fullscreen
hs.hotkey.bind({"alt", "shift"}, "f", function()
  local win = hs.window.focusedWindow()
	--win:toggleZoom()
	win:toggleFullScreen()
end)

-- hide to dock
hs.hotkey.bind({"alt", "shift"}, "h", function()
  local win = hs.window.focusedWindow()
	win:minimize()
end)

-- center
hs.hotkey.bind({"alt", "shift"}, "return", function()
  local win = hs.window.focusedWindow()
	win:centerOnScreen()
end)

----------------------------------------------------
-- GRID 
----------------------------------------------------
--- grid params
hs.grid.setMargins({0, 0})
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


-- resize window ------------------------------------
--[[-- inc size]]
--hs.hotkey.bind({"alt", "shift"}, ".", function()
  --local win = hs.window.focusedWindow()
  --local f = win:frame()

  --f.w = f.w + 15
  --f.h = f.h + 15
  --win:setFrame(f)
--end)

---- dec size
--hs.hotkey.bind({"alt", "shift"}, ",", function()
  --local win = hs.window.focusedWindow()
  --local f = win:frame()

  --f.w = f.w - 15
  --f.h = f.h - 15
  --win:setFrame(f)
--[[end)]]

-- move window --------------------------------------

--[[-- left half]]
--hs.hotkey.bind({"alt", "shift"}, "h", function()
  --local win = hs.window.focusedWindow()
  --local f = win:frame()
  --local screen = win:screen()
  --local max = screen:frame()

  --f.x = max.x
  --f.y = max.y
  --f.w = max.w / 2
  --f.h = max.h
  --win:setFrame(f)
--end)

---- top half
--hs.hotkey.bind({"alt", "shift"}, "j", function()
  --local win = hs.window.focusedWindow()
  --local f = win:frame()
  --local screen = win:screen()
  --local max = screen:frame()

  --f.x = max.x
  --f.y = max.y
  --f.w = max.w
  --f.h = max.h / 2
  --win:setFrame(f)
--end)

---- bottom half
--hs.hotkey.bind({"alt", "shift"}, "k", function()
  --local win = hs.window.focusedWindow()
  --local f = win:frame()
  --local screen = win:screen()
  --local max = screen:frame()

  --f.x = max.x
  --f.y = max.y + (max.h / 2)
  --f.w = max.w
  --f.h = max.h / 2
  --win:setFrame(f)
--end)

---- right half
--hs.hotkey.bind({"alt", "shift"}, "l", function()
  --local win = hs.window.focusedWindow()
  --local f = win:frame()
  --local screen = win:screen()
  --local max = screen:frame()

	--f.x = max.x + (max.w / 2)
  --f.y = max.y
  --f.w = max.w / 2
  --f.h = max.h
  --win:setFrame(f)
--[[end)]]

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

