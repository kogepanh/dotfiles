#!/bin/bash

set -eux

function die(){
  echo $@ >&2
  exit 1
}

function has() {
  type "$1" > /dev/null 2>&1
}

# function symlink() {
#   [ -e "$2" ] || ln -s "$1" "$2"
# }

function setup() {
  # if [ -d "$DOT_DIR" ]; then
  #   echo "dotfiles already exists"
  #   cd "$DOT_DIR" && git pull --rebase
  # else
  if [has "git"]; then
    git clone "$GITHUB_URL" "$HOME"
  elif [has "curl"]; then
    curl -L "$TAR_BALL"
    mv -f dotfiles-master "$DOT_DIR"
  elif [has "wget"]; then
    wget -O - "$TAR_BALL"
    mv -f dotfiles-master "$DOT_DIR"
  else
    die "git or curl or wget required"
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

    ln -snfv "$DOT_DIR/$f" "$HOME"/"$f"
    echo "$f"
  done
  # fi
}

DOT_DIR=$HOME/dotfiles
GITHUB_URL="https://github.com/kogepanh/dotfiles.git"
TAR_BALL="https://github.com/kogepanh/dotfiles/archive/main.tar.gz"

setup()
