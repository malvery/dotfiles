##############################################################################
# zsh
##############################################################################
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

autoload -Uz select-word-style
select-word-style bash

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
unsetopt share_history

unset zle_bracketed_paste
set -o emacs

##############################################################################
# aliases
##############################################################################
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'

alias q="exit"
alias ..='cd ..'
alias ~='cd ~'
alias bc='bc -ql'
alias xo='xdg-open'

alias mc='mc -d'
alias mnt='cd /run/media/${USER}/'

alias scat='sudo cat'
alias svim='sudo vim'
alias smount='sudo mount'
alias sumount='sudo umount'

alias venv-activate='source ./.venv/bin/activate || source ./venv/bin/activate'

##############################################################################
# environment
##############################################################################
export EDITOR='vim'
export SYSTEMD_EDITOR='vim'
export SUDO_PROMPT=$'\a[sudo] password for %p: '

if [[ $TERM == "xterm" ]]
then
	export TERM=xterm-256color
fi

##############################################################################
# prompt
##############################################################################
PROMPT=' %F{167}%(?..[%?] )%f%F{142}%B%~%b%f '

precmd () {
  echo -n -e "\a"
}

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '[%F{175}%b%f]'

setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_

##############################################################################
# mappings
##############################################################################
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        history-beginning-search-backward-end
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      history-beginning-search-forward-end
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

##############################################################################
# colors
##############################################################################
LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32";
export LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


if [[ -f ${HOME}/.zshrc.local ]];
then
	source ${HOME}/.zshrc.local
fi
