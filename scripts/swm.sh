#!/usr/bin/env zsh

# Set Session Name
session="swm"
session_exists=$(tmux list-sessions | grep $session)

if [[ -z $session_exists ]]; then
  
  # Start New Session with our name
  tmux new-session -d -s $session

  # Name first Pane and start zsh
  tmux rename-window -t 0 "docker"
  tmux send-keys -t "docker" "zsh" C-m "clear" C-m # Switch to bind script?

  # Create and setup pane for api server
  tmux new-window -t $session:1 -n "api"
  tmux send-keys -t "api" "cd /Users/jacobshu/dev/bn-modern/API" C-m # Switch to bind script?

  # setup ngrok window
  tmux new-window -t $session:2 -n "ngrok"
  tmux send-keys -t "ngrok" "nvim" C-m

  # Setup an Vue dev process
  tmux new-window -t $session:3 -n "vue"
  tmux send-keys -t "vue" "zsh" C-m "clear" C-m

  # Setup an editor
  tmux new-window -t $session:3 -n "shiprec"
  tmux send-keys -t "shiprec" "zsh" C-m "clear" C-m

fi

# Attach Session, on the Main window
tmux attach-session -t $session:0
