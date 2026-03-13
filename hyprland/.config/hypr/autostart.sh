#!/usr/bin/env bash

# Add custom scripts to $PATH
PATH="$PATH:$HOME/.local/bin:$HOME/.config/hypr/scripts"

# Wait for Hyprland to be ready (monitors configured)
for i in $(seq 1 50); do
  hyprctl monitors -j 2>/dev/null | grep -q '"id"' && break
  sleep 0.1
done

# Checks for the existence of a program.
exists() {
  command -v "$1" &>"/dev/null";
}

# Starts a program if it exists.
start() {
  if exists $1; then
    $1 ${@:2} &
  else
    echo "$1 doesn't exist."
  fi
}

# Waybar
# | https://github.com/Alexays/Waybar
start launch-waybar.sh

# Wallpaper
# | https://github.com/hyprwm/hyprpaper
start hyprpaper

# Albert launcher
# | https://github.com/albertlauncher/albert
start albert

# PipeWire
# | https://gitlab.freedesktop.org/pipewire/pipewire
# | https://wiki.gentoo.org/wiki/PipeWire#gentoo-pipewire-launcher
start gentoo-pipewire-launcher

# Roon MPRIS extension
# | https://github.com/BlueManCZ/roon-pipe
start roonpipe >/dev/null

# Geary mail client
# | https://gitlab.gnome.org/GNOME/geary
start geary --gapplication-service

# Authentication agent
start /usr/libexec/polkit-gnome-authentication-agent-1

# Set cursor theme
# https://github.com/clayrisser/breeze-hacked-cursor-theme
hyprctl setcursor breeze-hacked-cursor-theme 24

sleep 2

# Telegram
# | https://github.com/telegramdesktop/tdesktop
start telegram-desktop -startintray

# OpenRGB
# | https://github.com/CalcProgrammer1/OpenRGB
start openrgb --startminimized

# Network Manager applet
# | https://gitlab.gnome.org/GNOME/network-manager-applet
#start nm-applet

# MEGA sync client
start megasync
