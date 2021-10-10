#!/bin/bash

set -ue

has() {
  type "$1" > /dev/null 2>&1
}

symlink() {
  [ -e "$2" ] || ln -s "$1" "$2"
}

setup() {
  DOT_DIR=$HOME/dotfiles
  DOT_REPO="https://github.com/kogepanh/dotfiles.git"
  TAR_BALL="https://github.com/kogepanh/dotfiles/archive/main.tar.gz"

  if [ -d "$DOT_DIR" ]; then
    echo "dotfiles already exists"
    cd "$DOT_DIR" && git pull --rebase
    exit 1
  else
    if has "git"; then
      git clone "$DOT_REPO" "$HOME"
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

      ln -snf $DOT_DIR/$f $HOME/$f
      echo "$f"
    done
  fi
}

setup()

exit 0
