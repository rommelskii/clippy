#!/bin/bash

# setup.sh 
# This script will run if the clippy daemon detects that the system runs on macOS,
# of which it can simply utilize the Automator features for fetching from the clipboard buffer
# and into the Python daemon


ACTION_NAME="Create a flashcard to Clippy"
WORKFLOW_PATH="$HOME/Library/Services/${ACTION_NAME}.workflow"
CONTENTS_PATH="$WORKFLOW_PATH/Contents"

#1. create the workflow
#2. wrap around the xclip and utilize a named pipe in /tmp
#3. call it a day
