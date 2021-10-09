#!/bin/bash

set -ue

DOT_DIR="~/dotfiles"

has() {
  type "$1" > /dev/null 2>&1
}

if [ ! -d $DOT_DIR ]; then
  if has "git"; then
      git clone https://github.com/kogepanh/dotfiles.git ${DOT_DIR}
  else
    echo "git required"
    exit 1
  fi

  cd ${DOT_DIR}

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
