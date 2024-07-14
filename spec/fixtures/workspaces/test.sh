#!/bin/bash

# Loop through all directories in the current directory
for dir in */ ; do
    # Check if the directory contains a file without an extension
    file=$(find "$dir" -maxdepth 1 -type f ! -name "*.*" -print -quit)
    
    # If such a file exists, run shellcheck on it
    if [ -n "$file" ]; then
        echo "Running shellcheck on $file"
        shellcheck "$file"
    fi
done
