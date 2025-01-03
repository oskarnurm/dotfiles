set -g fish_greeting

if status is-interactive
    starship init fish | source
end

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

function tmux_move_up_and_maximize
    # Move to the upper pane
    tmux select-pane -U
    tmux resize-pane -Z
end

set -Ux EDITOR nvim
set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
set fzf_fd_opts --hidden --max-depth 5
fzf_configure_bindings --directory=\cf

# Bind Alt-t to the tmux_move_up_and_maximize function
bind \et tmux_move_up_and_maximize

# Make custom scripts accessible stystem-wide
# export PATH="$HOME/dotfiles/scripts:$PATH"
set -gx PATH $HOME/dotfiles/scripts $PATH

# For Apple Silicon Macs the homebrew path needs to set for it to work in other shells like fish
set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
