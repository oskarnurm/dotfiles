if status is-interactive
    starship init fish | source
end

set -g fish_greeting

# Variables
set -Ux EDITOR nvim
# Custom scripts executable from everywhere
set -gx PATH $HOME/dotfiles/scripts $PATH
set -Ux XDG_CONFIG_HOME $HOME/.config
# For Apple Silicon Macs the homebrew path needs to set for it to work in other shells like fish
set -U fish_user_paths /opt/homebrew/bin $fish_user_paths

# List Directory
alias l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr gc 'git commit -m'
abbr ga 'git add'
abbr gt 'git status'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'

# Quality of life
alias v='nvim'
alias lg='lazygit'

# Functions
function tmux_move_up_and_maximize
    tmux select-pane -U
    tmux resize-pane -Z
end

# Binds
bind \et tmux_move_up_and_maximize
bind \cf tmux-sessionizer.sh

set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
set fzf_fd_opts --hidden --max-depth 5
