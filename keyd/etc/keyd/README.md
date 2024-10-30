Step 1: Install GNU Stow (if not already installed)

If you don't have Stow installed, install it using your package manager:

sudo pacman -S stow  # On Arch-based systems

Step 2: Set Up Directory Structure

Create a directory structure in your home directory where you'll keep the version-controlled configuration files. For example:

bash

mkdir -p ~/dotfiles/keyd/etc/keyd/

Step 3: Move the Existing /etc/keyd Directory

To avoid conflicts, move the current /etc/keyd directory into your ~/dotfiles/keyd directory. This will also ensure that the contents are now managed within your version-controlled directory:

sudo mv /etc/keyd/* ~/dotfiles/keyd/etc/keyd/

Step 4: Symlink with GNU Stow

Now, navigate to your ~/dotfiles directory and use GNU Stow to create the symlink:

cd ~/dotfiles/keyd
stow -t /etc etc

Here:

    -t /etc specifies the target directory (/etc in this case).
    etc will contain the keyd directory inside ~/dotfiles/keyd/etc/ that you want to symlink.

This will create symlinks from the files in ~/dotfiles/keyd/ to /etc/keyd/."
