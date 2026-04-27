----------------------------------------------------
-- apps
----------------------------------------------------

hs.hotkey.bind({ "alt", "shift" }, "return", function()
  hs.execute("alacritty msg create-window", true)
end)

hs.hotkey.bind({ "alt", "shift" }, "p", function()
  hs.application.launchOrFocus("Finder")
end)

----------------------------------------------------
-- windows
----------------------------------------------------

hs.window.animationDuration = 0

hs.loadSpoon("WindowHalfsAndThirds")
spoon.WindowHalfsAndThirds:bindHotkeys({
  max_toggle  = { { "alt", "shift" }, "m" },
  left_half   = { { "alt", "shift" }, "h" },
  right_half  = { { "alt", "shift" }, "l" },
  top_half    = { { "alt", "shift" }, "k" },
  bottom_half = { { "alt", "shift" }, "j" },
  larger      = { { "alt", "shift" }, "=" },
  smaller     = { { "alt", "shift" }, "-" },
})

hs.hotkey.bind({ "alt", "shift" }, "c", function()
  local win = hs.window.focusedWindow()
  win:close()
end)

hs.hotkey.bind({ "alt", "shift" }, "n", function()
  local win = hs.window.focusedWindow()
  win:minimize()
end)

hs.hotkey.bind("alt", "h", function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind("alt", "l", function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind("alt", "k", function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind("alt", "j", function() hs.window.focusedWindow():focusWindowSouth() end)

----------------------------------------------------
-- spaces
----------------------------------------------------

local spaces       = require("hs.spaces")

local lastSpace    = nil
local currentSpace = spaces.focusedSpace()
local spacesTable  = hs.spaces.spacesForScreen()

local function updateSpaces()
  local nextSpace = spaces.focusedSpace()
  if nextSpace ~= currentSpace then
    lastSpace = currentSpace
    currentSpace = nextSpace
  end

  spacesTable = hs.spaces.spacesForScreen()
end

spaceWatcher = spaces.watcher.new(updateSpaces)
spaceWatcher:start()

hs.hotkey.bind({ "alt" }, "escape", function()
  if lastSpace then
    local lastSpaceIndex = indexOf(spacesTable, lastSpace)
    hs.eventtap.keyStroke({ "alt" }, tostring(lastSpaceIndex))
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

    -- hs.mouse.absolutePosition({x = X, y = Y})
    hs.execute(string.format("/opt/homebrew/bin/cliclick m:%d,%d", X, Y))
  end
end)

----------------------------------------------------
-- window switcher
----------------------------------------------------

-- local filter = hs.window.filter.new():setCurrentSpace(true):setDefaultFilter {}
-- local switcher = hs.window.switcher.new(
--   filter,
--   {
--     showThumbnails = false,
--     showSelectedThumbnail = false,
--     showTitles = true,
--     titleFontSize = 12,
--   }
-- )
--
-- local filter_fs = hs.window.filter.new():setOverrideFilter({
--   fullscreen = true,
--   visible = true
-- })
-- local switcher_fs = hs.window.switcher.new(
--   filter_fs,
--   {
--     showThumbnails = false,
--     showSelectedThumbnail = false,
--     showTitles = true,
--     titleFontSize = 12,
--   }
-- )
--
-- local function toggleTwoWindows()
--   local windows = filter:getWindows(hs.window.filter.sortByFocusedLast)
--
--   if #windows >= 2 then
--     windows[2]:focus()
--   end
-- end
--
-- hs.hotkey.bind({ "alt", "shift" }, 'a', function() switcher:next()    end)
-- hs.hotkey.bind({ "alt", "shift" }, 'f', function() switcher_fs:next() end)
-- hs.hotkey.bind({ "alt" }, "tab", toggleTwoWindows)
