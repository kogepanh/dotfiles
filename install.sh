#!/bin/bash

set -ue

DOT_DIR="~/dotfiles"

if [ ! -d $DOT_DIR ]; then
  for f in .??*
  do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".github" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue
    [[ "$f" == ".editorconfig" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    ln -snf "$DOT_DIR/$f" "~/$f"
    echo "$f"
  done
else
  echo "dotfiles already exists"
  exit 1
fi

exit 0
