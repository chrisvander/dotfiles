include () {
    [[ -f "$1" ]] && source "$1"
}

# include "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# include ~/.secrets

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
bindkey -v

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1 
zinit light mafredri/zsh-async
zinit light romkatv/zsh-defer

zinit ice blockf

# add some most-used zsh plugins
zinit wait lucid light-mode for \
    zdharma-continuum/fast-syntax-highlighting \
    zdharma-continuum/history-search-multi-word \
    sroze/docker-compose-zsh-plugin \
    chrisvander/docker-helpers.zshplugin \
    ajeetdsouza/zoxide \
    apachler/zsh-aws \
    macunha1/zsh-terraform

zi for \
  atload"zicompinit; zicdreplay; autoload -U +X bashcompinit && bashcompinit" \
    blockf \
    lucid \
    wait \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions

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
zsh-defer eval "$(mise activate)"
eval "$(starship init zsh)"
