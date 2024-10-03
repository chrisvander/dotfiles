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

# zoxide
zoxide init fish | source

# fzf bindings
fzf_configure_bindings --directory=\ct --git_log=\cf --git_status=\cg --processes=\cp

# fzf configurations
set fzf_preview_dir_cmd eza --all --color=always --icons
set fzf_diff_highlighter delta --paging=never --width=20
