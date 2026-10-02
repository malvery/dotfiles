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

hs.hotkey.bind({ "alt", "shift" }, "c", function()
  local win = hs.window.focusedWindow()
  win:close()
end)

hs.hotkey.bind({ "alt", "shift" }, "'", function()
  local win = hs.window.centerOnScreen()
  win:minimize()
end)

hs.hotkey.bind({ "alt", "shift" }, "-", function()
  local win = hs.window.focusedWindow()
  win:minimize()
end)

hs.hotkey.bind({ "alt", "shift" }, "m", function()
  local win = hs.window.focusedWindow()
  win:maximize()
end)

hs.hotkey.bind("alt", "h", function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind("alt", "l", function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind("alt", "k", function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind("alt", "j", function() hs.window.focusedWindow():focusWindowSouth() end)

hs.hotkey.bind({ "alt", "shift" }, "h", function()
  hs.eventtap.keyStroke({ "ctrl", "alt", "shift" }, "left", 0)
end)

hs.hotkey.bind({ "alt", "shift" }, "l", function()
  hs.eventtap.keyStroke({ "ctrl", "alt", "shift" }, "right", 0)
end)

hs.hotkey.bind({ "alt", "shift" }, "j", function()
  hs.eventtap.keyStroke({ "ctrl", "alt", "shift" }, "down", 0)
end)

hs.hotkey.bind({ "alt", "shift" }, "k", function()
  hs.eventtap.keyStroke({ "ctrl", "alt", "shift" }, "up", 0)
end)

----------------------------------------------------
-- spaces
----------------------------------------------------

local spaces = require("hs.spaces")

local lastSpace
local currentSpace = spaces.focusedSpace()
local index = {}

local function reindex()
  index = {}
  for i, id in ipairs(spaces.spacesForScreen() or {}) do index[id] = i end
end
reindex()

spaceWatcher = spaces.watcher.new(function()
  local nextSpace = spaces.focusedSpace()
  if nextSpace and nextSpace ~= currentSpace then
    lastSpace, currentSpace = currentSpace, nextSpace
  end
end)
spaceWatcher:start()

hs.hotkey.bind({ "alt" }, "escape", function()
  if not lastSpace then return end
  local i = index[lastSpace]
  if not i then
    reindex(); i = index[lastSpace]
  end                                               -- spaces added/removed
  if i and i <= 9 then
    hs.eventtap.keyStroke({ "alt" }, tostring(i), 0)
  end
end)

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

local filter = hs.window.filter.new():setCurrentSpace(true):setDefaultFilter {}
local function toggleTwoWindows()
  local windows = filter:getWindows(hs.window.filter.sortByFocusedLast)

  if #windows >= 2 then
    windows[2]:focus()
  end
end

hs.hotkey.bind({ "alt" }, "tab", toggleTwoWindows)

----------------------------------------------------
-- fs watcher
----------------------------------------------------

local watchFolder = os.getenv("HOME") .. "/Desktop"
local targetFile  = "WelcomeGuide.pdf"

fileDestroyer     = hs.pathwatcher.new(watchFolder, function(paths, flagSet)
  for i, path in ipairs(paths) do
    if path:match(targetFile .. "$") and (flagSet[i]["itemCreated"] or flagSet[i]["itemModified"]) then
      local success, err = os.remove(path)

      if not success then
        print("Failed to delete file: " .. tostring(err))
      end
    end
  end
end):start()

