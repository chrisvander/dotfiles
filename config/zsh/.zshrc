#!/usr/bin/env zsh

# brew completions
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit && compinit

# plugins
eval "$(sheldon source)"
eval "$(sheldon completions --shell zsh)"

# fzf
eval "$(fzf --zsh)"

# mise
eval "$(mise activate zsh)"
eval "$(mise completion zsh)"

# kubectl
[[ ! -f $HOME/.kube/config ]] || export KUBECONFIG=$HOME/.kube/config
eval "$(kubectl completion zsh)"

# prompt
eval "$(starship init zsh)"
eval "$(starship completions zsh)"

# conda
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  zsh-defer eval "$__conda_setup"
else
  if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
    . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
  else
    export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
  fi
fi
unset __conda_setup

# history
HISTFILE="$XDG_DATA_HOME/zsh/.zsh_history"
HISTSIZE=1000000   # Maximum events for local history
SAVEHIST=$HISTSIZE # Maximum events in history file

setopt EXTENDED_HISTORY   # Format history entries as ':start:elapsed;command'
setopt HIST_REDUCE_BLANKS # Remove extra whitespace before appending to local history

setopt HIST_FIND_NO_DUPS      # Do not display a previously found event
setopt HIST_SAVE_NO_DUPS      # Do not write duplicate events to the history file
setopt HIST_IGNORE_ALL_DUPS   # Deletes an old event if a new event is a duplicate
setopt HIST_EXPIRE_DUPS_FIRST # Remove a duplicate event first when trimming history

setopt INC_APPEND_HISTORY_TIME # Append events to history file immediately

setopt HIST_NO_STORE # Don't store the history command in history
export HISTORY_IGNORE="cd|cd *|ls *|mv *|cp *|cat *"

# fzf settings
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

# auto-update
__update_dotfiles() {
  git fetch

  UPSTREAM=${1:-'@{u}'}
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse "$UPSTREAM")
  BASE=$(git merge-base @ "$UPSTREAM")

  if [ $LOCAL = $REMOTE ]; then
    true
  elif [ $LOCAL = $BASE ]; then
    git pull
  fi
}

zsh-defer __update_dotfiles &> /dev/null

