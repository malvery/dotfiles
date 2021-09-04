local theme_assets = require("beautiful.theme_assets")
local gfs = require("gears.filesystem")

-- default
local theme = dofile(gfs.get_themes_dir() .. "default/theme.lua")

theme.fg_focus		= "#E0E0E0"
theme.fg_urgent		= theme.fg_focus
theme.fg_minimize   = theme.fg_normal
theme.bg_focus		= "#404859"
theme.bg_urgent		= "#DC510C"
theme.bg_minimize   = theme.bg_normal

theme.notification_border_color	= theme.fg_normal

theme.awesome_icon = theme_assets.awesome_icon(
	theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- zenburn
--[[ local theme = dofile(gfs.get_themes_dir() .. "zenburn/theme.lua")

theme.fg_urgent	= theme.fg_focus
theme.bg_urgent	= "#DC510C"
theme.notification_border_color	= theme.fg_normal
theme.border_normal = theme.bg_focus ]]

return theme
