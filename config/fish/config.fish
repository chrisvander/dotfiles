# variables with defaults
set -q EDITOR || set -x EDITOR "nvim"
set -q VISUAL || set -x VISUAL "nvim"
set -q MANPAGER || set -x MANPAGER "nvim +Man!"

# source brew shellenv
eval "$(/opt/homebrew/bin/brew shellenv)"

# fzf
eval "$(fzf --fish)"

# prompt
starship init fish | source
