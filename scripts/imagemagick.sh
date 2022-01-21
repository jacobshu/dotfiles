#!/usr/bin/env zsh

# This script produces optimized images at a square aspect ratio
# by cropping images to their largest dimension and then resizing
# with options as definied in this article: 
# https://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/

WORKING_DIR="/Users/jacobshu/Downloads/bakery"
OUTPUT_PATH="/Users/jacobshu/Downloads/bakery/optimized/"
SIZE=600

cd $WORKING_DIR

for FILE in *; do
  DIM=$(identify -ping -format '%wx%h\n' $FILE)
  W=${DIM%x*}
  H=${DIM#*x}
  if [[ $W -lt $H ]]; then
    # echo $FILE": cropping tall"
    H_CROP=$(( $H - $W ))
    H_OFFSET=$(( $H_CROP / 2 ))
    echo "cropping tall: "$FILE
    mogrify \
      -crop ${W}x${W}+0+${H_OFFSET} \
      -path ${OUTPUT_PATH} \
      -filter Triangle \
      -define filter:support=2 \
      -thumbnail ${SIZE} \
      -unsharp 0.25x0.08+8.3+0.045 \
      -dither None \
      -posterize 136 \
      -quality 82 \
      -define jpeg:fancy-upsampling=off \
      -define png:compression-filter=5 \
      -define png:compression-level=9 \
      -define png:compression-strategy=1 \
      -define png:exclude-chunk=all \
      -interlace none \
      -colorspace sRGB \
      -verbose \
      ${FILE}
  else
    W_CROP=$(( $W - $H ))
    W_OFFSET=$(( $W_CROP / 2 ))
    echo "cropping wide: "$FILE
    mogrify \
      -crop ${H}x${H}+${W_OFFSET}+0 \
      -path ${OUTPUT_PATH} \
      -filter Triangle \
      -define filter:support=2 \
      -thumbnail ${SIZE} \
      -unsharp 0.25x0.08+8.3+0.045 \
      -dither None \
      -posterize 136 \
      -quality 82 \
      -define jpeg:fancy-upsampling=off \
      -define png:compression-filter=5 \
      -define png:compression-level=9 \
      -define png:compression-strategy=1 \
      -define png:exclude-chunk=all \
      -interlace none \
      -colorspace sRGB \
      -verbose \
      ${FILE}
  fi
done

