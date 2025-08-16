# Environment variables
export EDITOR='nvim'

# PATH tweaks
export PATH="$HOME/dotfiles/scripts:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"
# export JAVA_HOME="/usr/bin/java"  # enable if needed
PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH


