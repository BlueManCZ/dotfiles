#!/usr/bin/env sh

# Automatically restart the Waybar after the config change.
# Inspired by: https://github.com/Alexays/Waybar/issues/961

# Waybar configuration files
CONFIG_FILE="$HOME/.config/waybar/config.jsonc"
STYLE_FILE="$HOME/.config/waybar/style.css"

if ! command -v "inotifywait" &> "/dev/null"; then
  echo "Error: inotifywait binary not found. Please install it and run this script again."
  exit 1
fi

if ! test -f "$CONFIG_FILE"; then
  echo "File $CONFIG_FILE doesn't exist."
  exit 1
fi

if ! test -f "$STYLE_FILE"; then
  echo "File $STYLE_FILE doesn't exist."
  exit 1
fi

# Kill all Waybar instances when this script exits.
trap "killall waybar" EXIT

# Start the Waybar and restart it if any config changes occur.
while true; do
  waybar &
  inotifywait -e create,modify $CONFIG_FILE $STYLE_FILE
  killall waybar
done
