#!/usr/bin/env zsh

are_deps_installed() {
  local deps=("nvim" "tmux")
  case $1 in
  "swm")
    deps+=("docker" "ngrok" "dotnet" "jq" "pnpm")
    ;;
  "asn")
    deps+=("pnpm")
    ;;
  "telemetry")
    deps+=("pnpm")
    ;;
  esac

  for dep in $swm_deps; do
    if ! command -v $dep &>/dev/null; then
      echo "$dep could not be found"
      echo "install $dep and try again"
      exit 1
    fi
  done
}

get_project_dir() {
  local project_name=$1
  local project_dir=""
  case $project_name in
  "swm")
    project_dir="$HOME/dev/bn-modern"
    ;;
  "asn")
    project_dir="$HOME/dev/asn/client"
    ;;
  "telemetry")
    project_dir="$HOME/dev/telemetry"
    ;;
  esac
  echo $project_dir
}

usage() {
  echo "usage: run.sh [-e] project_name"
  echo "   -e  open project directory with nvim"
}

is_dir() {
  if [[ -d "$1" ]]; then
    return 0
  else
    return 1
  fi
}

project_name=""
project_dir=""
with_editor=false

if [[ $# -eq 0 || $# -gt 2 ]]; then
  usage
  exit
elif [[ $# -eq 1 ]]; then
  if ! is_dir "$1"; then
    usage
    exit
  fi
  project_name="$1"
elif [[ $# -eq 2 ]]; then
  if [[ "$1" != "-e" ]]; then
    usage
    exit
  elif ! is_dir "$2"; then
    usage
    exit
  fi
  project_name="$2"
  with_editor=true
fi

if [[ ${project_dir: -1} == "/" ]]; then
  project_dir=${project_dir%?}
fi

session=$project_name
session_exists=$(tmux list-sessions | grep $session)
window=${session}:"dev-procs"
docker=${window}.0
api=${window}.1
ngrok=${window}.2
vue=${window}.3


if [[ -z $session_exists ]]; then
  tmux new-session -d -s $session

  # split window for background processes and setup panes
  tmux rename-window -t 0 "dev-procs"
  tmux split-window -vf -t $docker
  tmux split-window -v -t $api
  tmux split-window -v -t $docker

  # check if with_editor is true
  if [[ $with_editor == true ]]; then 
    echo "opening nvim"
    tmux new-window -t $session:1 -n "nvim"
    tmux send-keys -t "nvim" "cd ${project_dir}/srapp" Enter
  fi

  tmux send-keys -t $docker "docker start --attach swm" Enter
  tmux send-keys -t $api "cd ${project_dir}/API" Enter "dotnet run" Enter
  tmux send-keys -t $ngrok 'ngrok http https://localhost:5003 --response-header-add "Access-Control-Allow-Origin: *" --response-header-add "Access-Control-Allow-Headers: *"' Enter
  tmux send-keys -t $vue "cd ${project_dir}/srapp" Enter "pnpm run dev" Enter
  tmux send-keys -t "nvim" "nvim ." Enter
fi

# wait for ngrok to start
sleep 1.0 
local_url=$(curl -s http://localhost:4040/api/tunnels | jq '.tunnels[0].public_url')

# wait for curl to finish
sleep 1.0
local_url=$(echo $local_url | sed 's/"//g')

sed -i '' "s|VITE_API_ROOT=.*|VITE_API_ROOT=${local_url}|" ${project_dir}/srapp/.env


if [[ $with_editor == true ]]; then
 tmux attach-session -t $session:1
else
 tmux attach-session -t $session
fi
