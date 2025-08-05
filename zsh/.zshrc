# Prevent the terminal from peeping
unsetopt BEEP

alias v="nvim"
alias lg="lazygit"
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' 
alias ls='eza -1   --icons=auto'
alias lt='eza --icons=auto --tree'
alias ..='cd ..'
alias ...='cd ../..'

bindkey -e # Emacs style keybinds
bindkey -s '^F' 'tmux-sessionizer.sh\n'

function mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

# Better History
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

# Load completions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case insensitive
_comp_options+=(globdots) # Include hidden files.


# Shell integrations
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# Source zsh plugins
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
