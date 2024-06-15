#!/bin/bash

# Check if the current directory is a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "No Git repository detected in the current directory. Exiting script."
  exit 1
fi

echo "Git repository detected."

# Get the current directory name as the default repository name
default_repo_name=$(basename "$(pwd)")

# Check if there is an existing remote
existing_remote=$(git remote)

if [ -n "$existing_remote" ]; then
  echo "Existing remote '$existing_remote' found. Do you want to remove it? (yes/no)"
  read remove_existing_remote

  if [[ "$remove_existing_remote" == "yes" || "$remove_existing_remote" == "y" ]]; then
    git remote remove "$existing_remote"
    echo "Remote '$existing_remote' removed."
  fi
else
  echo "No existing remote found."
fi

# Prompt the user to choose the default repo name or enter their own
echo "Do you want to use the default repository name '$default_repo_name'? (yes/no)"
read use_default

if [[ "$use_default" == "yes" || "$use_default" == "y" ]]; then
  repo_name="$default_repo_name"
else
  echo "Please enter your repository name:"
  read repo_name
fi

# Prompt the user for the repository description
echo "Please enter the repository description:"
read repo_description

# Create the repository using gh CLI
gh repo create "$repo_name" --public -d "$repo_description"

echo "Repository '$repo_name' created successfully with description '$repo_description'."

# Prompt the user to add the remote
echo "Do you want to add this remote to the folder? (yes/no)"
read add_remote

if [[ "$add_remote" == "yes" || "$add_remote" == "y" ]]; then
  echo "Do you want to use the default remote name 'origin'? (yes/no)"
  read use_default_remote
  if [[ "$use_default_remote" == "yes" || "$use_default_remote" == "y" ]]; then
    remote_name="origin"
  else
    echo "Please enter your desired remote name:"
    read remote_name
  fi
  git remote add "$remote_name" "git@github.com:/mjerta/$repo_name.git"
  echo "Remote '$remote_name' added to the folder."
else
  echo "Remote not added to the folder."
fi
