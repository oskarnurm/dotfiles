#!/usr/bin/env bash
#
# macOS Setup Script
# Usage:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/oskarnurm/dotfiles/main/setup.sh)"

print_header() {
  echo ""
  echo "=== $1 ==="
  echo ""
}

set -euo pipefail
sudo -v

print_header "🔧 Starting macOS setup..."

# Xcode
if ! xcode-select -p &>/dev/null; then
  echo "📦 Installing Xcode Command Line Tools..."
  xcode-select --install || true
else
  echo "✅ Xcode Command Line Tools already installed."
fi

# Homebrew
if ! command -v brew &>/dev/null; then
  print_header "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  print_header "📦 Installing essential packages..."
  brew update
  brew install git gh zsh neovim stow
fi

# Git + SSH
print_header "Setting up Git + SSH..."
EMAIL="19738295+oskarnurm@users.noreply.github.com"
NAME="oskarnurm"
KEY_PATH="$HOME/.ssh/id_ed25519"
TITLE="$(hostname)-$(date +%Y-%m-%d)"

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if [ ! -f "$KEY_PATH" ]; then
  echo "🔑 Generating SSH key..."
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
  eval "$(ssh-agent -s)"
  ssh-add --apple-use-keychain "$KEY_PATH"
  echo "✅ SSH key generated and added."
else
  echo "✅ SSH key already exists."
  eval "$(ssh-agent -s)"
  ssh-add --apple-use-keychain "$KEY_PATH" || true
fi

if gh auth status &>/dev/null; then
  echo "✅ GitHub CLI already authenticated."
else
  echo "🔐 Please authenticate GitHub CLI..."
  gh auth login
fi

if ! gh ssh-key list | grep -q "$TITLE"; then
  echo "📤 Uploading SSH key to GitHub as \"$TITLE\"..."
  gh ssh-key add "$KEY_PATH.pub" --title "$TITLE"
else
  echo "✅ SSH key already uploaded to GitHub."
fi

if ! git config --global user.name &>/dev/null; then
  echo "👤 Configuring Git..."
  git config --global user.name "$NAME"
  git config --global user.email "$EMAIL"
  git config --global init.defaultBranch main
  git config --global core.editor "nvim"
else
  echo "✅ Git already configured."
fi

# Dotfiles
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  print_header "📦 Cloning dotfiles repo..."
  git clone git@github.com:oskarnurm/dotfiles.git "$DOTFILES_DIR"
else
  echo "🔄 Updating existing dotfiles..."
  git -C "$DOTFILES_DIR" pull --rebase
fi

# Brewfile
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  print_header "📦 Installing Brewfile packages..."
  brew bundle --file="$DOTFILES_DIR/Brewfile" || true
fi

print_header "🔗 Creating symlinks for dotfiles using Stow..."
(cd "$DOTFILES_DIR" && brew install stow && stow zsh git tmux neovim karabiner starship ssh wezterm ripgrep)

# ---------- macOS Settings ----------
SETTINGS_SCRIPT="$DOTFILES_DIR/settings.sh"
if [ -f "$SETTINGS_SCRIPT" ]; then
  print_header "🔧 Applying macOS settings..."
  chmod +x "$SETTINGS_SCRIPT"
  "$SETTINGS_SCRIPT"
fi

source "$HOME/.zshrc"

print_header "🎉 Setup complete!"
echo "NOTE: Some apps may require manual permission grants in System Settings."
echo "       Import settings manually for apps like Raycast and Mouseless if needed."
echo "       Some changes (e.g., Dock, Finder) require logout/restart to fully apply."
