#!/bin/bash

include () {
    [[ -f "$1" ]] && source "$1"
}

if ! command -v curl &> /dev/null
then
    echo "ERROR: curl could not be found"
    exit
fi

if ! command -v zsh &> /dev/null
then
    echo "ERROR: zsh could not be found"
    exit
fi

chsh -s /bin/zsh

include ~/.zshrc.local

# Set up zsh tools
PATH_TO_ZSH_DIR=$HOME/.oh-my-zsh
if [ -d $PATH_TO_ZSH_DIR ]
then
   echo "$PATH_TO_ZSH_DIR directory exists! Skipping installation of zsh tools."
else
   echo "⤵ Configuring zsh tools in the $HOME directory..."
   (cd $HOME && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended)
   echo "✅ Successfully installed zsh tools"
fi

# Set up symlink for .zshrc
BASEDIR=$(pwd)
ZSHRC_LINK=$HOME/.zshrc
if [[ -L ${ZSHRC_LINK} && -e ${ZSHRC_LINK} ]] ; then
   echo ".zshrc exists and is symlinked corrected"
else
   if [ -e ${ZSHRC_LINK} ] ; then
      echo "Your .zshrc exists but is not symlinked."
      rm $ZSHRC_LINK
   else
      touch $ZSHRC_LINK
   fi
   echo "⤵ Symlinking your .zshrc file"
   rm -r ~/.zshrc
   ln -s $BASEDIR/.zshrc $HOME/.zshrc
   echo "✅ Successfully symlinked your .zshrc file"
fi

# symlink theme dotfile
rm -rf $HOME/.p10k.zsh
ln -s $BASEDIR/.p10k.zsh $HOME/.p10k.zsh

# add zinit
export NO_ANNEXES=yes
export NO_INPUT=yes
export NO_TUTORIAL=yes
export NO_EDIT=yes
sh -c "$(curl -fsSL https://git.io/zinit-install)"

# source zshrc for install
export SHELL=$(which zsh)
$SHELL -c "source $HOME/.zshrc && exit"
$SHELL -c "echo \"\" && exit"

git config --global user.email "chris.vanderloo@yahoo.com"
git config --global user.name "Christian van der Loo"

[[ -x "$(command -v defaults)" ]] && defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/Developer/dotfiles/"
[[ -x "$(command -v defaults)" ]] && defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true