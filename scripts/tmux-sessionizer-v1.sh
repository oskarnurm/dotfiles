#!/usr/bin/env bash

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find ~/dotfiles/nvim/.config ~/dotfiles ~/projects ~/kth -mindepth 1 -maxdepth 1 -type d | fzf --preview "$show_file_or_dir_preview")
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s $selected_name -c $selected
  exit 0
fi

if ! tmux has-session -t=$selected_name 2>/dev/null; then
  tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
