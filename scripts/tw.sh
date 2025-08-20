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
  if ! tmux has-session -t "$selected_name" 2>/dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
  fi
  tmux attach-session -t "$selected_name"
else
  if tmux list-windows -F "#{window_name}" | grep -q "^$selected_name$"; then
    tmux select-window -t "$selected_name"
  else
    tmux new-window -n "$selected_name" -c "$selected"
  fi
fi
