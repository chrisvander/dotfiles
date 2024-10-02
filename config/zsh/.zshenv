#!/usr/bin/env zsh

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
# `op` does not work with `XDG_RUNTIME_DIR` set,
# so I'm allowing it to default to the default behavior
# (e.g. under $TMPDIR)
# export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir/

export EDITOR=${EDITOR:-nvim}
export VISUAL=${VISUAL:-nvim}
export MANPAGER=${MANPAGER:-nvim +Man!}
export PNPM_BIN="$HOME/.local/share/pnpm"
export MISE_BIN="$HOME/.local/share/mise/shims"
export PATH="$MISE_BIN:$PNPM_BIN:$PATH"

alias k=kubectl
alias mk=minikube
alias kc='kubectl config get-contexts'
alias ks='kubectl config use-context'
alias d=docker
alias dc='docker compose'
alias p='pnpm prisma'
alias pnx='pnpm nx'
alias cat=bat
alias tree='eza -ah --icons=always --tree --level=3 --git-ignore --ignore-glob=".git|node_modules|.DS_Store"'
alias ls='eza --icons=always --git'
alias la='eza -lah --icons --git --no-user'
alias gc='git commit'
alias gch='git checkout'
alias gs='git status'
alias gp='git push'
alias gpl='git pull'
alias k9s='aws sts get-caller-identity &> /dev/null; if [ $? = 0 ]; then k9s; else aws sso login && k9s; fi'
alias vi=nvim
alias vim=nvim

. "/Users/chrisvanderloo/.local/share/mise/installs/rust/latest/env"
