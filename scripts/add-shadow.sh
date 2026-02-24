#!/bin/bash

# Check if a file was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <path-to-image.png>"
  exit 1
fi

INPUT_FILE="$1"
FILENAME=$(basename -- "$INPUT_FILE")
EXTENSION="${FILENAME##*.}"
FILENAME_NO_EXT="${FILENAME%.*}"
OUTPUT_FILE="${FILENAME_NO_EXT}-shadow.${EXTENSION}"

# --- CUSTOMIZE SHADOW HERE ---
# The values in parentheses control the shadow:
# ( +clone -background black -shadow 60x20+0+15 )
#
# 60 = Opacity (0-100, lower is more transparent)
# x20 = Blur radius (lower is sharper, higher is fluffier)
# +0  = Horizontal offset (positive moves right)
# +15 = Vertical offset (positive moves down)

magick "$INPUT_FILE" \
  \( +clone -background black -shadow 50x15+0+10 \) \
  +swap -background transparent -layers merge +repage \
  "$OUTPUT_FILE"

echo "Created: $OUTPUT_FILE"
