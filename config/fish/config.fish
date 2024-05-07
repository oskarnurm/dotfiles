# Aliases
if type -q eza
  alias ll "eza -l -g --icons"
  alias lla "ll -a"
end

alias neoconf "cd ~/.config/nvim"
alias v "nvim"
alias lq "lazygit"

# Ctrl+f to launch tmux-sessionizer
bind \cf  ~/.local/scripts/tmux-sessionizer.sh

# Launch starship
starship init fish | source

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

# Disable fish greeting
function fish_greeting
    # Do nothing
end

set -gx PATH ~/.local/scripts/ $PATH
