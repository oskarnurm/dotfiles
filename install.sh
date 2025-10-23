#!/usr/bin/env bash
#
# macOS Setup Script
# Usage:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/oskarnurm/dotfiles/main/setup.sh)"

set -euo pipefail

echo "🔧 Starting macOS setup..."

# ---------- Xcode ----------
if ! xcode-select -p &>/dev/null; then
  echo "📦 Installing Xcode Command Line Tools..."
  xcode-select --install || true
else
  echo "✅ Xcode Command Line Tools already installed."
fi

# ---------- Homebrew ----------
if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "📦 Installing essential packages..."
brew update
brew install git gh zsh neovim tmux tree wget curl

# ---------- Git + SSH ----------
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
  gh auth login -w -s admin:public_key
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

# ---------- Dotfiles ----------
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📦 Cloning dotfiles repo..."
  git clone git@github.com:oskarnurm/dotfiles.git "$DOTFILES_DIR"
else
  echo "🔄 Updating existing dotfiles..."
  git -C "$DOTFILES_DIR" pull --rebase
fi

echo "🔗 Creating symlinks for zsh & git..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# ---------- Shell ----------
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "💡 Changing default shell to zsh..."
  chsh -s /bin/zsh || true
fi

# ---------- Brewfile ----------
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo "📦 Installing Brewfile packages..."
  brew bundle --file="$DOTFILES_DIR/Brewfile" || true
fi

# ---------- macOS Settings ----------
SETTINGS_SCRIPT="$DOTFILES_DIR/settings.sh"
if [ -f "$SETTINGS_SCRIPT" ]; then
  echo "🔧 Applying macOS settings..."
  chmod +x "$SETTINGS_SCRIPT"
  "$SETTINGS_SCRIPT"
fi

# ---------- Done ----------
echo "🎉 Setup complete! Open a new terminal or run 'zsh' to get started."
echo "NOTE: Some apps may require manual permission grants in System Settings."
echo "       Import settings manually for apps like Raycast and Mouseless if needed."
echo "       Some changes (e.g., Dock, Finder) require logout/restart to fully apply."
