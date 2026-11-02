#!/bin/sh
# New machine: curl -fsSL https://ranger128.github.io/bootstrap.sh | sh
set -e
 
main() {
  if ! command -v brew >/dev/null; then
    sudo -v
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
 
  git clone --bare https://github.com/ranger128/dotfiles.git "$HOME/.dots"
  git --git-dir="$HOME/.dots" config remote.origin.pushurl git@github.com:ranger128/dotfiles.git
  git --git-dir="$HOME/.dots" --work-tree="$HOME" checkout
  git --git-dir="$HOME/.dots" --work-tree="$HOME" config status.showUntrackedFiles no
 
  brew bundle --global
}
 
main
