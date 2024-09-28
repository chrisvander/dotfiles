#!/usr/bin/env zsh

# znap
[[ -r "$XDG_DATA_HOME/zsh/plugins/znap/znap.zsh" ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git \
        "$XDG_DATA_HOME/zsh/plugins/znap"
source "$XDG_DATA_HOME/zsh/plugins/znap/znap.zsh"

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit -u
fi

# prompt
znap eval starship "starship init zsh"
znap eval _starship "starship completions zsh"
znap prompt

# plugins
eval "$(sheldon source)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    znap eval conda "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

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
(( $+command[kubectl] )) && source <(kubectl completion zsh)

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

__update_dotfiles &> /dev/null

# bindkey "^R" .history-incremental-search-backward
# bindkey "^S" .history-incremental-search-forward

# mise
znap eval mise "mise activate zsh"
znap eval _mise "mise completion zsh"
znap eval fzf "fzf --zsh"

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
