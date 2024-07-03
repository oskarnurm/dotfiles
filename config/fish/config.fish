# Remove the fish greeting
set -g fish_greeting

if status is-interactive
    starship init fish | source
end

# Better list dirs
alias ll "eza -l -g --icons"
alias lla "ll -a"

alias v "nvim"
alias lg "lazygit"

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'

# Makes the parent dir if missing ex. mkdir -p config/fish (if config did not exist)
abbr mkdir 'mkdir -p'

# Ctrl+f to launch tmux-sessionizer
bind \cf  ~/dotfiles/scripts/tmux-sessionizer.sh

# Fzf prettier preview
set -gx FZF_DEFAULT_OPTS '--preview "bat -n --color=always --style=numbers --line-range=:500 {}"'
set -x FZF_CTRL_T_OPTS "FZF_DEFAULT_OPTS"
set -x FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"

function _fzf_comprun
    set command $argv[1]
    set -e argv[1] # equivalent to shift

    switch $command
        case cd
            fzf --preview 'eza --tree --color=always {} | head -200' $argv
        case export unset
            # This needs specific handling in Fish
            fzf --preview "eval 'echo $$argv'" $argv
        case ssh
            fzf --preview 'dig {}' $argv
        case '*'
            fzf --preview "bat -n --color=always --line-range :500 {}" $argv
    end
end
