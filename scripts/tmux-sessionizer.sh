#!/usr/bin/env bash

settings="if [ -d \$HOME/{} ]; then \
             eza --tree --color=always \$HOME/{} | head -200; \
           else \
             bat -n --color=always --line-range :500 \$HOME/{}; \
           fi"

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find ~/odin ~/dotfiles/scripts ~/dotfiles ~/projects ~/kth \
    -mindepth 1 -maxdepth 1 -type d |
    sed "s|$HOME/||" |
    fzf --preview "$settings")
fi

[[ -z $selected ]] && exit 0

selected="$HOME/$selected"
selected_name=$(basename "$selected" | tr . _)
session="dev"

# start master session if needed
if ! tmux has-session -t "$session" 2>/dev/null; then
  tmux new-session -ds "$session" -c "$selected"
fi

# Try to select the window.  If it doesn't exist, create it, then select it.
if tmux select-window -t "$session:$selected_name" 2>/dev/null; then
  # window already existed and is now selected
  :
else
  tmux new-window -t "$session" -n "$selected_name" -c "$selected"
  tmux select-window -t "$session:$selected_name"
fi

# If not already inside tmux, attach to the session.
if [[ -z "$TMUX" ]]; then
  tmux attach-session -t "$session"
fi
