-- #################################################
-- vostro
local conf_vostro = {} 

-- #################################################
-- work
local conf_work = {
	['autostart'] = {
			--'/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh',
			'xsettingsd',
			'setxkbmap -layout "us,de"',
			'pulseaudio --start',
			--'lxpolkit',
			'clipit',
			'~/src/touchpad_settings.sh',
			'syndaemon -t -R -i 0.1',
			'redshift-gtk',
			'nm-applet',
			'thunderbird',
			'slack',
			'lxterminal',
			'shutter',
			'blueman-applet',
			'light-locker',
			--'xsetroot -solid "#323232"'
	},
	
	['w_rules'] = {
			{ rule = { class = "Atom" },					properties = { screen = 1, tag = "8" } },
			{ rule = { class = "Thunderbird" },		properties = { screen = 1, tag = "9" } },
			{ rule = { class = "Slack" },					properties = { screen = 1, tag = "9" } },
	},

	['d_apps'] = {
			["launcher"]			= "dmenu_run",
			["terminal"]			= "lxterminal",
			["lock_manager"]	= "light-locker-command -l",
			["file_manager"]	= "thunar",
			["media_player"]	= "vlc",
			["torrents"]			= "transmission-gtk",
			["browser"]				= "chromium-browser"
	},
	
	['widget'] = {
			['network'] = {
					['name']		= "wifi",
					['device']	= "wlp3s0"
			}
	}
}
-- #################################################

function getConfList (hostname)

	if string.find(hostname, "vostro") then
		return conf_vostro

	elseif string.find(hostname, "NB-ZAVYALOV2") then
		return conf_work

	else
		return conf_work

	end
end

