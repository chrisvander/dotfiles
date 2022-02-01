#!/bin/sh

ZINIT_HOME="${ZINIT_HOME:-$ZPLG_HOME}"
if [ -z "$ZINIT_HOME" ]; then
    ZINIT_HOME="${ZDOTDIR:-$HOME}/.zinit"
fi

ZINIT_BIN_DIR_NAME="${ZINIT_BIN_DIR_NAME:-$ZPLG_BIN_DIR_NAME}"
if [ -z "$ZINIT_BIN_DIR_NAME" ]; then
    ZINIT_BIN_DIR_NAME="bin"
fi

if ! test -d "$ZINIT_HOME"; then
    mkdir "$ZINIT_HOME"
    chmod g-w "$ZINIT_HOME"
    chmod o-w "$ZINIT_HOME"
fi

if ! command -v git >/dev/null 2>&1; then
    echo "[1;31m▓▒░[0m Something went wrong: no [1;32mgit[0m available, cannot proceed."
    exit 1
fi

# Get the download-progress bar tool
if command -v curl >/dev/null 2>&1; then
    mkdir -p /tmp/zinit
    cd /tmp/zinit 
    curl -fsSLO https://raw.githubusercontent.com/zdharma/zinit/master/git-process-output.zsh && \
        chmod a+x /tmp/zinit/git-process-output.zsh
elif command -v wget >/dev/null 2>&1; then
    mkdir -p /tmp/zinit
    cd /tmp/zinit 
    wget -q https://raw.githubusercontent.com/zdharma/zinit/master/git-process-output.zsh && \
        chmod a+x /tmp/zinit/git-process-output.zsh
fi

echo
if test -d "$ZINIT_HOME/$ZINIT_BIN_DIR_NAME/.git"; then
    cd "$ZINIT_HOME/$ZINIT_BIN_DIR_NAME"
    echo "[1;34m▓▒░[0m Updating [1;36mDHARMA[1;33m Initiative Plugin Manager[0m at [1;35m$ZINIT_HOME/$ZINIT_BIN_DIR_NAME[0m"
    git pull origin master
else
    cd "$ZINIT_HOME"
    echo "[1;34m▓▒░[0m Installing [1;36mDHARMA[1;33m Initiative Plugin Manager[0m at [1;35m$ZINIT_HOME/$ZINIT_BIN_DIR_NAME[0m"
    { git clone --progress https://github.com/zdharma/zinit.git "$ZINIT_BIN_DIR_NAME" \
        2>&1 | { /tmp/zinit/git-process-output.zsh || cat; } } 2>/dev/null
    if [ -d "$ZINIT_BIN_DIR_NAME" ]; then
        echo
        echo "[1;34m▓▒░[0m Zinit succesfully installed at [1;32m$ZINIT_HOME/$ZINIT_BIN_DIR_NAME[0m".
        VERSION="$(command git -C "$ZINIT_HOME/$ZINIT_BIN_DIR_NAME" describe --tags 2>/dev/null)" 
        echo "[1;34m▓▒░[0m Version: [1;32m$VERSION[0m"
    else
        echo
        echo "[1;31m▓▒░[0m Something went wrong, couldn't install Zinit at [1;33m$ZINIT_HOME/$ZINIT_BIN_DIR_NAME[0m"
    fi
fi