#!/usr/bin/env zsh

session="swm"
session_exists=$(tmux list-sessions | grep $session)

if [[ -z $session_exists ]]; then
  # start session with name and detach
  tmux new-session -d -s $session

  # name window and start zsh
  tmux rename-window -t 0 "nvim"
  tmux send-keys -t "nvim" "cd /Users/jacobshu/dev/bn-modern/shiprec && nvim ." Enter

  window="dev-procs"
  # create new window for background processes and setup pane for docker
  tmux new-window -t $session:1 -n "dev-procs"
  tmux send-keys -t $window "echo 'spin up docker...'" Enter

  # setup .net API pane
  tmux split-window -hf -t $session:1.0
  tmux send-keys -t $window "cd /Users/jacobshu/dev/bn-modern/API && echo 'Run the API'" Enter


  # setup ngrok pane
  tmux split-window -v -t $session:1.1
  tmux send-keys -t $window "echo ngrokn" Enter

  # setup Vue pane
  tmux split-window -v -t $session:1.0
  tmux send-keys -t $window "echo 'take in the vue'" Enter

  fi

# Attach Session, on the Main window
tmux attach-session -t $session:0
