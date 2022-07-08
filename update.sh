#!/bin/bash

cd ~/.dotfiles

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
  true
elif [ $LOCAL = $BASE ]; then
  git pull &> /dev/null
  source ~/.dotfiles/install.sh &> /dev/null
  source ~/.zshrc &> /dev/null
fi