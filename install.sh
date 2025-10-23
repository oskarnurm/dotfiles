#!/usr/bin/env bash

print_header() {
  echo ""
  echo "=== $1 ==="
  echo ""
}

set -euo pipefail
sudo -v

print_header "Setting up Xcode"
if ! xcode-select -p &>/dev/null; then
  echo "📦 Installing Xcode Command Line Tools"
  xcode-select --install || true
else
  echo "Xcode Command Line Tools already installed."
fi

print_header "Setting up Homebrew"
if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "📦 Installing essential packages..."
  brew update && brew install git gh zsh neovim stow
fi

print_header "Configuring Git + SSH"
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
  echo "SSH key generated and added."
else
  echo "SSH key already exists."
  eval "$(ssh-agent -s)"
  ssh-add --apple-use-keychain "$KEY_PATH" || true
fi

if gh auth status &>/dev/null; then
  echo "GitHub CLI already authenticated."
else
  echo "Please authenticate GitHub CLI (web login required)..."
  # Use 'gh auth login' with the required scopes for key upload (and SSO if needed)
  gh auth login -w -s admin:public_key -h github.com
fi

if ! gh ssh-key list | grep -q "$TITLE"; then
  echo "Uploading SSH key to GitHub as \"$TITLE\"..."
  # This command requires the 'admin:public_key' scope granted in the step above
  gh ssh-key add "$KEY_PATH.pub" --title "$TITLE"
else
  echo "SSH key already uploaded to GitHub."
fi

if ! git config --global user.name &>/dev/null; then
  echo "Configuring Git..."
  git config --global user.name "$NAME"
  git config --global user.email "$EMAIL"
  git config --global init.defaultBranch main
  git config --global core.editor "nvim"
else
  echo "Git already configured."
fi

print_header "Managing Dotfiles"
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📦 Cloning dotfiles repo..."
  git clone git@github.com:oskarnurm/dotfiles.git "$DOTFILES_DIR"
else
    echo "Repo already installed"
fi

if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo "📦 Installing Brewfile packages..."
  brew bundle --file="$DOTFILES_DIR/Brewfile" || true
fi

print_header "Symlinking essentials"
DOTFILES_PACKAGES=(
  zsh
  nvim
  wezterm
  starship
  tmux
  ssh
  ripgrep
  karabiner
)
cd "$DOTFILES_DIR" || exit 1

for package in "${DOTFILES_PACKAGES[@]}"; do
  echo -n "🔗 Symlinking $package... " 
  if stow "$package"; then
    echo "Done."
  else
    echo "Failed (Conflict likely)."
  fi
done
echo "All dotfiles symlinked via Stow."

print_header "Applying macOS Settings"
SETTINGS_SCRIPT="$DOTFILES_DIR/settings.sh"
if [ -f "$SETTINGS_SCRIPT" ]; then
  chmod +x "$SETTINGS_SCRIPT"
  "$SETTINGS_SCRIPT"
fi

print_header "Setup complete"
