include () {
    [[ -f "$1" ]] && source "$1"
}

bindkey -v

include ~/.p10k.zsh
include ~/.secrets
include ~/.zshrc.local

export PATH=/root/.fnm:/opt/homebrew/opt/ruby/bin:$PATH
if [ -x "$(command -v fnm)" ]; then
    eval "$(fnm env --use-on-cd)"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

include "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# add completions
zi for \
    atload"zicompinit; zicdreplay" \
    blockf \
    lucid \
    wait \
  zsh-users/zsh-completions

# add powerlevel10k and defer
zinit ice depth=1 
zinit light romkatv/powerlevel10k
zinit light romkatv/zsh-defer

# add some most-used zsh plugins
zinit wait lucid for \
  light-mode  zsh-users/zsh-autosuggestions \
              zdharma-continuum/fast-syntax-highlighting \
              zdharma-continuum/history-search-multi-word \
              sroze/docker-compose-zsh-plugin \
              chrisvander/docker-helpers.zshplugin \

alias lzd=lazydocker

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
zsh-defer __setup_conda
zsh-defer ~/.dotfiles/update.sh
zsh-defer eval "$(rtx activate zsh)"

# kubectl
[[ ! -f $HOME/.kube/config ]] || export KUBECONFIG=$HOME/.kube/config
