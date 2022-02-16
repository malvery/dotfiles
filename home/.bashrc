# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -----------------------------------------------
# Aliases
# -----------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'
alias bc='bc -ql'

alias scat='sudo cat'
alias svim='sudo vim'

# -----------------------------------------------
# Env variables
# -----------------------------------------------
export PATH=$PATH:~/.local/bin
export EDITOR='vim'
export SYSTEMD_EDITOR=${EDITOR}
export SUDO_PROMPT=$'\a[sudo] password for %p: '

export HISTCONTROL=ignoreboth
export HISTSIZE=10000

# -----------------------------------------------
# Completions
# -----------------------------------------------
source  /usr/share/git/completion/git-prompt.sh

# -----------------------------------------------
# Prompt
# -----------------------------------------------
C_DIR="$(tput setaf 142)"
C_URG="$(tput setaf 167)"
C_GIT="$(tput setaf 175)"
C_JOB="$(tput setaf 104)"
C_RST="$(tput sgr0)"

__status_code() {
  local status=$?
  [ ${status} -gt 0 ] && echo "${C_URG} [${status}]${C_RST}"
}

__jobs() {
  local jobs=$(jobs |wc -l)
  [ ${jobs} -gt 0 ] && echo "${C_JOB} [${jobs}]${C_RST}"
}

__git() {
  __git_ps1 "${C_GIT} [%s]${C_RST}"
}

PS1=' ${C_DIR}\w$(__status_code)$(__jobs)$(__git)${C_RST} '

# -----------------------------------------------
# Local
# -----------------------------------------------
if [[ -f ${HOME}/.bashrc.local ]];
then
  source ${HOME}/.bashrc.local
fi
