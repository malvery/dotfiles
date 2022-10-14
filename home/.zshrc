# completion ------------------------------------------------------------------
_NIX_SHARE=${HOME}/.nix-profile/share
if [ -d ${_NIX_SHARE} ]; then
  _NIX_COMP=${_NIX_SHARE}/zsh/site-functions/
  fpath=($_NIX_COMP $fpath)
fi

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# options ---------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
unsetopt share_history
unset zle_bracketed_paste

# vi-mode ---------------------------------------------------------------------
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
preexec() { echo -ne '\e[5 q' ;}

# aliases ---------------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'
alias bc='bc -ql'

# environment -----------------------------------------------------------------
export EDITOR='vi'
export SYSTEMD_EDITOR=${EDITOR}
export SUDO_PROMPT=$'\a[sudo] password for %p: '

# prompt ----------------------------------------------------------------------
PROMPT=' %F{142}%B%~%b%f%F{167}%(?.. [%?])%f%F{104}%-1(j. [%j].)%f '

precmd () { echo -n -e "\a" "\e[5 q" }

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '[%F{175}%b%f]'

setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_

# mappings --------------------------------------------------------------------
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

bindkey -M viins "^R" history-incremental-search-backward
bindkey -M vicmd 'j'  history-beginning-search-backward-end \
                 'k'  history-beginning-search-forward-end

bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete

# locals ----------------------------------------------------------------------
if [[ -f ${HOME}/.zshrc.local ]];
then
  source ${HOME}/.zshrc.local
fi
