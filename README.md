# Files that are important enough for version control

Configured on/for macOS Apple Silicon.  Copy at your own discretion.

## How to install

1. Install command-line tools (macOS only):

```bash
xcode-select --install
```

2. Install [homebrew](https://brew.sh/):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

3. Clone this repository:

```bash
git clone https://github.com/oskarnurm/dotfiles.git ~/dotfiles
```

4. Install packages:
```bash
cd ~/dotfiles
brew bundle --file=Brewfile
```

5. Symlink the configs you want with [stow](https://www.gnu.org/software/stow/):

```bash
cd ~/dotfiles
stow <folder>
```

6. Apply macOS settings:
```bash
chmod +x settings.sh
./settings.sh
```

## Via install script
```bash
# Install Xcode CLI tools first (if not done)
xcode-select --install

# Clone and run the installer
git clone https://github.com/oskarnurm/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```
