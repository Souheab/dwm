#!/usr/bin/env nix-shell
#!nix-shell -i bash -p xorg.libX11 xorg.libXft xorg.libXinerama fontconfig freetype pkg-config gcc gnumake

# Build script for dwm using nix-shell
# This allows compilation regardless of host operating system environment

echo "Building dwm with Nix environment..."
make "$@"
