#!/usr/bin/env zsh

SAVES_DIR=$HOME/.config/StardewValley/Saves/

saves=$(find $SAVES_DIR -type d)

for file in $saves;
do
  basename -- $file | cut -d "_" -f1
done

