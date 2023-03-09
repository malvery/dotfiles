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

# -----------------------------------------------
# Env and options
# -----------------------------------------------
export EDITOR='vi'
export SYSTEMD_EDITOR=${EDITOR}
export SUDO_PROMPT=$'\a[sudo] password for %p: '

export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=50000

shopt -s histappend

# -----------------------------------------------
# Prompt helpers
# -----------------------------------------------
C_DIR="\[$(tput setaf 142)\]\[$(tput bold)\]"
C_URG="\[$(tput setaf 167)\]"
C_GIT="\[$(tput setaf 175)\]"
C_PRX="\[$(tput setaf 80)\]"
C_JOB="\[$(tput setaf 104)\]"
C_TBX="\[$(tput setaf 11)\]"
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

  if [[ -v http_proxy ]]; then
    PROXY=" [P]"
  else
    PROXY=""
  fi

  if [[ -v DISTROBOX_ENTER_PATH || -v TOOLBOX_PATH ]]; then
    TBX=" [D]"
  else
    TBX=""
  fi

  GIT_BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/')
}
PROMPT_COMMAND=__promt

# -----------------------------------------------
# Local
# -----------------------------------------------
if [ -f ${HOME}/.bashrc.local ];
then
  source ${HOME}/.bashrc.local
fi

# -----------------------------------------------
# PS1
# -----------------------------------------------
PS1=" ${C_DIR}\w${C_RST}"
PS1+="${C_URG}\${STATUS_CODE}"
PS1+="${C_JOB}\${JOBS}"
PS1+="${C_PRX}\${PROXY}"
PS1+="${C_TBX}\${TBX}"
PS1+="${C_GIT}\${GIT_BRANCH}"
PS1+="${C_RST} \[\a\]"

# -----------------------------------------------
# Proxy
# -----------------------------------------------
_proxy_enable () {
  if [[ -v _proxy ]]; then
    export no_proxy=localhost,127.0.0.1
    export no_proxy=${no_proxy},10.96.0.0/12,192.168.59.0/24,192.168.49.0/24 # minikube
    export {http,https}_proxy=${_proxy}
  fi
}

_proxy_disable () {
  unset {http,https,no}_proxy
}

_proxy_set_aliases() {
  if [[ -v _proxy ]]; then
    for i in "${_proxy_aliased[@]}"; do
      alias $i="env {http,https}_proxy=${_proxy} $i"
    done
  fi
}

_proxy_unset_aliases () {
  for i in "${_proxy_aliased[@]}"; do
    unalias $i
  done
}
