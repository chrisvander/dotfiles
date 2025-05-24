set -q EDITOR || set -x EDITOR hx
set -q VISUAL || set -x VISUAL $EDITOR
set -q MANPAGER || set -x MANPAGER "nvim +Man!"
