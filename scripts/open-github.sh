#!/usr/bin/env bash
# Open the current repository in the browser

# Goto the root of the repo for the script to work
dir=$(tmux run "echo #{pane_start_path}")
cd $dir
url=$(git remote get-url origin)

# Check if the repository is on GitHub
if [[ $url =~ ^git@github\.com:(.+)\.git$ ]]; then
  url="https://github.com/${BASH_REMATCH[1]}"
  open $url
elif [[ $url =~ ^https://github\.com/.+\.git$ ]]; then
  url="${url%.git}"
  open $url
else
  echo "This repository is not hosted on GitHub"
fi
