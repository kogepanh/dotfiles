#!/bin/bash

set -ue

DOTFILES_DIR="$HOME/dotfiles"

# ln -s $DOTFILES_DIR/.vimrc ~/.vimrc
# ln -s .config ~/.config

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".github" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue

  ln -snf $DOTFILES_DIR/"$f" $HOME/".$f"

  echo "$f"
done

exit 0
