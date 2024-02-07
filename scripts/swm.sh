#!/usr/bin/env zsh

deps=("tmux" "jq" "pnpm" "dotnet" "docker" "nvim")
project_name="swm"
project_dir=$HOME/dev/bn-modern

check_dep () {
  if ! command -v $1 &>/dev/null; then
    echo "$! could not be found"
    echo "install $! and try again"
    exit 1
  fi
}

for dep in ${deps[@]}; do
  echo "Checking for $dep"
  check_dep $dep
done

# tmux format is session:window.pane
session=$project_name
session_exists=$(tmux list-sessions | grep $session)

editor=${session}:"nvim"
docker=${session}:"docker"
api=${session}:"api"
api_dir=${project_dir}/API
ngrok=${session}:"ngrok"

vue=${session}:"vue"
vue_dir=${project_dir}/srapp
vue_dev=${vue}.0
vue_test=${vue}.1


if [[ -z $session_exists ]]; then
  echo "Creating tmux session: $session"

  tmux new-session -d -s $session -n "nvim" -c $vue_dir
  tmux new-window -n "vue" -c $vue_dir
  tmux new-window -n "ngrok"
  tmux new-window -n "api" -c $api_dir
  tmux new-window -n "docker"
  tmux split-window -v -t $vue -c $vue_dir

  tmux send-keys -t $docker "docker start --attach swm" Enter
  tmux send-keys -t $api "dotnet run" Enter
  tmux send-keys -t $ngrok 'ngrok http https://localhost:5003 --response-header-add "Access-Control-Allow-Origin: *" --response-header-add "Access-Control-Allow-Headers: *"' Enter
  tmux send-keys -t $vue_dev "pnpm run dev" Enter
  tmux send-keys -t $vue_test "pnpm run test" Enter
  tmux send-keys -t $editor "nvim ." Enter

  tmux select-window -t $editor
fi

# wait for ngrok to start
sleep 1.0 
local_url=$(curl -s http://localhost:4040/api/tunnels | jq '.tunnels[0].public_url')

# wait for curl to finish
sleep 1.0
local_url=$(echo $local_url | sed 's/"//g')

sed -i '' "s|VITE_API_ROOT=.*|VITE_API_ROOT=${local_url}|" ${project_dir}/srapp/.env

tmux attach-session -t $session
