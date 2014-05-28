function fish_prompt --description 'Write out the prompt'
	set -l last_status $status
	set stat $status

	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end

	# PWD
	set_color $fish_color_cwd
	echo -n (prompt_pwd)
	set_color normal

	printf '%s %s' (__fish_git_prompt)
	set_color $fish_color_error

	if not test $last_status -eq 0
		printf '(%s) ' "$stat"
	end

	echo -n '$ '
	set_color normal
end
