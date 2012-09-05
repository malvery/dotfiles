#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#if [ "`tput colors`" = "256" ]; then
#	c0=$'\e[m'
#	c1=$'\e[38;5;075m'
#	c2=$'\e[38;5;112m'
#	c3=$'\e[38;5;172m'
#else
#	c0=$'\e[m'
#	c1=$'\e[1;32m'
#	c2=$'\e[1;36m'
#	c3=$'\e[1;35m'
#fi

#if [[ ${EUID} == 0 ]] ; then
#	PS1='$c1[\u]$c2 \W $c3# $c0'
#else
#	PS1='$c1[\u]$c2 \W $c3$ $c0'
#fi

set show-all-if-ambiguous on
set show-all-if-unmodified on

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

HISTCONTROL=ignoreboth

shopt -s autocd cdspell checkjobs dirspell histappend 

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
#alias bc='bc -ql'

#alias mnt='cd /media'

#alias scat='sudo cat'
#alias svim='sudo vim'
#alias smount='sudo mount'
#alias sumount='sudo umount'

#alias pm-suspend='sudo pm-suspend'
#alias hibernate='sudo hibernate'
#alias shutdown='sudo shutdown'
#alias reboot='sudo reboot'
#alias tcpdump='sudo tcpdump'
#alias ngrep='sudo ngrep'

##################################################################
