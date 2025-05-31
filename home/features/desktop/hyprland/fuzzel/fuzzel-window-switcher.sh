#!/usr/bin/env bash

# Get a list of all the windows, ignoring the currently active window.
ACTIVE_WIN=$(hyprctl activewindow -j | jq -r '.title')

WINDOWS=$(hyprctl clients -j | jq -r --arg WIN_TO_IGNORE "$ACTIVE_WIN" '.[] | select(.mapped = true) | del(.. | select(. == $WIN_TO_IGNORE)) | .title | select(. != null)')

# Create a window selection menu and finally, switch to a window.
echo "$WINDOWS" | sort | fuzzel --dmenu --width 50 --prompt "Switch to window > " | xargs -I{} hyprctl dispatch focuswindow "title:{}"
