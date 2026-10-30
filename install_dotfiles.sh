#!/bin/bash
set -euo pipefail

REPO="https://github.com/$USER/dotfiles.git"
dots() { git --git-dir="$HOME/.dots" --work-tree="$HOME" "$@"; }

# 1. Homebrew (also installs Xcode CLT, which provides git)
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

# 2. Dotfiles
if [ ! -d "$HOME/.dots" ]; then
  git clone --bare "$REPO" "$HOME/.dots"
  config checkout
  config config status.showUntrackedFiles no
fi

# 3. Packages
brew bundle --global

# 4. Anything not in Homebrew goes here, guarded so re-runs are safe:
# command -v foo >/dev/null || curl -fsSL https://example.com/install.sh | sh
