local gfs = require("gears.filesystem")
local theme = dofile(gfs.get_themes_dir() .. "default/theme.lua")
local theme_assets = require("beautiful.theme_assets")


theme.fg_focus		= "#E0E0E0"
theme.fg_urgent		= theme.fg_focus
theme.fg_minimize   = theme.fg_normal
theme.bg_focus		= "#404859"
theme.bg_urgent		= "#DC510C"
theme.bg_minimize   = theme.bg_normal

-- theme.notification_bg			= "#285577"
-- theme.notification_fg			= theme.fg_focus
theme.notification_border_color	= theme.fg_normal

theme.awesome_icon = theme_assets.awesome_icon(
	theme.menu_height, theme.bg_focus, theme.fg_focus
)

return theme
