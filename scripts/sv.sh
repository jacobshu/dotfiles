#!/usr/bin/env zsh

SAVES_DIR=$HOME/.config/StardewValley/Saves

saves=( $(find $SAVES_DIR -mindepth 1 -type d) )
names=( $( basename -- "${saves[@]}" | cut -d "_" -f1 ) )

typeset -A matches

for ((i = 1; i <= $#saves; i++)); do
  echo "setting matches[" $names[i] "] to " $saves[i]
  matches[$names[i]]=$saves[i]
done

# echo $(basename -- "${saves[@]}")
save=$( basename -- "${saves[@]}" | cut -d "_" -f1 | gum choose --limit 1 --header "Which farm?")


echo "array length: " ${#saves[@]}
echo "Save is: "$save "\n"

for key val in "${(@kv)matches}"; do
    echo "$key:$val"
done

echo "Filepath is: " matches[$save]


# xmllint --xpath "number(SaveGame/player/experiencePoints/int[1])" $save_file
# xmllint --xpath "number(SaveGame/player/experiencePoints/int[2])" $save_file
# xmllint --xpath "number(SaveGame/player/experiencePoints/int[3])" $save_file
# xmllint --xpath "number(SaveGame/player/experiencePoints/int[4])" $save_file
# xmllint --xpath "number(SaveGame/player/experiencePoints/int[5])" $save_file
