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
# For KTH
alias compsec="docker run -it --rm -v .:/workdir -w /workdir compsec"

# Fallback prompt
PS1="%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}$%b "


# Light theme for fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
--color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
--color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
--color=selected-bg:#BCC0CC \
--color=border:#9CA0B0,label:#4C4F69"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
