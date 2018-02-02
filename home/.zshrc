# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH=$PATH:/usr/local/bin:/opt/local/bin/:/usr/local/go/bin
export LC_CTYPE=UTF-8

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="local"

##################################################################

alias f='find | grep'
alias c="clear"
alias q="exit"
alias ..='cd ..'
alias bc='bc -ql'

alias tailf='tail -f'
alias open='reattach-to-user-namespace -l open'

alias mc='mc -d'
alias mnt='cd /media'

alias scat='sudo cat'
alias svim='sudo vim'
alias smount='sudo mount'
alias sumount='sudo umount'
alias tcpdump='sudo tcpdump'

alias int-ib-app-1='ssh azavyalov@be01.int.internal-billing.wz-ams.lo.mobbtech.com'
alias int-ib-app-2='ssh azavyalov@be02.int.internal-billing.wz-ams.lo.mobbtech.com'
#alias int-ib-app-3='ssh azavyalov@be03.int.internal-billing.wz-ams.lo.mobbtech.com'
alias int-ib-db='psql -U azavyalov -h pgsql01.int.internal-billing.wz-ams.lo.mobbtech.com -W internal_billing'

alias int-tr-app-1='ssh azavyalov@be01.int.tournaments.wz-ams.lo.mobbtech.com'
alias int-tr-admin-1='ssh azavyalov@admin01.int.tournaments.wz-ams.lo.mobbtech.com'
alias int-tr-db='psql -U azavyalov -h pgsql01.int.tournaments.wz-ams.lo.mobbtech.com -W tournaments'

alias int-bo-app-1='ssh azavyalov@be01.int.binary-options.wz-ams.lo.mobbtech.com'
alias int-bo-app-2='ssh azavyalov@be02.int.binary-options.wz-ams.lo.mobbtech.com'
alias int-bo-app-3='ssh azavyalov@be03.int.binary-options.wz-ams.lo.mobbtech.com'
#alias int-bo-app-4='ssh azavyalov@be04.int.binary-options.wz-ams.lo.mobbtech.com'
alias int-bo-db='psql -U azavyalov -h pgsql01.int.binary-options.wz-ams.lo.mobbtech.com -W binary_options'

alias int-core-db='psql -h wicpg01.mobbtech.com -U azavyalov -W options_instance'
alias int-core-app-1='ssh azavyalov@be-core-01.int.core.wz-ams.lo.mobbtech.com'
alias int-core-app-2='ssh azavyalov@be-core-02.int.core.wz-ams.lo.mobbtech.com'

alias int-busapi-app-1='ssh azavyalov@busapi-01.int.root.wz-ams.lo.mobbtech.com'
alias int-busapi-app-2='ssh azavyalov@busapi-02.int.root.wz-ams.lo.mobbtech.com'
#alias int-busapi-app-3='ssh azavyalov@busapi-03.int.root.wz-ams.lo.mobbtech.com'


alias prod-ib-app-1='ssh azavyalov@be01.prod.internal-billing.wz-ams.lo.mobbtech.com'
alias prod-ib-app-2='ssh azavyalov@be02.prod.internal-billing.wz-ams.lo.mobbtech.com'
alias prod-ib-db='psql -U azavyalov -h pgsql-01.prod.internal-billing.wz-ams.lo.mobbtech.com -W internal_billing'

alias prod-bo-app-1='ssh azavyalov@be01.prod.binary-options.wz-ams.lo.mobbtech.com'
alias prod-bo-app-2='ssh azavyalov@be02.prod.binary-options.wz-ams.lo.mobbtech.com'
alias prod-bo-app-3='ssh azavyalov@be03.prod.binary-options.wz-ams.lo.mobbtech.com'
alias prod-bo-app-4='ssh azavyalov@be04.prod.binary-options.wz-ams.lo.mobbtech.com'
alias prod-bo-app-5='ssh azavyalov@be05.prod.binary-options.wz-ams.lo.mobbtech.com'
alias prod-bo-app-6='ssh azavyalov@be06.prod.binary-options.wz-ams.lo.mobbtech.com'
alias prod-bo-db='psql -U azavyalov -h pgsql-01.prod.binary-options.wz-ams.lo.mobbtech.com -W binary_options'

alias prod-core-db='psql -h wpcpg01.mobbtech.com -U azharovina -W options_instance'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

#export PATH="/usr/lib64/lxqt-xdg-tools:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/vendor_perl:/usr/bin/core_perl"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#export PATH=$PATH:/usr/local/go/bin
#export GOROOT=/usr/local/go
#export GOPATH=/Users/anton.zavyalov/GoglandProjects/azavyalov/test-go
#export PATH=/Library/Frameworks/Python.framework/Versions/3.5/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/local/bin/:/opt/local/bin/

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

