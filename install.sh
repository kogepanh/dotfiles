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
  GITHUB_URL="https://github.com/kogepanh/dotfiles.git"
  TAR_BALL="https://github.com/kogepanh/dotfiles/archive/main.tar.gz"

  if [ -d "$DOT_DIR" ]; then
    echo "dotfiles already exists"
    cd "$DOT_DIR" && git pull --rebase
    exit 1
  else
    if has "git"; then
      git clone "$GITHUB_URL" "$HOME"
    elif has "curl" || has "wget"; then
      if has "curl"; then
        curl -L "$TAR_BALL"
      elif has "wget"; then
        wget -O - "$TAR_BALL"
      fi | tar zxv
      mv -f dotfiles-master "$DOT_DIR"
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

      ln -snfv "$DOT_DIR/$f" "$HOME"/"$f"
      echo "$f"
    done
  fi
}

setup()

exit 0
