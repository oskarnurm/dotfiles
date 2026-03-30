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

eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR='nvim'
export RIPGREP_CONFIG_PATH=$HOME/dotfiles/.ripgreprc
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/dotfiles/scripts:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH"
export PATH="/opt/homebrew/opt/lld/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

autoload -U colors && colors
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
_comp_options+=(globdots)

bindkey -e  # Emacs keybinds
bindkey -s '^F' 'tw.sh\n'

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

function mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

# Set the prompt: dir:[branch] $
autoload -Uz vcs_info
precmd() {
    # This ensures Zsh's internal directory stack is synced 
    builtin cd . 2>/dev/null
    vcs_info
}

# Version Control Styling
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats ':[%F{9}%b%u%f]'

setopt PROMPT_SUBST
PS1='%B%F{cyan}%1~%f%b${vcs_info_msg_0_} %B$%b '

# FZF theme
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg:-1 \
  --color=bg+:0 \
  --color=border:12 \
  --color=fg:4 \
  --color=fg+:12 \
  --color=gutter:-1 \
  --color=header:12 \
  --color=hl+:11 \
  --color=hl:11 \
  --color=info:8 \
  --color=marker:1 \
  --color=pointer:12 \
  --color=prompt:12 \
  --color=query:15:regular \
  --color=scrollbar:12 \
  --color=separator:12 \
  --color=spinner:8 \
"

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
