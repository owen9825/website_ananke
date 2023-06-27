#!/bin/bash

# Directory containing the input image files
input_directory="${1%/}"

# Loop through each image file in the input directory
for input_file in "$input_directory"/*.png "$input_directory"/*.jpg "$input_directory"/*.jpeg "$input_directory"/*.gif; do
  # Get the base filename without extension
  filename=$(basename "$input_file")
  filename_without_extension="${filename%.*}"
  extension="${filename##*.}"

  # Construct the output file path with .webp extension
  output_file="$input_directory/$filename_without_extension.webp"

  # https://developers.google.com/speed/webp/docs/cwebp?hl=en
  if [[ "$extension" == "gif" ]]; then
    gif2webp "$input_file" -o "$output_file"
  else
    cwebp "$input_file" -o "$output_file"
  fi

  # Print the conversion details
  echo "Converted: $input_file -> $output_file"
done
