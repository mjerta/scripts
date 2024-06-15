#!/bin/bash

# Fetch the repository names using GitHub CLI and store the output in a variable
repos_json=$(gh repo list --json name)

# Parse the JSON data to extract the repository names into an array using jq
mapfile -t repos < <(echo "$repos_json" | jq -r '.[].name')

# Function to display the menu and get the user's choice
function select_repo() {
    PS3="Enter the number corresponding to the repository: "
    select repo in "${repos[@]}"; do
        if [[ -n $repo ]]; then
            echo "$repo"
            return
        else
            echo "Invalid selection. Please try again."
        fi
    done
}

# Get the selected repository name
selected_repo=$(select_repo)

# Clone the selected repository
if [[ -n $selected_repo ]]; then
  echo "You have selected: $selected_repo"
    # Assuming you want to clone it into the current directory
    gh repo clone "$selected_repo"
else
    echo "No repository selected."
fi
