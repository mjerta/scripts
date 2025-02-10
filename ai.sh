#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Usage: $0 \"your prompt here\""
	exit 1
fi

gh copilot explain "$@"
	
