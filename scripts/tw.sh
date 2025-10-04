#!/bin/bash

DIRS=(
  "$HOME"
  "$HOME/dotfiles"
  "$HOME/kth"
  "$HOME/projects"
  "$HOME/odin/"
)

selected=$(fd . "${DIRS[@]}" --type=dir --max-depth=1 |
  sed "s|^$HOME/||" | fzf --margin 30%)

[[ ! $selected ]] && exit 0

selected="$HOME/$selected"
selected_name=$(basename "$selected" | tr . _)

if [[ -z "$TMUX" ]]; then 
  if tmux has-session 2>/dev/null; then
    tmux new-window -d -n "$selected_name" -c "$selected"
    tmux attach-session
  else
    tmux new-session -s main -n "$selected_name" -c "$selected"
  fi
else
  tmux new-window -n "$selected_name" -c "$selected"
fi
