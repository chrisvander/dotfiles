#!/bin/bash
function check_for() {
  if ! command -v $1 &>/dev/null; then
    echo "ERROR: $1 could not be found"
    exit
  fi
}

BASEDIR=$(pwd)

check_for curl
check_for git
check_for zsh
check_for brew

if [[ ! -e $HOME/.zshrc ]]; then
  touch ~/.zshrc
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  brew bundle install --file $BASEDIR/Brewfile-macos
else
  brew bundle install --file $BASEDIR/Brewfile
fi

function symlink() {
  SRC_LINK=$BASEDIR/${1}
  DST_LINK=$HOME/${2}
  if [[ -L ${DST_LINK} && -e ${DST_LINK} ]]; then
    echo "${2} exists and is symlinked corrected"
  else
    if [ -e ${DST_LINK} ]; then
      echo "Your ${2} exists but is not symlinked."
      rm -rf $DST_LINK
    else
      touch $DST_LINK
    fi
    echo "⤵ Symlinking your ${2} file"
    rm -r $DST_LINK
    ln -s $SRC_LINK $DST_LINK
    echo "✅ Successfully symlinked your ${2} file"
  fi
}

# dotfiles
symlink .zshenv .zshenv
for file in ./config/*; do symlink config/$(basename $file) .config/$(basename $file); done

if ! grep -q "source ~/.zshrc.remote" "$HOME/.zshrc"; then
  echo "source ~/.zshrc.remote" >>~/.zshrc
fi

# source zshrc to install packages
export SHELL=$(which zsh)
