#!/bin/sh

include () {
    [[ -f "$1" ]] && source "$1"
}

include ~/.zshrc.local

# Credit: Joe Previte (@jsjoeio) - https://github.com/jsjoeio/dotfiles/blob/master/install.sh
###########################
# zsh setup
###########################

# Set up zsh tools
PATH_TO_ZSH_DIR=$HOME/.oh-my-zsh
if [ -d $PATH_TO_ZSH_DIR ]
then
   echo "\n$PATH_TO_ZSH_DIR directory exists! Skipping installation of zsh tools."
else
   echo "⤵ Configuring zsh tools in the $HOME directory..."
   (cd $HOME && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended)
   echo "✅ Successfully installed zsh tools"
fi

# Set up symlink for .zshrc
BASEDIR=$(pwd)
ZSHRC_LINK=$HOME/.zshrc
if [ -L ${ZSHRC_LINK} ] ; then
   if [ -e ${ZSHRC_LINK} ] ; then
      echo "\n.zshrc is symlinked corrected"
   else
      echo "\nOops! Your symlink appears to be broken."
   fi
elif [ -e ${ZSHRC_LINK} ] ; then
   echo "\nYour .zshrc exists but is not symlinked."
   # We have to symlink the .zshrc after we curl the install script
   # because the default zsh tools installs a new one, even if it finds ours
   rm $HOME/.zshrc
   echo "⤵ Symlinking your .zshrc file"
   rm -r ~/.zshrc
   ln -s $BASEDIR/.zshrc $HOME/.zshrc
   echo "✅ Successfully symlinked your .zshrc file"
else
   echo "\nUh-oh! .zshrc missing."
fi

export SHELL=$(which zsh)

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
$SHELL -c "source $HOME/.zshrc && echo DONE && exit"

###########################
# end zsh setup
###########################

git config --global user.email "chris.vanderloo@yahoo.com"
git config --global user.name "Christian van der Loo"
