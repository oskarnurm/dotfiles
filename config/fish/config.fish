# Aliases
if type -q eza
  alias ll "eza -l -g --icons"
  alias lla "ll -a"
end

alias neoconf "cd ~/.config/nvim"
alias v "nvim"
alias lq "lazygit"

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Ctrl+f to launch tmux-sessionizer
    bind \cf  ~/.local/scripts/tmux-sessionizer.sh

    # Launch starship
    starship init fish | source

    # Fzf prettier preview
    set -gx FZF_DEFAULT_OPTS '--preview "bat --color=always --style=numbers --line-range=:500 {}"'

# Disable fish greeting
    function fish_greeting
        # Do nothing
    end

end
set -gx PATH ~/.local/scripts/ $PATH
