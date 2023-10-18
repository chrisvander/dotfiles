# hack to ensure completions work with aliased commands
function __my_op_plugin_run() {
    _op_plugin_run

    for ((i = 2; i < CURRENT; i++)); do
        if [[ ${words[i]} == -- ]]; then
            shift $i words
            ((CURRENT -= i))
            _normal
            return
        fi
    done

}

function __load_op_completion() {
    completion_function="$(op completion zsh)"
    sed -E 's/^( +)_op_plugin_run/\1__my_op_plugin_run/' <<<"${completion_function}"
}

include () {
    [[ -f "$1" ]] && source "$1"
}

# include "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
include ~/.secrets

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
bindkey -v

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1 
zinit light mafredri/zsh-async
zinit light romkatv/zsh-defer

# include ~/.dotfiles/.p10k.zsh
# zinit light romkatv/powerlevel10k

zinit ice blockf

# add some most-used zsh plugins
zinit wait lucid light-mode for \
              zsh-users/zsh-autosuggestions \
              zdharma-continuum/fast-syntax-highlighting \
              zdharma-continuum/history-search-multi-word \
              sroze/docker-compose-zsh-plugin \
              chrisvander/docker-helpers.zshplugin \

# load completions and load completions for 1Password aliased commands
zinit for \
  atload"zicompinit; zicdreplay; eval $(__load_op_completion); compdef _op op" \
    blockf \
    lucid \
    wait \
  zsh-users/zsh-completions

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
zsh-defer eval "$(rtx activate zsh)" && eval "$(rtx e)"
zsh-defer eval "$(direnv hook zsh)"
zsh-defer eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# kubectl
[[ ! -f $HOME/.kube/config ]] || export KUBECONFIG=$HOME/.kube/config
