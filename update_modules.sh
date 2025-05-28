#!/bin/bash

# Store the original directory
ORIGINAL_DIR=$(pwd)

# Check if the fluent directory exists
if [ ! -d "./include/fluent" ]; then
    echo "Error: Directory ./include/fluent does not exist"
    exit 1
fi

# Find all directories in ./include/fluent and iterate through them
for dir in ./include/fluent/*/ ; do
    # Check if the directory exists (in case no directories are found)
    if [ -d "$dir" ]; then
        echo "Processing $dir..."
        # Change to the subdirectory
        cd "$dir" || { echo "Failed to cd into $dir"; exit 1; }
        # Execute git commands
        git fetch && git pull origin master
        if [ $? -ne 0 ]; then
            echo "Git operations failed in $dir"
            # Return to original directory before exiting
            cd "$ORIGINAL_DIR" || exit 1
            exit 1
        fi
        # Return to original directory
        cd "$ORIGINAL_DIR" || exit 1
    fi
done

# After processing all subdirectories, perform final git commands
echo "Committing changes in main repository..."
git add . && git commit -m "Sync submodules"
if [ $? -ne 0 ]; then
    echo "Final git commit failed"
    exit 1
fi

git push origin master
echo "All operations completed successfully"