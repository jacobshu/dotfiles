#!/usr/bin/env zsh

# This script produces optimized images at a square aspect ratio
# by cropping images to their largest dimension and then resizing
# with options as definied in this article: 
# https://www.smashingmagazine.com/2015/06/efficient-image-resizing-with-imagemagick/

resize_square() {
  $input_dir=$1
  $output_dir=$2
  $size=$3
  cd $input_dir
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
        -path ${output_dir} \
        -filter Triangle \
        -define filter:support=2 \
        -thumbnail ${size} \
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
        -path ${output_dir} \
        -filter Triangle \
        -define filter:support=2 \
        -thumbnail ${size} \
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
}

optimize_to_webp() {
  #$input_dir=$1
  #$output_dir=$1
  resize_percent=$1 
  cd "/Users/jacobshu/Desktop/highlights" #$input_dir
  for file in *; do
    mogrify \
      -resize "${resize_percent}%" \
      -path "/Users/jacobshu/Desktop/optimized" \
      -filter Triangle \
      -define filter:support=2 \
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
      -format webp \
      -verbose \
      ${file}
  done
}

if declare -f "$1" > /dev/null
then
  # call arguments verbatim
  "$@"
else
  # Show a helpful error
  echo "'$1' is not a known function name" >&2
  exit 1
fi
