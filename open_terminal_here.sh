#!/bin/bash

# Get the PID of the focused window
focused_pid=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true).pid')

if [[ -n "$focused_pid" ]]; then
    # Traverse the child processes to find the shell process
    shell_pid=$(pgrep -P $focused_pid)

    # If a shell PID is found, determine its working directory
    if [[ -n "$shell_pid" ]]; then
        cwd=$(readlink /proc/$shell_pid/cwd)
    fi
fi

# Default to home directory if CWD isn't determined
cwd=${cwd:-$HOME}

# Open a new terminal in the determined working directory
foot --working-directory "$cwd"

