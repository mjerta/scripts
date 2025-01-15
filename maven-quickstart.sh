#!/bin/bash

read -p "Enter the project name: " projectName

mvn archetype:generate \
    -DgroupId=nl.mpdev \
    -DartifactId=${projectName} \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DinteractiveMode=false

echo "Project ${projectName} has been generated successfully."

cd "${projectName}" || exit 1

