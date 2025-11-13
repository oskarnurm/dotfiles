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
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

export PATH="$HOME/dotfiles/scripts:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH"
export PATH="/opt/homebrew/opt/lld/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

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
alias vv='NVIM_APPNAME="nvim.bak" nvim'
alias lg="lazygit"
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' 
alias ls='eza -1 --icons=auto'
alias lt='eza --icons=auto --tree'
alias ..='cd ..'
alias ...='cd ../..'
alias rmdir='rm -rf'
alias vf="nvim -c 'Pick files'"
alias venv="python3 -m venv .venv"
# KTH
alias compsec="docker run -it --rm -v .:/workdir -w /workdir compsec"

# Fallback prompt
PS1="%{$fg[magenta]%}%1~%{$fg[red]%} %{$reset_color%}$%b "

# Fzf
export FZF_DEFAULT_OPTS="--color=bg:-1,fg:-1"

eval "$(starship init zsh)"
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

