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


function getRunList (hostname)
	if hostname == 'vostro' then
		return run_vostro
	else
		return { }
	end
end

-- #################################################
