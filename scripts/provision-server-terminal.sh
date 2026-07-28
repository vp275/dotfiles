#!/usr/bin/env bash
set -euo pipefail

# Provision the terminal tools needed by the server Stow package. Run this as
# the non-root server user from a checkout of this repository.

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
NVIM_VERSION='0.12.4'
NVIM_ARCHIVE="nvim-linux-x86_64.tar.gz"
NVIM_URL="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/${NVIM_ARCHIVE}"
NVIM_ROOT="$HOME/.local/opt/nvim-v${NVIM_VERSION}"
NVIM_ARCHIVE_PATH="$HOME/.cache/$NVIM_ARCHIVE"

if [[ ! -d "$DOTFILES_DIR/server" ]]; then
  printf 'Expected server package at %s/server\n' "$DOTFILES_DIR" >&2
  exit 1
fi

sudo apt-get update
sudo apt-get install -y \
  atool \
  bat \
  btop \
  cmake \
  direnv \
  fd-find \
  fzf \
  highlight \
  poppler-utils \
  ranger \
  stow \
  tmux \
  unzip \
  w3m \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting

mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/.local/opt" "$HOME/.cache"

if [[ ! -x "$NVIM_ROOT/bin/nvim" ]]; then
  install_dir=$(mktemp -d)
  curl -fL --retry 3 --output "$NVIM_ARCHIVE_PATH" "$NVIM_URL"
  tar -xzf "$NVIM_ARCHIVE_PATH" -C "$install_dir"
  mv "$install_dir/nvim-linux-x86_64" "$NVIM_ROOT"
  rmdir "$install_dir"
fi
ln -sfn "$NVIM_ROOT/bin/nvim" "$HOME/.local/bin/nvim"

clone_if_missing() {
  local repository="$1"
  local destination="$2"
  if [[ ! -d "$destination/.git" ]]; then
    mkdir -p "$(dirname "$destination")"
    git clone --depth 1 "$repository" "$destination"
  fi
}

clone_if_missing https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
clone_if_missing https://github.com/romkatv/powerlevel10k.git \
  "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
clone_if_missing https://github.com/Aloxaf/fzf-tab.git \
  "$HOME/.oh-my-zsh/custom/plugins/fzf-tab"

cd "$DOTFILES_DIR"
stow -n -v server
stow server

"$HOME/.local/bin/bat" cache --build
clone_if_missing https://github.com/tmux-plugins/tpm \
  "$HOME/.local/share/tmux/plugins/tpm"
"$HOME/.local/share/tmux/plugins/tpm/bin/install_plugins"

printf 'Server terminal tools are installed. Test with: zsh -lic "command -v nvim ranger bat btop tmux"\n'
