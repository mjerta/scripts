#!/bin/bash

# Prompt for the project name
read -p "Enter the project name: " projectName

# Set default values for other parameters
archetypeGroupId="nl.mpdev"
archetypeArtifactId="first-archetype-archetype"
archetypeVersion="1.0-SNAPSHOT"
groupId="nl.mpdev"
version="1.0-SNAPSHOT"

# Run the Maven archetype:generate command
mvn archetype:generate \
    -DarchetypeGroupId=${archetypeGroupId} \
    -DarchetypeArtifactId=${archetypeArtifactId} \
    -DarchetypeVersion=${archetypeVersion} \
    -DgroupId=${groupId} \
    -DartifactId=${projectName} \
    -Dversion=${version} \
    -DinteractiveMode=false

# Print a message indicating that the project has been generated
echo "Project ${projectName} has been generated successfully."

