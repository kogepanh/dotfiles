# .zshrc

# Env Var
export LANG=ja_JP.UTF-8

# Using ZSH for M1 Mac
# https://github.com/sindresorhus/pure/issues/584#issuecomment-989054653
fpath+=/opt/homebrew/share/zsh/site-functions

# pure
# https://github.com/sindresorhus/pure#getting-started
autoload -U promptinit; promptinit
prompt pure

# zsh-completions
# https://github.com/zsh-users/zsh-completions#usage
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

## 色を使用出来るようにする
autoload -Uz colors
colors

#
setopt nonomatch

# 同時に起動しているzshの間でhistoryを共有する
setopt share_history

# 同じコマンドをhistoryに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンドをhistoryに残さない
setopt hist_ignore_space

# historyに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
