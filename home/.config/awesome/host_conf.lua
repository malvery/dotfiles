-- #################################################
-- vostro

local run_vostro = {
	'~/bin/urxvt.sh',
	'clipit',
	'syndaemon -t -i 1',
	'pulseaudio --start',
	'redshift-gtk',
	'nm-applet',
	'light-locker',
	'xfce4-power-manager',
	'chromium',
	'nitrogen --restore'
}

local rules_vostro = {
	{ 
		rule = { class = "Chromium" },
    properties = { screen = 1, tag = "2" } 
	}
}

local apps_vostro = {
	["theme_name"]							= "themes/arc.lua",

	["lock_manager"]	= "light-locker-command -l",
	["file_manager"]	= "thunar",
	["media_player"]	= "smplayer",
	["torrents"]			= "transmission-qt",
	["browser"]				= "chromium"
}

local widgets_vostro = {
	['network'] = {
		['name']		= "wifi",
		['device']	= "wlp8s0"
	}
}

-- #################################################

-- #################################################

function getRunList (hostname)
	if string.find(hostname, "vostro") then
		return run_vostro
	else
		return { }
	end
end

function getRulesList (hostname)
	if string.find(hostname, "vostro") then
		return rules_vostro
	else
		return { }
	end
end

function getAppsList (hostname)
	if string.find(hostname, "vostro") then
		return apps_vostro
	else
		return { }
	end
end

function getWidgetsList (hostname)
	if string.find(hostname, "vostro") then
		return widgets_vostro
	else
		return { }
	end
end
