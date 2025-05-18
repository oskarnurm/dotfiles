#!/usr/bin/env bash
# Open the current repository in the browser
# NOTE: Just use 'gh' if you have it installed

# Goto the root of the repo for the script to work
dir=$(tmux run "echo #{pane_start_path}")
cd $dir
url=$(git remote get-url origin)

# Check if the repository is on GitHub
if [[ $url =~ ^git@github\.com:(.+)\.git$ ]]; then
  url="https://github.com/${BASH_REMATCH[1]}"
elif [[ $url =~ ^https://github\.com/.+\.git$ ]]; then
  url="${url%.git}"
else
  echo "Not a Github repo"
  exit 1
fi

if command -v open &>/dev/null; then
  open "$url"
else
  echo "Could not open with 'open'"
fi
