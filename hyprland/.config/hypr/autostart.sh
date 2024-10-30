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
    $1 ${@:2} &
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

# Telegram
# | https://github.com/telegramdesktop/tdesktop
start telegram-desktop -startintray

# OpenRGB
# | https://github.com/CalcProgrammer1/OpenRGB
start openrgb --startminimized

# Roon MPRIS extension
# | https://github.com/brucejcooper/roon-mpris
start roon-mpris > /dev/null

# Authentication and keyring
start /usr/libexec/polkit-gnome-authentication-agent-1

start gnome-keyring-daemon --start

# Set cursor theme
# https://github.com/clayrisser/breeze-hacked-cursor-theme
hyprctl setcursor breeze-hacked-cursor-theme 24
