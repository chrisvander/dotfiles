# xdg config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

# variables with defaults
set -q EDITOR || set -x EDITOR nvim
set -q VISUAL || set -x VISUAL nvim
set -q MANPAGER || set -x MANPAGER "nvim +Man!"

# source brew shellenv
/opt/homebrew/bin/brew shellenv | source

# prompt
starship init fish | source

# fzf
fzf --fish | source

# zoxide
zoxide init fish | source
