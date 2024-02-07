#!/usr/bin/env zsh

pnpm=$(pnpm outdated --json)
n=$(echo $pnpm | jq -r 'keys[]')
names=($n)

if [[ $pnpm == "{}" ]]; then
  gum style --foreground 9 --bold "No updates available"
else 
  pnpm outdated
  echo "\n"
  gum style --padding "1 3" --border double --border-foreground 14 --foreground 11 --bold "Apply updates?"

  update=$(gum choose --height 5 --item.foreground 4 --selected.foreground 5 --cursor '› ' "None" "All (to latest)" "Select")

  if [[ $update == "All (to latest)" ]]; then
    pnpm update
    git add package.json pnpm-lock.yaml && git commit -m "chore: update packages"
  elif [[ $update == "Select" ]]; then
    gum style --foreground 11 --bold "Which packages to update?"
    to_update=$(gum choose --no-limit --height 5 --item.foreground 4 --selected.foreground 5 --cursor '› ' ${names[@]})
    to_latest=$(gum confirm "Update to latest?" --affirmative "Do it" --negative "Abort!" \
      --prompt.foreground 11 --prompt.bold --prompt.align 'left' \
      --selected.background 2 --selected.foreground 232 --selected.bold \
      --unselected.background 0 --unselected.foreground 243)
          echo "\n"
          pnpm up "$to_update"
          git add package.json pnpm-lock.yaml && git commit -m "chore: update packages"
        else
          gum style --foreground 9 --bold "No updates applied"
  fi
fi
