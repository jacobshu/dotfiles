#!/usr/bin/env zsh

# check if docker is installed
if ! command -v docker &> /dev/null
then
  echo "docker could not be found"
  echo "download and install docker from https://docs.docker.com/engine/install/"
  exit
fi

# check if ngrok is installed
if ! command -v ngrok &> /dev/null
then
  echo "ngrok could not be found"
  echo "download and install ngrok from https://ngrok.com/download"
  exit
fi

# check if dotnet is installed
if ! command -v dotnet &> /dev/null
then
  echo "dotnet could not be found"
  echo "download and install dotnet from https://dotnet.microsoft.com/download"
  exit
fi


session="swm"
session_exists=$(tmux list-sessions | grep $session)
window=${session}:"dev-procs"
docker=${window}.0
api=${window}.1
ngrok=${window}.2
vue=${window}.3
project_dir=""


if [[ -z $session_exists ]]; then
  # start session with name and detach
  tmux new-session -d -s $session

  # name window and start zsh
  tmux rename-window -t 0 "dev-procs"
  tmux split-window -vf -t $docker
  tmux split-window -v -t $api
  tmux split-window -v -t $docker

  # create new window for background processes and setup panes
  tmux new-window -t $session:1 -n "nvim"

  if [[ $1 == "-e" ]]; then
    tmux rename-window -t 0 "nvim"
    tmux send-keys -t "nvim" "cd ${project_dir}/shiprec && nvim ." Enter
    tmux attach-session -t $session:0
    exit
  fi


  tmux send-keys -t "nvim" "cd ${project_dir}/shiprec && nvim ." Enter
  tmux send-keys -t $docker "docker start --attach swm" Enter
  tmux send-keys -t $api "cd ${project_dir}/API" Enter "dotnet run" Enter
  tmux send-keys -t $ngrok 'ngrok http https://localhost:5003 --response-header-add "Access-Control-Allow-Origin: *" --response-header-add "Access-Control-Allow-Headers: *"' Enter
  tmux send-keys -t $vue "cd ${project_dir}/shiprec" Enter "pnpm run dev" Enter
fi

# Attach Session, on the Main window
tmux attach-session -t $session:0
