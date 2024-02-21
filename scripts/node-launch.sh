#!/usr/bin/env zsh

pnpm=$(pnpm outdated --json)
n=$(echo $pnpm | jq -r 'keys[]')
names=($n)
length=${#names[@]}

if [[ $length == 0 ]]; then
  gum style --foreground 9 --bold "No updates available"
else 
  pnpm outdated
  echo "\n"
  gum style --padding "1 3" --border double --border-foreground 14 --foreground 11 --bold "Apply updates?"

  update=$(gum choose --height 5 --item.foreground 4 --selected.foreground 5 --cursor '› ' "None" "All" "Select")

  if [[ $update == "All" ]]; then
    gum confirm "To latest or package-specified?" --affirmative "Latest" --negative "Specified" \
      --prompt.foreground 11 --prompt.bold --prompt.align 'left' \
      --selected.background 2 --selected.foreground 232 --selected.bold \
      --unselected.background 0 --unselected.foreground 243 
   
    if [[ $? == 0 ]]; then
      pnpm up --latest
      echo "\n"
      gum style --foreground 10 --bold "All packages updated to latest"
    else
      pnpm up
      echo "\n"
      gum style --foreground 10 --bold "All packages updated to specified versions"
    fi
    git add package.json pnpm-lock.yaml && git commit -m "chore: update packages"
  elif [[ $update == "Select" ]]; then
    gum style --foreground 11 --bold "Which packages to update?"
    to_update=$(gum choose --no-limit --height 5 --item.foreground 4 --selected.foreground 5 --cursor '› ' ${names[@]})
    gum confirm "To latest or package-specified?" --affirmative "Latest" --negative "Specified" \
      --prompt.foreground 11 --prompt.bold --prompt.align 'left' \
      --selected.background 2 --selected.foreground 232 --selected.bold \
      --unselected.background 0 --unselected.foreground 243
   
    if [[ $? == 0 ]]; then
      pnpm up --latest "$to_update"
      echo "\n"
      gum style --foreground 10 --bold "Packages: $to_update updated to latest"
    else
      pnpm up "$to_update"
      echo "\n"
      gum style --foreground 10 --bold "Packages: $to_update updated to specified versions"
    fi
    git add package.json pnpm-lock.yaml && git commit -m "chore: update packages"
  else
    gum style --foreground 9 --bold "No updates applied"
  fi
fi
