#!/bin/bash

set -ue

DOT_DIR="~/dotfiles"
DOT_REPO="https://github.com/kogepanh/dotfiles.git"

has() {
  type "$1" > /dev/null 2>&1
}

if [ ! -d $DOT_DIR ]; then
  if has "git"; then
    git clone $DOT_REPO $HOME
  else
    echo "Error: git required"
    exit 1
  fi

  cd $DOT_DIR

  for f in .??*
  do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".github" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".editorconfig" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    ln -snf "$DOT_DIR/$f" $HOME"/$f"
    echo "$f"
  done
else
  echo "dotfiles already exists"
  exit 1
fi

exit 0
