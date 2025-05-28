#!/bin/bash

# Check if at least one argument is provided (argc >= 2, since argv[0] is script name)
if [ $# -lt 1 ]; then
    echo "Error: Please provide at least one repository name as an argument"
    echo "Usage: $0 <repo_name>"
    exit 1
fi

# Store the first argument
REPO_NAME="$1"

# Execute git submodule commands
git submodule add "https://github.com/rodrigoo-r/${REPO_NAME}.git" "include/fluent/${REPO_NAME}" &&
git submodule update --init --recursive &&
git add .gitmodules include/fluent &&
git commit -m "Add submodule" &&
git push origin master

# Check if commands were successful
if [ $? -eq 0 ]; then
    echo "Submodule ${REPO_NAME} added and pushed successfully"
else
    echo "Error: Failed to add submodule ${REPO_NAME}"
    exit 1
fi