set -q EDITOR || set -x EDITOR nvim
set -q VISUAL || set -x VISUAL $EDITOR
set -q MANPAGER || set -x MANPAGER "$EDITOR +Man!"
