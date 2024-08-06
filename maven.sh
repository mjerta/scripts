#!/bin/bash

# Base directory where the archetypes are stored
baseDir="/home/mjerta/.m2/repository/nl/mpdev"

# Function to list local archetypes
list_archetypes() {
  local archetypes=($(ls -d "$baseDir"/*/))
  echo "Available archetypes:"
  local index=1
  for archetype in "${archetypes[@]}"; do
    local archetypeArtifactId=$(basename "$archetype")
    echo "$index) $archetypeArtifactId"
    index=$((index + 1))
  done
}

# Function to prompt for a valid archetype choice
prompt_archetype_choice() {
  local choice
  read -p "Enter the number of the archetype you want to use: " choice
  echo $choice
}

# List available archetypes
list_archetypes

# Prompt for archetype choice
choice=$(prompt_archetype_choice)

# Validate the choice
archetypes=($(ls -d "$baseDir"/*/))  # Re-list archetypes to ensure correct indexing
if [ "$choice" -le "${#archetypes[@]}" ] && [ "$choice" -gt 0 ]; then
  selected_archetype=${archetypes[$((choice - 1))]}
else
  echo "Invalid choice. Exiting."
  exit 1
fi

# Extract archetype details
archetypeArtifactId=$(basename "$selected_archetype")
archetypeGroupId="nl.mpdev"
archetypeVersion=$(ls "$selected_archetype" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+(-SNAPSHOT)?$' | head -n 1)

# Set default values for other parameters
groupId="nl.mpdev"
version="1.0-SNAPSHOT"

# Prompt for the project name
read -p "Enter the project name: " projectName

# Form the Maven command
mvnCommand="mvn archetype:generate \
    -DarchetypeGroupId=${archetypeGroupId} \
    -DarchetypeArtifactId=${archetypeArtifactId} \
    -DarchetypeVersion=${archetypeVersion} \
    -DgroupId=${groupId} \
    -DartifactId=${projectName} \
    -Dversion=${version} \
    -DinteractiveMode=false"

# Run the Maven archetype:generate command
echo "Running Maven command:"
echo $mvnCommand
if eval $mvnCommand; then
  # Construct the full path to the project directory
  fullPath="$(pwd)/$projectName"

  # Check if the project directory exists and navigate into it
  if [ -d "$fullPath" ]; then
    echo "Changing directory to: $fullPath"
    cd "$fullPath" || { echo "Failed to change directory to $fullPath"; exit 1; }

    # Echo the full command
    echo "Executed command:"
    echo $mvnCommand

    # Print a message indicating that the project has been generated
    echo "Project ${projectName} has been generated successfully. You are now in the project directory."
  else
    echo "Project directory $fullPath does not exist. Exiting."
    exit 1
  fi
else
  echo "Failed to generate the project. Exiting."
  exit 1
fi

