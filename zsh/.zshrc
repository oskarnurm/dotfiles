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
# For KTH
alias compsec="docker run -it --rm -v .:/workdir -w /workdir compsec"

# Fallback prompt
PS1="%{$fg[magenta]%}%1~%{$fg[red]%} %{$reset_color%}$%b "

export FZF_DEFAULT_OPTS="
--color='fg:#000000,current-fg:#000000,bg:#F7F8FA,current-bg:#D7E1FC'
--color='gutter:#F7F8FA,hl:#fc8c03,current-hl:#fc8c03'
--color='header:#000000,pointer:#D7E1FC,query:#000000,marker:#FAE7B7'
--color='border:#D3D3D3,separator:#D3D3D3,prompt:#000000,info:#8E8E8E,disabled:#8E8E8E'
--prompt=' > '
--margin 3%,1%
--border=horizontal
"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
