#!/bin/bash

set -ue

DOTFILES_DIR=$HOME"/dotfiles"

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".github" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue

  ln -snf $DOTFILES_DIR/"$f" $HOME/"$f"

  echo "$f"
done

exit 0
