#!/bin/bash

include () {
    [[ -f "$1" ]] && source "$1"
}

if ! command -v curl &> /dev/null
then
    echo "ERROR: curl could not be found"
    exit
fi

if ! command -v git &> /dev/null
then
    echo "ERROR: git could not be found"
    exit
fi

if ! command -v zsh &> /dev/null
then
    echo "ERROR: zsh could not be found"
    exit
fi

if [[ ! -a $HOME/.zshrc ]]; then
    touch ~/.zshrc
fi

if ! command -v brew &> /dev/null
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# brew bundle install --file $HOME/.dotfiles/Brewfile

# dotfiles
BASEDIR=$(pwd)
F_DOTFILES=$HOME/.dotfiles
if [[ -L ${F_DOTFILES} && -e ${F_DOTFILES} ]] ; then
   echo ".dotfiles exists and is symlinked corrected"
else
   if [ -e ${F_DOTFILES} ] ; then
      echo "Your .dotfiles exists but is not symlinked."
      rm $F_DOTFILES
   else
      touch $F_DOTFILES
   fi
   echo "⤵ Symlinking your .dotfiles file"
   rm -r ~/.dotfiles
   ln -s $BASEDIR/.dotfiles $HOME/.dotfiles
   echo "✅ Successfully symlinked your .dotfiles file"
fi

# Set up symlink for .zshrc
ZSHRC_LINK=$HOME/.zshrc.remote
if [[ -L ${ZSHRC_LINK} && -e ${ZSHRC_LINK} ]] ; then
   echo ".zshrc.remote exists and is symlinked corrected"
else
   if [ -e ${ZSHRC_LINK} ] ; then
      echo "Your .zshrc.remote exists but is not symlinked."
      rm $ZSHRC_LINK
   else
      touch $ZSHRC_LINK
   fi
   echo "⤵ Symlinking your .zshrc.remote file"
   rm -r ~/.zshrc.remote
   ln -s $BASEDIR/.zshrc $HOME/.zshrc.remote
   echo "✅ Successfully symlinked your .zshrc file"
fi

if ! grep -q "source ~/.zshrc.remote" "$HOME/.zshrc"; then
  echo "source ~/.zshrc.remote" >> ~/.zshrc
fi

# nvim init
VIMRC_DOTFILE=$HOME/.config/nvim/init.lua
if [[ -L ${VIMRC_DOTFILE} && -e ${VIMRC_DOTFILE} ]] ; then
   echo "init.lua exists and is symlinked corrected"
else
   if [ -e ${VIMRC_DOTFILE} ] ; then
      echo "Your init.lua exists but is not symlinked."
      rm $VIMRC_DOTFILE
   else
      touch $VIMRC_DOTFILE
   fi
   echo "⤵ Symlinking your .config/nvim folder"
   rm -rf $HOME/.config/nvim
   ln -s $BASEDIR/nvim $HOME/.config/nvim
   echo "✅ Successfully symlinked your .config/nvim folder"
fi

# add zinit
export NO_ANNEXES=yes
export NO_INPUT=yes
export NO_TUTORIAL=yes
export NO_EDIT=yes
# sh -c "$(curl -fsSL https://git.io/zinit-install)"

# source zshrc for install
export SHELL=$(which zsh)
# $SHELL -c "source $HOME/.zshrc && exit"

# git config --global user.email "chris.vanderloo@yahoo.com"
# git config --global user.name "Christian van der Loo"

# set up iterm2 if on mac
[[ -x "$(command -v defaults)" ]] && defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/"
[[ -x "$(command -v defaults)" ]] && defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
