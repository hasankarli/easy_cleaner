#!/bin/bash

# Define the source file
source_file="default_translation.json"

# Define the target directory
target_dir="./example/assets/translations"

# Copy the content of source_file to each target file
for target_file in "$target_dir"/*.json; 
do
    cp "$source_file" "$target_file"
    echo "Copied $source_file to $target_file"
done
