#!/usr/bin/env sh

# Add custom scripts to $PATH
PATH="$PATH:$HOME/.config/hypr/scripts"

# Checks for the existence of a program.
exists() {
  command -v "$1" &> "/dev/null";
}

# Starts a program if it exists.
start() {
  if exists $1; then
    $1 &
  else
    echo "$1 doesn't exist."
  fi
}

# Albert launcher
# | https://github.com/albertlauncher/albert
start albert

# PipeWire
# | https://gitlab.freedesktop.org/pipewire/pipewire
# | https://wiki.gentoo.org/wiki/PipeWire#gentoo-pipewire-launcher
start gentoo-pipewire-launcher

# Waybar
# | https://github.com/Alexays/Waybar
start launch-waybar.sh
