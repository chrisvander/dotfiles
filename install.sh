#!/bin/bash
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

brew bundle install --file $HOME/.dotfiles/Brewfile

BASEDIR=$(pwd)
function symlink() {
	SRC_LINK=$BASEDIR/${1}
	DST_LINK=$HOME/${2}
	if [[ -L ${DST_LINK} && -e ${DST_LINK} ]]; then
		echo "${2} exists and is symlinked corrected"
	else
		if [ -e ${DST_LINK} ]; then
			echo "Your ${2} exists but is not symlinked."
			rm $DST_LINK
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
symlink .dotfiles .dotfiles
symlink .zshrc .zshrc.remote
symlink .zshenv .zshenv
for file in ./config/*; do symlink config/$(basename $file) .config/$(basename $file); done

if ! grep -q "source ~/.zshrc.remote" "$HOME/.zshrc"; then
	echo "source ~/.zshrc.remote" >>~/.zshrc
fi

# source zshrc for install
export SHELL=$(which zsh)
