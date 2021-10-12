#!/bin/bash

set -eux

function die(){
  echo $@ >&2
  exit 1
}

function has() {
  type "$1" > /dev/null 2>&1
}

function setup() {
  if [ -d "$DOT_DIR" ]; then
    cd "$DOT_DIR" && git pull --rebase
  else
    cd $HOME

    if has "git"; then
      git clone "$GITHUB_URL"
    elif has "curl" || has "wget"; then
      # if has "curl"; then
      #   curl -L "$TAR_BALL"
      if has "wget"; then
        wget -O "$TAR_BALL"
      fi | tar zxv
      mv -f dotfiles-main "$DOT_DIR"
    else
      die "git or curl, wget required"
    fi

    cd $DOT_DIR

    for f in .??*
    do
      [[ "$f" == ".git" ]] && continue
      [[ "$f" == ".github" ]] && continue
      [[ "$f" == ".gitignore" ]] && continue
      [[ "$f" == ".gitattributes" ]] && continue
      [[ "$f" == ".editorconfig" ]] && continue
      [[ "$f" == ".DS_Store" ]] && continue

      ln -snfv "$DOT_DIR/$f" "$HOME"/"$f" && echo "$f"
    done
  fi
}

DOT_DIR=$HOME/dotfiles
GITHUB_URL="https://github.com/kogepanh/dotfiles.git"
TAR_BALL="https://github.com/kogepanh/dotfiles/archive/main.tar.gz"

setup
