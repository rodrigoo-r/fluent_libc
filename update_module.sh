#!/bin/bash

# Check if at least one argument is provided (argc >= 2, since argv[0] is script name)
if [ $# -lt 1 ]; then
    echo "Error: Please provide at least one repository name as an argument"
    echo "Usage: $0 <repo_name>"
    exit 1
fi

# Store the first argument
REPO_NAME="$1"

# Go to the directory specified
cd "include/fluent/$REPO_NAME" || { echo "Error: Directory include/fluent/$REPO_NAME does not exist"; exit 1; }

# Execute git commands
git fetch && git pull origin master

# Go back to the original directory
cd ../../../

# Perform final git commands
echo "Committing changes in main repository..."
git add . && git commit -m "Sync submodule ${REPO_NAME}"
git push origin master