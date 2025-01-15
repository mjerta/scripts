#!/bin/bash

# Prompt the user for the project name
read -p "Enter the project name: " PROJECT_NAME

# Generate the Maven project
mvn archetype:generate \
    -DgroupId=nl.mpdev \
    -DartifactId=${PROJECT_NAME} \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DinteractiveMode=false

# Inform the user the project has been created
echo "Project ${PROJECT_NAME} has been generated successfully."
