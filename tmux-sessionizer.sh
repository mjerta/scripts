#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  selected=$1
else
  # selected=$(find ~/develop/projects -mindepth 1 -maxdepth 1 -type d | fzf --reverse
  # Prepend numbers to the directory list for faster selection
  selected=$(find -L ~/develop/projects ~/.config ~/my-setup-scripts -mindepth 1 -maxdepth 1 -type d |
    awk '{print NR ": " $0}' | fzf --reverse --bind 'enter:accept' |
    cut -d: -f2-)
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
#     tmux new-session -s $selected_name -c $selected
#     exit 0
# fi
if [[ -z $TMUX ]]; then
  if [[ -z $tmux_running ]]; then
    # Start a new tmux session if tmux is not running
    tmux new-session -s $selected_name -c $selected
  else
    # Attach to the existing session if tmux is running
    tmux attach-session -t $selected_name || tmux new-session -s $selected_name -c $selected
  fi
  exit 0
fi

if ! tmux has-session -t=$selected_name 2>/dev/null; then
  tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
