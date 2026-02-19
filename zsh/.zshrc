# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Remove BEEP
unsetopt BEEP

export EDITOR='nvim'
export RIPGREP_CONFIG_PATH=$HOME/dotfiles/.ripgreprc
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/dotfiles/scripts:$PATH"
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH"
export PATH="/opt/homebrew/opt/lld/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

autoload -U colors && colors
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
_comp_options+=(globdots)

bindkey -e  # Emacs keybinds
bindkey -s '^F' 'tw.sh\n'

function mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

alias v="nvim"
alias vi='NVIM_APPNAME=nvim-pack nvim'
alias vl='NVIM_APPNAME=nvim-lazy nvim'
alias lg="lazygit"
alias la='eza -lha --icons=auto --sort=name --group-directories-first' 
alias ls='eza -1 --icons=auto'
alias lt='eza --icons=auto --tree'
alias ..='cd ..'
alias ...='cd ../..'
alias rmdir='rm -rf'
alias venv="python3 -m venv .venv"

# KTH
alias compsec="docker run -it --rm -v .:/workdir -w /workdir compsec"

# Load the version control system module
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the git output: [branch]
zstyle ':vcs_info:git:*' formats '%F{#ffffff}[%b]%f'

# Enable substitutions in the prompt string
setopt PROMPT_SUBST

# Set the prompt: dir[branch]$
PS1='%F{#f4b8e4}%1~%f${vcs_info_msg_0_} %F{#d9ba73}$%f '

# eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# conda initialize 
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup


# Force zsh to refresh its PWD variable to match the actual directory
cd .
