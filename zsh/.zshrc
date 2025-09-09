autoload -U colors && colors
PS1="%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}$%b "

unsetopt BEEP # Prevent the terminal from peeping
alias v="nvim"
alias vv='NVIM_APPNAME="nvim-old" nvim'
alias lg="lazygit"
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' 
alias ls='eza -1 --icons=auto'
alias lt='eza --icons=auto --tree'
alias ..='cd ..'
alias ...='cd ../..'
alias rmdir='rm -rf'
# KTH specific
alias compsec="docker run -it --rm -v .:/workdir -w /workdir compsec"


bindkey -e # Emacs style keybinds
bindkey -s '^F' 'tw.sh\n'
function mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

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

autoload -Uz compinit && compinit # Load completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case insensitive
_comp_options+=(globdots) # Include hidden files.

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
