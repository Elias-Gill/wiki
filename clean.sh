#!/bin/bash

# Define the directory to search
DIR="."

# List all files except index.md and clean.sh
FILES=$(ls $DIR | grep -v -E "index.md|clean.sh|push.sh")

# Create a list to store files to delete
TO_DELETE=()

# Check each file
for FILE in $FILES; do
    # Check if the file is mentioned in any other file
    if ! grep -qR "$FILE" $DIR/*; then
        TO_DELETE+=("$FILE")
    fi
done

# Delete the files not mentioned
for FILE in "${TO_DELETE[@]}"; do
    echo "Deleting $FILE"
    trash "$DIR/$FILE"
done

echo "Cleanup complete."
