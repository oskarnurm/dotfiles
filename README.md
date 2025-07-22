### These are files important enough to warrant version control on my macOS Apple Silicon

> [!NOTE]
> External Requirements:
> - Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
> - [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
> - [fd-find](https://github.com/sharkdp/fd#installation)
> - A [Nerd Font](https://www.nerdfonts.com/)
> - `npm`, `pip`, etc
## How to install

My dotfiles are managed by [GNU Stow](https://www.gnu.org/software/stow/).

1. Install [homebrew](https://brew.sh/) 
2. Install [GNU Stow](https://www.gnu.org/software/stow/) `brew install stow`
3. Clone this repository `git clone https://github.com/oskarnurm/dotfiles.git ~/.dotfiles`
4. Run the stow command `stow <folder> -t ~`

> [!WARNING]  
> The out-of-the-box experience is probably not very smooth, as I mostly use this repo as a means of VC and haven't put much effort into the installation setup.

Each folder in this repository represents a **package**, which is a set of related configurations. For example:

- `zsh/` contains all Zsh shell configuration files  
- `nvim/` contains Neovim settings and plugins  
- `git/` holds Git configuration files
- etc.

When you run `stow <folder> -t ~`, Stow creates symlinks for all files inside that folder into your home directory.

To symlink everything, run:
```sh
stow . -t ~
```
To remove symlinks created by Stow:

```sh
stow -D <folder> -t ~
```

### TODO:
- [ ] Figure out how to manage apps like `Raycast`, `mouseless`, etc.
- [ ] Install script to manage stow and other settings.

