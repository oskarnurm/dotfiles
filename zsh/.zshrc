unsetopt BEEP
export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'

ZSH_THEME="robbyrussell"
DISABLE_LS_COLORS="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

file_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$file_dir_preview' --bind 'ctrl-o:execute(${EDITOR} {} &> /dev/tty)'"

tmux_sessionizer() {
  ~/dotfiles/scripts/tmux-sessionizer.sh
}
zle -N tmux_sessionizer
bindkey '^F' tmux_sessionizer

# List Directory
alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias ..='cd ..'
alias ...='cd ../..'

# Quality of life
alias v='nvim'
alias lg='lazygit'
alias gc='git commit -m'
alias ga='git add'
alias gt='git status'

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
