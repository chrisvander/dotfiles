export ZDOTDIR=$HOME
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim

alias k=kubectl
alias mk=minikube
alias kc='kubectl config get-contexts'
alias ks='kubectl config use-context'
alias d=docker
alias dc='docker compose'
alias p='pnpm prisma'
alias cat=bat
alias tree='eza -ah --icons --tree --level=3 --git-ignore --ignore-glob=".git|node_modules|.DS_Store"'
alias ls='eza --icons'
alias la='eza -lah --icons --git --no-user'
alias zj=zellij
alias zr='zellij run -- '
alias vi=nvim
alias vim=nvim
