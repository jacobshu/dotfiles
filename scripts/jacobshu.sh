#!/usr/bin/env zsh

source $(dirname "$0")/node-launch.sh

project_name="jacobshu"
project_dir=$HOME/dev/jacobshudev

# tmux format is session:window.pane
session=$project_name
session_exists=$(tmux list-sessions | grep $session)

editor=${session}:"nvim"
astro=${session}:"astro"
vitest=${session}:"test"


if [[ -z $session_exists ]]; then
  echo "Creating tmux session: $session"

  tmux new-session -d -s $session -n "nvim" -c $project_dir
  tmux new-window -n "astro" -c $project_dir
  tmux new-window -n "test" -c $project_dir

  tmux send-keys -t $astro "pnpm run dev" Enter
  tmux send-keys -t $vitest "pnpm run test" Enter
  tmux send-keys -t $editor "nvim ." Enter

  tmux select-window -t $editor
fi

tmux attach-session -t $session
