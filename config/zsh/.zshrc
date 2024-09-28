#!/usr/bin/env zsh

zs() {
  # zj integration
  if [[ -z "$ZELLIJ" ]]; then
    ZJ_SESSIONS=$(zellij list-sessions --short)
    NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)
    if [ "${NO_SESSIONS}" -ge 2 ]; then
      SELECTED_SESSION="$(echo "${ZJ_SESSIONS}" | fzf)"
    fi

    if [[ -z "$SELECTED_SESSION" ]]; then
      zellij attach -c default
    else
      zellij attach -f "$SELECTED_SESSION"
    fi
  fi
}

eval "$(sheldon source)"

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
bindkey -v

autoload -Uz compinit
compinit

__setup_conda() {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
}

# history
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# kubectl
[[ ! -f $HOME/.kube/config ]] || export KUBECONFIG=$HOME/.kube/config

zsh-defer __setup_conda
zsh-defer ~/.dotfiles/update.sh
# bindkey "^R" .history-incremental-search-backward
# bindkey "^S" .history-incremental-search-forward
eval "$(mise activate zsh)"
eval "$(mise completion zsh)"
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude .git"
_fzf_compgen_path() {
  fd --hidden --follow --exclude .git . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude .git . "$1"
}
_fzf_comprun() {
  local command=$1
  shift

  case $command in
    cd) fzf --preview 'eza --tree --color=always --icons {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval echo {}" "$@" ;;
    ssh) fzf --preview "dig {}" "$@" ;;
    *) fzf --preview "--preview 'bat -n --color=always --line-range :500 {}'" "$@" ;;

  esac
}
(( $+command[kubectl] )) && source <(kubectl completion zsh)
eval "$(starship init zsh)"
