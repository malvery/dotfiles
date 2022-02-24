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
# Prompt
# -----------------------------------------------
C_DIR="\[$(tput setaf 142)\]\[$(tput bold)\]"
C_URG="\[$(tput setaf 167)\]"
C_GIT="\[$(tput setaf 175)\]"
C_JOB="\[$(tput setaf 104)\]"
C_RST="\[$(tput sgr0)\]"

__promt() {
  STATUS_CODE=$?
  if [ ${STATUS_CODE} -gt 0 ]; then
    STATUS_CODE=" [${STATUS_CODE}]"
  else
    STATUS_CODE=""
  fi

  JOBS=$(jobs |wc -l)
  if [ ${JOBS} -gt 0 ]; then
    JOBS=" [${JOBS}]"
  else
    JOBS=""
  fi

  GIT_BRANCH=$(__git_ps1 " [%s]")
}
PROMPT_COMMAND=__promt

PS1=" ${C_DIR}\w${C_RST}"
PS1+="${C_URG}\${STATUS_CODE}"
PS1+="${C_JOB}\${JOBS}"
PS1+="${C_GIT}\${GIT_BRANCH}"
PS1+="${C_RST} \[\a\]"
# -----------------------------------------------
# Completions
# -----------------------------------------------
_NIX_SHARE=${HOME}/.nix-profile/share
if [ -d ${_NIX_SHARE} ]; then
  _NIX_COMP_BASH=${_NIX_SHARE}/bash-completion/completions/
  for f in ${_NIX_COMP_BASH}/*; do . $f; done
fi

# -----------------------------------------------
# Local
# -----------------------------------------------
if [ -f ${HOME}/.bashrc.local ];
then
  source ${HOME}/.bashrc.local
fi
