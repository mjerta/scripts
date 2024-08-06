#!/bin/bash

# Check if project name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <project_name>"
  exit 1
fi

PROJECT_NAME=$1

# Initialize the Spring Boot project with Maven
spring init --dependencies=web --build=maven "$PROJECT_NAME"

# Get the full path of the current directory
FULL_PATH=$(pwd)

# Change to the new project directory
cd "$FULL_PATH/$PROJECT_NAME"

# Print the new directory to confirm
echo "Changed directory to $(pwd)"

