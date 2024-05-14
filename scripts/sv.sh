#!/usr/bin/env zsh

SAVES_DIR=$HOME/.config/StardewValley/Saves

saves=( $(find $SAVES_DIR -mindepth 1 -type d) )

# echo $(basename -- "${saves[@]}")
save=$( basename -- "${saves[@]}" | cut -d "_" -f1 | gum choose --limit 1 --header "Which farm?")

pattern=$save

echo "array length: " ${#saves[@]}
echo "Save is: "$save "\n"
echo ${saves[@]#${save}}

