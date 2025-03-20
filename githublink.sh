#!/bin/bash

# Get the repository URL in JSON format
repo_info=$(gh repo view --json url)

# Extract the URL using jq (install jq if you don't have it)
repo_url=$(echo "$repo_info" | jq -r '.url')

# Get the current branch name
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Combine the URL with the current branch name
full_url="${repo_url}/tree/${current_branch}"

# Output the final URL
echo "$full_url"

<<<<<<< HEAD
=======
xdg-open "$full_url"

>>>>>>> 866398d (Add some adjustments)
