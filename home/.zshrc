##################################################################

autoload -Uz compinit && compinit
autoload -U colors && colors

setopt autocd
setopt globdots
setopt correct

bindkey -e

##################################################################

HISTFILE=~/.zhistory
HISTSIZE=10240
SAVEHIST=10240

setopt APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE
setopt INC_APPEND_HISTORY
setopt histexpiredupsfirst histfindnodups

##################################################################

setopt PROMPT_SUBST

precmd ()
{   
    setopt noxtrace localoptions
    local exitstatus=$?
    [[ $exitstatus -ge 128 ]] && psvar[1]=" $signals[$exitstatus-127]" || psvar[1]=""       
}

p_rc="%(?..[%?%1v] )"


if [ "`tput colors`" = "256" ]; then
	c0=$'%{\e[00m%}' #%{\e[01m%}'
	#c1=$'%{\e[38;5;075m%}'
	c1=$'%{\e[38;5;060m%}'
	c2=$'%{\e[38;5;112m%}'
	c3=$'%{\e[38;5;172m%}'

	#export PROMPT="$c0$c1%'[%n] $c2%1~ $c3%# $c0"
	export PROMPT="$c3%# $c1%1~: $c0"
	export PROMPT2="$c0$c3> $c0"
	export RPROMPT="$c0$c3$p_rc$c0$c2 %1(j.[%j].)$c0"

else
	c0=$'%{$reset_color%}'
	c1=$'%{$fg[magenta]%}'
	c2=$'%{$fg[red]%}'
	c3=$'%{$fg[green]%}'

	export PROMPT="$c2%1~ %# $c0"
	export PROMPT2="0$c3> $c0"
	export RPROMPT="$c0$c2$p_rc$c0$c3 %1(j.[%j].)$c0"

	alias mc='mc --skin dark'
	
	if [ "$TERM" = "linux" ]; then
		#setfont UniCyr_8x16
		[ -n "$TMUX" ] && export TERM=linux
	fi
fi



##################################################################

LS_COLORS='rs=0:di=01;36:ln=01;91:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.pkg.tar.gz=92:*.flac=92';
export LS_COLORS

export EDITOR="vim"
export BROWSER="chromium"
export XTERM="urxvt"
#export PATH="$HOME/.rbenv/bin:${PATH}"
#export CDPATH=".:~:/storage"

#eval "$(rbenv init -)"

##################################################################

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' prompt 'correct %e errors'

zstyle ':completion:*' menu yes select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

##################################################################

autoload zkbd
[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
[[ ! -f ~/.zkbd/$TERM ]] && zkbd 

source ~/.zkbd/$TERM

[[ -n ${key[F1]}			]]  && bindkey  "${key[F1]}"			undefined-key
[[ -n ${key[F2]}			]]  && bindkey  "${key[F2]}"			undefined-key
[[ -n ${key[F3]}			]]  && bindkey  "${key[F3]}"			undefined-key
[[ -n ${key[F4]}			]]  && bindkey  "${key[F4]}"			undefined-key
[[ -n ${key[F5]}			]]  && bindkey  "${key[F5]}"			undefined-key
[[ -n ${key[F6]}			]]  && bindkey  "${key[F6]}"			undefined-key
[[ -n ${key[F7]}			]]  && bindkey  "${key[F7]}"			undefined-key
[[ -n ${key[F8]}			]]  && bindkey  "${key[F8]}"			undefined-key
[[ -n ${key[F9]}			]]  && bindkey  "${key[F9]}"			undefined-key
[[ -n ${key[F10]}			]]  && bindkey  "${key[F10]}"			undefined-key
[[ -n ${key[F11]}			]]  && bindkey  "${key[F11]}"			undefined-key
[[ -n ${key[F12]}			]]  && bindkey  "${key[F12]}"			undefined-key

[[ -n ${key[Backspace]} ]]  && bindkey  "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]}		]]  && bindkey  "${key[Insert]}"		overwrite-mode
[[ -n ${key[Delete]}		]]  && bindkey  "${key[Delete]}"		delete-char
[[ -n ${key[Home]}		]]  && bindkey  "${key[Home]}"		beginning-of-line
[[ -n ${key[End]}			]]  && bindkey  "${key[End]}"			end-of-line
[[ -n ${key[PageUp]}		]]  && bindkey  "${key[PageUp]}"		up-line-or-history
[[ -n ${key[PageDown]}  ]]  && bindkey  "${key[PageDown]}"  down-line-or-history
[[ -n ${key[Up]}			]]  && bindkey  "${key[Up]}"			up-line-or-search
[[ -n ${key[Down]}		]]  && bindkey  "${key[Down]}"		down-line-or-search
[[ -n ${key[Left]}		]]  && bindkey  "${key[Left]}"		backward-char
[[ -n ${key[Right]}		]]  && bindkey  "${key[Right]}"		forward-char

##################################################################

autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey "^X^Z" predict-on # C-x C-z
bindkey "^Z" predict-off # C-z

##################################################################

alias ls='ls --color=auto -F -C'
alias lsa='ls --color=auto -F -o -h -a'
alias lsd='ls -ld *(-/DN)'
alias grep='grep --colour=auto'
alias hdd='ls /dev/sd*'
alias f='find | grep'
alias c="clear"
alias q="exit"
alias ..='cd ..'

alias bc='bc -ql'
alias mnt='cd /media'

alias scat='sudo cat'
alias svim='sudo vim'
alias smount='sudo mount'
alias sumount='sudo umount'

alias pm-suspend='sudo pm-suspend'
alias pm-hibernate='sudo pm-hibernate'

alias halt='systemctl poweroff' 
alias reboot='systemctl reboot'

alias tcpdump='sudo tcpdump'
alias ngrep='sudo ngrep'

alias -g ERR='2>>( sed -ue "s/.*/$fg_bold[red]&$reset_color/" 1>&2 )'
alias -g L='|less' 
alias -g S='&> /dev/null &'

alias -s html=$BROWSER
alias -s png=qiv
alias -s jpg=qiv
alias -s gif=qiv
alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
alias -s 7z=7z x
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

##################################################################

unpack() {
if [ -f $1 ] ; then
case $1 in
	*.tar.bz2)   tar xjf $1        ;;
	*.tar.gz)    tar xzf $1     ;;
	*.bz2)       bunzip2 $1       ;;
	*.rar)       unrar x $1     ;;
	*.gz)        gunzip $1     ;;
	*.tar)       tar xf $1        ;;
	*.tbz2)      tar xjf $1      ;;
	*.tgz)       tar xzf $1       ;;
	*.zip)       unzip $1     ;;
	*.Z)         uncompress $1  ;;
	*.7z)        7z x $1    ;;
	*)           echo "Cannot unpack '$1'..." ;;
esac
else
echo "'$1' is not a valid file"
fi
}

###################################################################

#export LANG=ru_RU.UTF-8
#export LC_CTYPE="ru_RU.UTF-8"
#export LC_NUMERIC="ru_RU.UTF-8"
#export LC_TIME="ru_RU.UTF-8"
#export LC_COLLATE="ru_RU.UTF-8"
#export LC_MONETARY="ru_RU.UTF-8"
#export LC_MESSAGES="ru_RU.UTF-8"
#export LC_PAPER="ru_RU.UTF-8"
#export LC_NAME="ru_RU.UTF-8"
#export LC_ADDRESS="ru_RU.UTF-8"
#export LC_TELEPHONE="ru_RU.UTF-8"
#export LC_MEASUREMENT="ru_RU.UTF-8"
#export LC_IDENTIFICATION="ru_RU.UTF-8"

###################################################################

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#source $HOME/.rvm/scripts/rvm
