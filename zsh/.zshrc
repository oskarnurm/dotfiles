unsetopt BEEP
export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export PATH="$HOME/dotfiles/scripts:$PATH"
export JAVA_HOME="/usr/bin/java"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

ZSH_THEME="robbyrussell"
DISABLE_LS_COLORS="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

file_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$file_dir_preview' --bind 'ctrl-o:execute(${EDITOR} {} &> /dev/tty)'"

bindkey -s '^F' 'tmux-sessionizer.sh\n'

# List Directory
alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias lt='eza --icons=auto --tree' # list folder as tree
alias ..='cd ..'
alias ...='cd ../..'

# Quality of life
alias v='nvim'
alias lg='lazygit'

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
