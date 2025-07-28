# Oskar's dotfiles

Configured on macOS Apple Silicon. Files that are important enough for version control. Copy at your discretion.

## How to install

1. Install command-line tools (macOS only):

```bash
xcode-select --install
```

2. Install [homebrew](https://brew.sh/):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Clone this repository:

```bash
git clone https://github.com/oskarnurm/dotfiles.git ~/dotfiles
```

6. Tap into brew:

```bash
cd ~/dotfiles/brew
brew bundle
```

5. Symlink the configs you want with [stow](https://www.gnu.org/software/stow/):

```bash
cd ~/dotfiles
stow <folder>
```
