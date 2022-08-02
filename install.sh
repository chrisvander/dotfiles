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

if ! command -v unzip &> /dev/null
then
    echo "ERROR: unzip could not be found"
    exit
fi

if ! command -v zsh &> /dev/null
then
    echo "ERROR: zsh could not be found"
    exit
fi

include ~/.zshrc.local

if [ "$(uname)" == "Darwin" ]; then
   # install homebrew
   if ! command -v brew &> /dev/null
   then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   fi
   brew install neovim fnm ruby miniforge lazygit lazydocker code-minimap rust rustup
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
   # install miniforge
   curl -fsSL https://fnm.vercel.app/install | bash
   eval "`fnm env`"
   apt-get update -y
   apt-get install -y software-properties-common
   add-apt-repository -y ppa:neovim-ppa/stable
   apt-get update -y
   apt-get install -y neovim ruby-full python2 python3 pip
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   cargo install --locked code-minimap
fi

export PATH=~/.cargo/bin:/root/.fnm:$PATH

cargo install fnm

# activate NodeJS
fnm use 18.4.0 --install-if-missing

export NVIM_PLUGIN_HOME=$HOME/.config/nvim/site/autoload
mkdir -p $NVIM_PLUGIN_HOME

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

# p10k
P10K_DOTFILE=$HOME/.p10k.zsh
if [[ -L ${P10K_DOTFILE} && -e ${P10K_DOTFILE} ]] ; then
   echo ".p10k.zsh exists and is symlinked corrected"
else
   if [ -e ${P10K_DOTFILE} ] ; then
      echo "Your .p10k.zsh exists but is not symlinked."
      rm $P10K_DOTFILE
   else
      touch $P10K_DOTFILE
   fi
   echo "⤵ Symlinking your .p10k.zsh file"
   rm -r ~/.p10k.zsh
   ln -s $BASEDIR/.p10k.zsh $HOME/.p10k.zsh
   echo "✅ Successfully symlinked your .p10k.zsh file"
fi

# dotfiles
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

# nvim init
VIMRC_DOTFILE=$HOME/.config/nvim/init.vim
if [[ -L ${VIMRC_DOTFILE} && -e ${VIMRC_DOTFILE} ]] ; then
   echo "init.vim exists and is symlinked corrected"
else
   if [ -e ${VIMRC_DOTFILE} ] ; then
      echo "Your init.vim exists but is not symlinked."
      rm $VIMRC_DOTFILE
   else
      touch $VIMRC_DOTFILE
   fi
   echo "⤵ Symlinking your init.vim file"
   rm -r $HOME/.config/nvim/init.vim
   mkdir -p $HOME/.config/nvim
   ln -s $BASEDIR/init.vim $HOME/.config/nvim/init.vim
   echo "✅ Successfully symlinked your init.vim file"
fi

# add zinit
export NO_ANNEXES=yes
export NO_INPUT=yes
export NO_TUTORIAL=yes
export NO_EDIT=yes
sh -c "$(curl -fsSL https://git.io/zinit-install)"

# source zshrc for install
export SHELL=$(which zsh)
$SHELL -c "source $HOME/.zshrc && exit"
$SHELL -c "$PATH_TO_ZSH_DIR/custom/themes/powerlevel10k/gitstatus/install"

git config --global user.email "chris.vanderloo@yahoo.com"
git config --global user.name "Christian van der Loo"

[[ -x "$(command -v defaults)" ]] && defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/"
[[ -x "$(command -v defaults)" ]] && defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
