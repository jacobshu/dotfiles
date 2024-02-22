#!/usr/bin/env zsh

# This script is used to generate favicon files

# Usage: favicon.sh <svg file>
# Example: favicon.sh ./favicon.svg
# Output: ./favicon.ico, ./icon-512.png, ./icon-192.png, ./apple-touch-icon.png, ./manifest.webmanifest
# Note: The input file should be a square SVG file

echo "Generating favicon files..."
echo "Input file: $1"

/Applications/Inkscape.app/Contents/MacOS/inkscape $1 --export-width=32 --export-filename="./tmp.png"
convert ./tmp.png ./favicon.ico
rm ./tmp.png

/Applications/Inkscape.app/Contents/MacOS/inkscape --export-type="png" --export-width=512 --export-filename="./icon-512.png" $1
/Applications/Inkscape.app/Contents/MacOS/inkscape --export-type="png" --export-width=192 --export-filename="./icon-192.png" $1
/Applications/Inkscape.app/Contents/MacOS/inkscape --export-type="png" --export-width=140 --export-filename="./icon-140.png" $1

# convert for apple-touch-icon.png
convert               \
      icon-140.png       \
     -background none \
     -gravity center  \
     -extent 180x180  \
      apple-touch-icon.png
rm ./icon-140.png

# optimize SVG file
svgo --multipass $1

# create a webmanifest file
touch manifest.webmanifest
cat <<EOF > manifest.webmanifest
{
  "icons": [
    { "src": "/icon-192.png", "type": "image/png", "sizes": "192x192" },
    { "src": "/icon-512.png", "type": "image/png", "sizes": "512x512" }
  ]
}
EOF

# copy HTML links to clipboard
pbcopy <<EOF
  <link rel="icon" href="/favicon.ico" sizes="32x32">
  <link rel="icon" href="/icon.svg" type="image/svg+xml">
  <link rel="apple-touch-icon" href="/apple-touch-icon.png"><!-- 180×180 -->
  <link rel="manifest" href="/manifest.webmanifest">
EOF



