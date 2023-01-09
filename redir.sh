#!/bin/bash
# v 1.0.0
# move up 1 level
cd ../
# ask for old directory name
read -p "Enter old directory name: " old
# ask for new directory name
read -p "Enter new directory name: " new
# if old directory exists
if [ -d "$old" ]; then
  # if new directory does not exist
  if [ ! -d "$new" ]; then
    # rename old directory to new directory
    mv "$old" "$new"
  else
    echo "Error: $new already exists."
  fi
else
  echo "Error: $old does not exist."
fi
