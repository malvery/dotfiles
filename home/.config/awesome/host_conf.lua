-- #################################################
-- vostro
local conf_vostro = {
	['theme'] = "themes/arc.lua",

	['autostart'] = {
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
	},
	
	['w_rules'] = {
			{ rule = { class = "Chromium" }, properties = { screen = 1, tag = "2" } },
	},

	['d_apps'] = {
			["lock_manager"]	= "light-locker-command -l",
			["file_manager"]	= "thunar",
			["media_player"]	= "smplayer",
			["torrents"]			= "transmission-qt",
			["browser"]				= "chromium"
	},
	
	['widget'] = {
			['network'] = {
					['name']		= "wifi",
					['device']	= "wlp8s0"
			}
	}
}

-- #################################################
-- work
local conf_work = {
	['theme'] = "themes/arc.lua",

	['autostart'] = {
			'~/bin/urxvt.sh',
			'clipit',
			'syndaemon -t -i 1',
			'pulseaudio --start',
			'redshift-gtk',
			'nm-applet',
			'xfce4-power-manager',
			'google-chrome',
			'nitrogen --restore'
	},
	
	['w_rules'] = {
			{ rule = { class = "google-chrome" }, properties = { screen = 1, tag = "2" } },
			{ rule = { class = "Clementine" },		properties = { screen = 1, tag = "7" } },
			{ rule = { class = "SkypeForLinux" }, properties = { screen = 1, tag = "8" } },
			{ rule = { class = "Thunderbird" },		properties = { screen = 1, tag = "9" } },

			--{ rule = { class = "Chromium" },			properties = { screen = 3, tag = "2" } },
	},

	['d_apps'] = {
			["lock_manager"]	= "slimlock",
			["file_manager"]	= "thunar",
			["media_player"]	= "smplayer",
			["torrents"]			= "transmission-qt",
			["browser"]				= "chromium"
	},
	
	['widget'] = {
			['network'] = {
					['name']		= "net",
					['device']	= "wlp8s0"
			}
	}
}
-- #################################################

function getConfList (hostname)
	if string.find(hostname, "vostro") then
		return conf_vostro

	elseif string.find(hostname, "ZAVYALOV_NB") then
		return conf_work

	else
		return { }
	end
end

