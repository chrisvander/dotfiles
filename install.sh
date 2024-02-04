#!/bin/bash

include() {
	[[ -f "$1" ]] && source "$1"
}

if ! command -v curl &>/dev/null; then
	echo "ERROR: curl could not be found"
	exit
fi

if ! command -v git &>/dev/null; then
	echo "ERROR: git could not be found"
	exit
fi

if ! command -v zsh &>/dev/null; then
	echo "ERROR: zsh could not be found"
	exit
fi

if [[ ! -e $HOME/.zshrc ]]; then
	touch ~/.zshrc
fi

if ! command -v brew &>/dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# brew bundle install --file $HOME/.dotfiles/Brewfile

# dotfiles
BASEDIR=$(pwd)
F_DOTFILES=$HOME/.dotfiles
if [[ -L ${F_DOTFILES} && -e ${F_DOTFILES} ]]; then
	echo ".dotfiles exists and is symlinked corrected"
else
	if [ -e ${F_DOTFILES} ]; then
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
if [[ -L ${ZSHRC_LINK} && -e ${ZSHRC_LINK} ]]; then
	echo ".zshrc.remote exists and is symlinked corrected"
else
	if [ -e ${ZSHRC_LINK} ]; then
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
	echo "source ~/.zshrc.remote" >>~/.zshrc
fi

ZSHENV_LINK=$HOME/.zshenv
if [[ -L ${ZSHENV_LINK} && -e ${ZSHENV_LINK} ]]; then
	echo ".zshenv exists and is symlinked corrected"
else
	if [ -e ${ZSHENV_LINK} ]; then
		echo "Your .zshenv exists but is not symlinked."
		rm $ZSHENV_LINK
	else
		touch $ZSHENV_LINK
	fi
	echo "⤵ Symlinking your .zshenv file"
	rm -r ~/.zshenv
	ln -s $BASEDIR/.zshenv $HOME/.zshenv
	echo "✅ Successfully symlinked your .zshenv file"
fi

if ! grep -q "source ~/.zshrc.remote" "$HOME/.zshrc"; then
	echo "source ~/.zshrc.remote" >>~/.zshrc
fi

# nvim init
VIMRC_DOTFILE=$HOME/.config/nvim
if [[ -L ${VIMRC_DOTFILE} && -e ${VIMRC_DOTFILE} ]]; then
	echo ".config/nvim directory exists and is symlinked corrected"
else
	if [ -e ${VIMRC_DOTFILE} ]; then
		echo "Your .config/nvim directory exists but is not symlinked."
		rm $VIMRC_DOTFILE
	else
		touch $VIMRC_DOTFILE
	fi
	echo "⤵ Symlinking your .config/nvim folder"
	mkdir -p $HOME/.config
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

# set up iterm2 if on mac
[[ -x "$(command -v defaults)" ]] && defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/"
[[ -x "$(command -v defaults)" ]] && defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
