#!/bin/sh

# Checks for the existence of a program.
exists() {
  command -v "$1" &> "/dev/null";
}

# Starts a program if it exists.
start() {
  if exists $1; then
    $1 &
  fi
}

# Albert launcher
# | https://github.com/albertlauncher/albert
start albert

# PipeWire
# | https://gitlab.freedesktop.org/pipewire/pipewire
# | https://wiki.gentoo.org/wiki/PipeWire#gentoo-pipewire-launcher
start gentoo-pipewire-launcher
