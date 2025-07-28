#!/bin/bash

# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

echo "Waiting for xcode-select installation to complete..."
while ! xcode-select -p &>/dev/null; do
  sleep 20
done
echo "Commandline tools installed!"

# Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrew installed successfully!"
else
  echo "Homebrew is already installed"
fi

# Shell configuration for homebrew
echo "Adding Homebrew to PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# TODO: maybe not necessary if we symlink our zprofile before this
# Only add it to zprofile if not already there
if ! grep -qxF 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile; then
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
fi

echo "Installing Brew Formulae..."
brew install zsh
brew install wget
brew install git
brew install stow
brew install bat
brew install eza
brew install fd
brew install fzf
brew install zoxide
brew install gh
brew install ripgrep
brew install starship
brew install zsh-autosuggestions
brew install zsh-fast-syntax-highlighting
brew install node
brew install neovim
brew install lua-language-server
brew install stylua
brew install tmux
brew install tree
brew install lua-language-server
brew install python@3.13
brew install openjdk
brew install lazygit
brew install ffmpeg
brew install imagemagick
brew install jq

echo "Installing Brew Casks..."
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask raycast
brew install --cask wezterm
brew install --cask google-chrome
brew install --cask mouseless@preview
brew install --cask hammerspoon
brew install --cask karabiner-elements
brew install --cask monitorcontrol
brew install --cask mos
brew install --cask discord
brew install --cask spotify
brew install --cask ghostty
brew install --cask gimp
brew install --cask postman
brew install --cask tomatobar
brew install --cask whatsapp
brew install --cask zen-browser
brew install --cask chatgpt
brew install --cask zotero
brew install --cask adobe-acrobat-reader

# Close any open System Settings panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Settings" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Disable transparency in the menu bar and elsewhere on Yosemite
defaults write com.apple.universalaccess reduceTransparency -bool false

# Enable Reduce Motion
defaults write com.apple.universalaccess reduceMotion -bool true
defaults write com.apple.Accessibility ReduceMotionEnabled -bool true

# Remove window resizing animations
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Show scrollbar when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "sv" "en"

# Save screenshots to a folder
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
chflags nohidden ~/Library

# Make dock smaller
defaults write com.apple.dock tilesize -int 60

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Set dock to the left
defaults write com.apple.dock orientation -string bottom

# Dragging with three finger drag on trackpad
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"

# Disable UI sound effects
defaults write -g com.apple.sound.uiaudio.enabled -int 0

# Disable hot corners
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

killall Dock
killall Finder
echo "Done. Note that some of these changes require a logout/restart to take effect."

# ssh, git setup
echo "Setting up ssh.."
if ! gh auth status &>/dev/null; then
  echo "You're not logged in to GitHub CLI. Launching login flow..."
  gh auth login
fi

EMAIL=19738295+oskarnurm@users.noreply.github.com.
KEY_PATH="$HOME/.ssh/id_ed25519"

# Generate SSH key if it doesn't already exist
if [ -f "$KEY_PATH" ]; then
  echo "SSH key already exists at $KEY_PATH; skipping generation."
else
  echo "Generating a new ed25519 SSH key at $KEY_PATH..."
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
fi

echo "Adding key to ssh-agent and keychain..."
eval "$(ssh-agent -s)"
# For macOS 12+:
ssh-add --apple-use-keychain "$KEY_PATH"

# Upload public key to GitHub
TITLE="$(hostname)-$(date +%Y-%m-%d)"
echo "Uploading $KEY_PATH.pub to GitHub as \"$TITLE\"..."
gh ssh-key add "$KEY_PATH.pub" --title "$TITLE"

echo "Done! Your SSH key is set up and added to GitHub."

echo "Installing dotfiles..."
[ ! -d "$HOME/dotfiles" ] && git clone git@github.com:oskarnurm/dotfiles.git $HOME/dotfiles

cd "$HOME/dotfiles"
echo "Running stow command..."
stow . -t ~

echo "Configuring tmux plugin manager..."
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
echo "
- Install tmux plugins with:
- 'ctrl+b' amd then 'shift+i'
"

echo "Sourcing ~/.zshrc file, please wait..."
zsh -c "source ~/.zshrc"

echo "Configuring karabiner..."
echo "Restarting karabiner process after created symlinks"
# Command may change, got it from here
# https://karabiner-elements.pqrs.org/docs/manual/operation/restart/
launchctl kickstart -k gui/$(id -u)/org.pqrs.service.agent.karabiner_console_user_server

echo "Configuring Hammerspoon with VimSpoon..."
mkdir -p ~/.hammerspoon/Spoons
git clone https://github.com/dbalatero/VimMode.spoon $HOME/.hammerspoon/Spoons/VimMode.spoon

echo "Open installed apps..."
open -a 'Karabiner-Elements'
open -a 'WezTerm'
open -a 'Raycast'
open -a "Mouseless"
open -a "Mos"
open -a "Hammerspoon"

echo "
NOTE:
Some apps might not be working as you need to enable their permissions
in system settings. 
Some apps need their settins to be imported manually:
- Raycast
- Mouseless
"
echo -e "Installation complete...\n"
