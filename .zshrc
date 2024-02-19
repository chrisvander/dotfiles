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

# kubectl
[[ ! -f $HOME/.kube/config ]] || export KUBECONFIG=$HOME/.kube/config

zsh-defer __setup_conda
zsh-defer ~/.dotfiles/update.sh
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'
eval "$(mise activate zsh)"
eval "$(mise completion zsh)"
(( $+command[kubectl] )) && source <(kubectl completion zsh)
eval "$(starship init zsh)"
