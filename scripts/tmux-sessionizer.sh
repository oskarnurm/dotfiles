#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
selected=$(
  find ~/dotfiles/config ~/dotfiles ~/programming \
    -mindepth 1 -maxdepth 4 \
    \( -path '*/node_modules' -prune \) -o -print \
  | fzf --preview '
    if [ -d {} ]; then
      eza --tree --color=always {}
    elif [ -f {} ]; then
      bat --style=numbers --color=always --line-range :500 {}
    fi
  '
)
fi

if [[ -z $selected ]]; then
    exit 0
fi

if [ -f "$selected" ]; then
    # If the selected item is a file, open it in neovim
    nvim "$selected"
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    # No tmux session running, start a new session with a new window
    tmux new-session -s $selected_name -n $selected_name -c $selected
    exit 0
fi

# Check if already inside a tmux session or not
if [[ -n $TMUX ]]; then
    # Create a new window in the existing session
    if ! tmux list-windows | grep -q $selected_name; then
        tmux new-window -n $selected_name -c $selected
    fi
else
    # Not inside a tmux session, attach to existing or create a new one
    if ! tmux has-session -t $selected_name 2> /dev/null; then
        tmux new-session -ds $selected_name
        tmux new-window -t $selected_name -n $selected_name -c $selected
    else
        if ! tmux list-windows -t $selected_name | grep -q $selected_name; then
            tmux new-window -t $selected_name -n $selected_name -c $selected
        fi
    fi
    tmux attach-session -t $selected_name
fi

# Switch to the window with the selected name
tmux select-window -t $selected_name
