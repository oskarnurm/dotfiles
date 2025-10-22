#!/bin/bash

set -e  # Exit on any error for safety

# Function to print section headers
print_header() {
    echo ""
    echo "=== $1 ==="
    echo ""
}

# Install Xcode CLI tools
print_header "Installing Xcode Command Line Tools"
xcode-select --install

echo "Waiting for Xcode installation to complete..."
while ! xcode-select -p &>/dev/null; do
  sleep 20
done
echo "Xcode Command Line Tools installed!"

# Install Homebrew if not present
print_header "Installing Homebrew"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrew installed successfully!"
else
  echo "Homebrew is already installed"
fi

# Add Homebrew to PATH (for Apple Silicon; adjust for Intel if needed)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install git minimally (required for cloning dotfiles)
print_header "Installing Git via Homebrew"
if ! command -v git &>/dev/null; then
  brew install git
  echo "Git installed!"
else
  echo "Git is already installed"
fi

# Clone dotfiles if not present
print_header "Cloning Dotfiles Repository"
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone git@github.com:oskarnurm/dotfiles.git "$DOTFILES_DIR"
  echo "Dotfiles cloned to $DOTFILES_DIR"
else
  echo "Dotfiles already exist at $DOTFILES_DIR"
fi

# Change to dotfiles directory for subsequent operations
cd "$DOTFILES_DIR"

# Install packages via Brewfile 
print_header "Installing Packages via Brewfile"
if [ -f "Brewfile" ]; then
  brew bundle --file=Brewfile
  echo "Packages installed via Brewfile!"
else
  echo "Warning: Brewfile not found in dotfiles. Skipping package installation."
fi

# Apply macOS settings via settings.sh (assumes settings.sh exists in dotfiles root)
print_header "Applying macOS Settings"
if [ -f "settings.sh" ]; then
  # Make executable if needed
  chmod +x settings.sh
  ./settings.sh
  echo "macOS settings applied!"
else
  echo "Warning: settings.sh not found in dotfiles. Skipping macOS settings."
fi

# SSH and GitHub setup (kept as-is, since it's specific; consider moving to dotfiles if generalizable)
print_header "Setting up SSH and GitHub"
EMAIL="19738295+oskarnurm@users.noreply.github.com"
KEY_PATH="$HOME/.ssh/id_ed25519"

if ! gh auth status &>/dev/null; then
  echo "You're not logged in to GitHub CLI. Launching login flow..."
  gh auth login
fi

# Generate SSH key if it doesn't exist
if [ -f "$KEY_PATH" ]; then
  echo "SSH key already exists at $KEY_PATH; skipping generation."
else
  echo "Generating a new ed25519 SSH key at $KEY_PATH..."
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
fi

echo "Adding key to ssh-agent and keychain..."
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain "$KEY_PATH"

# Upload public key to GitHub
TITLE="$(hostname)-$(date +%Y-%m-%d)"
echo "Uploading $KEY_PATH.pub to GitHub as \"$TITLE\"..."
gh ssh-key add "$KEY_PATH.pub" --title "$TITLE"

echo "SSH setup complete!"

# Install symlinks via Stow
print_header "Installing Dotfiles Symlinks"
stow . -t ~ --verbose=1  # --verbose for better feedback; remove if too noisy
echo "Dotfiles symlinks installed!"

# Source zshrc
print_header "Sourcing zshrc"
zsh -c "source ~/.zshrc"
echo "zshrc sourced!"

# Restart Karabiner
print_header "Restarting Karabiner"
if command -v karabiner &>/dev/null; then
  launchctl kickstart -k gui/$(id -u)/org.pqrs.service.agent.karabiner_console_user_server
  echo "Karabiner restarted!"
else
  echo "Karabiner not installed; skipping restart."
fi

# Open key apps
print_header "Opening Installed Apps"
for app in 'Karabiner-Elements' 'WezTerm' 'Raycast' 'Mouseless' 'Mos'; do
  if command -v "open -a '$app'" &>/dev/null; then
    open -a "$app"
    echo "Opened $app"
  else
    echo "Warning: $app not found; skipping."
  fi
done

print_header "Installation Complete!"
echo "NOTE: Some apps may require manual permission grants in System Settings."
echo "       Import settings manually for apps like Raycast and Mouseless if needed."
echo "       Some changes (e.g., Dock, Finder) require logout/restart to fully apply."
