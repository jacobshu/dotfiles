#!/usr/bin/env zsh

session="swm"
session_exists=$(tmux list-sessions | grep $session)
window=${session}:"dev-procs"
docker=${window}.0
api=${window}.1
ngrok=${window}.2
vue=${window}.3
project_dir="/Users/jacobshu/dev/bn-modern"

if [[ -z $session_exists ]]; then
  # start session with name and detach
  tmux new-session -d -s $session

  # name window and start zsh
  tmux rename-window -t 0 "nvim"

  # create new window for background processes and setup panes
  tmux new-window -t $session:1 -n "dev-procs"
  tmux split-window -hf -t $docker
  tmux split-window -v -t $api
  tmux split-window -v -t $docker

  tmux send-keys -t "nvim" "cd $project_dir/shiprec && nvim ." Enter
  tmux send-keys -t $docker "docker run swmdb" Enter
  tmux send-keys -t $api "cd $project_dir/API" Enter "dotnet run"
  tmux send-keys -t $ngrok "ngrok http localhost:5003" Enter
  tmux send-keys -t $vue "cd $projcect_dir/shiprec" Enter "pnpm run dev" Enter
fi

# Attach Session, on the Main window
tmux attach-session -t $session:0
