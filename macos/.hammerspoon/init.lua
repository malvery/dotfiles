-- Tune garbage collection to eliminate sudden pauses
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 400)

----------------------------------------------------
-- apps
----------------------------------------------------

hs.hotkey.bind({ "alt", "shift" }, "return", function()
  hs.execute("kitten @ --to=unix:$(ls /tmp/kitty-* | head) launch --type=os-window", true)
end)

hs.hotkey.bind({ "alt", "shift" }, "p", function()
  hs.application.launchOrFocus("Finder")
end)

----------------------------------------------------
-- windows
----------------------------------------------------

hs.window.animationDuration = 0

-- hs.loadSpoon("WindowHalfsAndThirds")
-- spoon.WindowHalfsAndThirds:bindHotkeys({
--   max_toggle  = { { "alt", "shift" }, "m" },
--   left_half   = { { "alt", "shift" }, "h" },
--   right_half  = { { "alt", "shift" }, "l" },
--   top_half    = { { "alt", "shift" }, "k" },
--   bottom_half = { { "alt", "shift" }, "j" },
--   larger      = { { "alt", "shift" }, "=" },
--   smaller     = { { "alt", "shift" }, "-" },
-- })
--
-- hs.hotkey.bind({ "alt", "shift" }, "c", function()
--   local win = hs.window.focusedWindow()
--   win:close()
-- end)

hs.hotkey.bind({ "alt", "shift" }, "-", function()
  local win = hs.window.focusedWindow()
  win:minimize()
end)

-- hs.hotkey.bind({ "alt", "shift" }, "m", function()
--   local win = hs.window.focusedWindow()
--   win:maximize()
-- end)

-- hs.hotkey.bind("alt", "h", function() hs.window.focusedWindow():focusWindowWest() end)
-- hs.hotkey.bind("alt", "l", function() hs.window.focusedWindow():focusWindowEast() end)
-- hs.hotkey.bind("alt", "k", function() hs.window.focusedWindow():focusWindowNorth() end)
-- hs.hotkey.bind("alt", "j", function() hs.window.focusedWindow():focusWindowSouth() end)

-- hs.hotkey.bind({ "alt", "shift" }, "h", function()
--   hs.eventtap.keyStroke({ "ctrl", "alt", "shift" }, "left", 0)
-- end)
--
-- hs.hotkey.bind({ "alt", "shift" }, "l", function()
--   hs.eventtap.keyStroke({ "ctrl", "alt", "shift" }, "right", 0)
-- end)
--
-- hs.hotkey.bind({ "alt", "shift" }, "j", function()
--   hs.eventtap.keyStroke({ "ctrl", "alt", "shift" }, "down", 0)
-- end)
--
-- hs.hotkey.bind({ "alt", "shift" }, "k", function()
--   hs.eventtap.keyStroke({ "ctrl", "alt", "shift" }, "up", 0)
-- end)

----------------------------------------------------
-- spaces
----------------------------------------------------

-- local spaces       = require("hs.spaces")
--
-- local lastSpace    = nil
-- local currentSpace = spaces.focusedSpace()
-- local spacesTable  = hs.spaces.spacesForScreen()
--
-- local function updateSpaces()
--   local nextSpace = spaces.focusedSpace()
--   if nextSpace ~= currentSpace then
--     lastSpace = currentSpace
--     currentSpace = nextSpace
--   end
--
--   spacesTable = hs.spaces.spacesForScreen()
-- end
--
-- spaceWatcher = spaces.watcher.new(updateSpaces)
-- spaceWatcher:start()
--
-- hs.hotkey.bind({ "alt" }, "escape", function()
--   if lastSpace then
--     local lastSpaceIndex = indexOf(spacesTable, lastSpace)
--     hs.eventtap.keyStroke({ "alt" }, tostring(lastSpaceIndex))
--   end
-- end)

----------------------------------------------------
-- helpers
----------------------------------------------------

function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

function indexOf(array, value)
  for i, v in ipairs(array) do
    if v == value then
      return i
    end
  end
  return nil
end

----------------------------------------------------
-- timers
----------------------------------------------------

idleWatcher = hs.timer.doEvery(10, function()
  local idleSeconds = hs.host.idleTime()

  if idleSeconds > 120 then
    -- hs.alert.show("IDLE: " .. idleSeconds .. "")

    local currentPos = hs.mouse.absolutePosition()
    local X = math.floor(currentPos.x + math.random(-20, 20))
    local Y = math.floor(currentPos.y + math.random(-20, 20))

    local mouseEvent = hs.eventtap.event.newMouseEvent(
      hs.eventtap.event.types.mouseMoved,
      { x = X, y = Y }
    )
    mouseEvent:post()
  end
end)

----------------------------------------------------
-- window switcher
----------------------------------------------------

-- local filter = hs.window.filter.new():setCurrentSpace(true):setDefaultFilter {}
-- local function toggleTwoWindows()
--   local windows = filter:getWindows(hs.window.filter.sortByFocusedLast)
--
--   if #windows >= 2 then
--     windows[2]:focus()
--   end
-- end
--
-- hs.hotkey.bind({ "alt" }, "tab", toggleTwoWindows)

----------------------------------------------------
-- fs watcher
----------------------------------------------------

local watchFolder  = os.getenv("HOME") .. "/Desktop"
local targetFile   = "WelcomeGuide.pdf"

fileDestroyer      = hs.pathwatcher.new(watchFolder, function(paths, flagSet)
  for i, path in ipairs(paths) do
    if path:match(targetFile .. "$") and (flagSet[i]["itemCreated"] or flagSet[i]["itemModified"]) then
      local success, err = os.remove(path)

      if not success then
        print("Failed to delete file: " .. tostring(err))
      end
    end
  end
end):start()

----------------------------------------------------
-- OLED
----------------------------------------------------

-- local screenWatcher = nil
--
-- local function setMenuBarAutoHide(enable)
--   local state = enable and "true" or "false"
--   local script = string.format([[
--         tell application "System Events"
--             tell dock preferences
--                 set autohide menu bar to %s
--             end tell
--         end tell
--     ]], state)
--   hs.osascript.applescript(script)
-- end
--
-- local function monitorChangedCallback()
--   local screens = hs.screen.allScreens()
--   local hasExternalMonitor = false
--
--   -- Check if any connected screen is an external monitor
--   for _, screen in ipairs(screens) do
--     local screenName = screen:name()
--
--     -- macOS defaults built-in displays to "Color LCD" or "Built-in Retina Display"
--     if screenName and not string.find(screenName, "Color LCD") and not string.find(screenName, "Built%-in") then
--       hasExternalMonitor = true
--       break
--     end
--   end
--
--   if hasExternalMonitor then
--     -- External monitor is active (works perfectly in closed-lid/clamshell mode)
--     setMenuBarAutoHide(true)
--     hs.alert.show("External Monitor Connected: Menu bar hidden")
--   else
--     -- Only the built-in screen is remaining
--     setMenuBarAutoHide(false)
--     hs.alert.show("Laptop Mode: Menu bar restored")
--   end
-- end
--
-- screenWatcher = hs.screen.watcher.new(monitorChangedCallback)
-- screenWatcher:start()
--
-- -- Run once on startup to set correct initial state
-- monitorChangedCallback()

----------------------------------------------------
-- Aerospace
----------------------------------------------------

local MRU_MAX      = 40
local RECOMPUTE_MS = 0.15

local mru          = {}  -- { { win = hs.window, id = number }, ... } most recent first
local target       = nil -- pre-resolved hs.window to jump to
local recomputeT   = nil

local function mruRemove(id)
  for i, e in ipairs(mru) do
    if e.id == id then
      table.remove(mru, i)
      return
    end
  end
end

local function mruPush(win)
  if not win then return end
  local id = win:id()
  if not id then return end
  mruRemove(id)
  table.insert(mru, 1, { win = win, id = id })
  while #mru > MRU_MAX do table.remove(mru) end
end

local function alive(win)
  if not win then return false end
  local ok, res = pcall(win.isWindow, win)
  if not ok then return false end
  return res and select(2, pcall(win.id, win)) ~= nil
end

local function centerInFrame(win, f)
  local ok, w = pcall(win.frame, win)
  if not ok or not w then return false end
  local cx, cy = w.x + w.w / 2, w.y + w.h / 2
  return cx >= f.x and cx <= f.x + f.w and cy >= f.y and cy <= f.y + f.h
end

local function resolveTarget(cur, curId)
  cur          = cur or hs.window.focusedWindow()
  curId        = curId or (cur and cur:id())

  local screen = (cur and cur:screen()) or hs.screen.mainScreen()
  local frame  = screen:fullFrame()

  target       = nil

  local i      = 1
  while i <= #mru do
    local e = mru[i]
    local w = e.win
    if not alive(w) then -- window is gone: drop it, don't advance
      table.remove(mru, i)
    else
      if e.id ~= curId and w:isVisible() and w:isStandard() and centerInFrame(w, frame) then
        target = w
        return
      end
      i = i + 1
    end
  end
end

local function scheduleRecompute()
  if recomputeT then recomputeT:stop() end
  recomputeT = hs.timer.doAfter(RECOMPUTE_MS, function() resolveTarget() end)
end

local wf = hs.window.filter.default
wf:subscribe(hs.window.filter.windowFocused, function(win)
  mruPush(win)
  scheduleRecompute()
end)
wf:subscribe(hs.window.filter.windowDestroyed, function(win)
  local id = win and win:id()
  if id then mruRemove(id) end
  if not alive(target) then target = nil end
  scheduleRecompute()
end)

mruPush(hs.window.focusedWindow())
scheduleRecompute()

function aerospaceFocusRecent()
  local cur   = hs.window.focusedWindow()
  local curId = cur and cur:id()
  local w     = target

  if w and alive(w) and (not curId or w:id() ~= curId) then
    local screen = (cur and cur:screen()) or hs.screen.mainScreen()
    if not centerInFrame(w, screen:fullFrame()) then w = nil end
  else
    w = nil
  end

  if not w then
    resolveTarget(cur, curId) -- cold or stale cache: pay the slow path once
    w = target
  end
  if not w then return false end

  w:focus()
  mruPush(w)

  target = cur
  scheduleRecompute() -- background correction only

  return true
end

hs.hotkey.bind({ "alt" }, "tab", aerospaceFocusRecent)
