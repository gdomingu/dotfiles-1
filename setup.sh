#!/bin/bash

set -ex

# Figure out the absolute path of the dotfiles directory
DOTFILESDIRREL="$(dirname "$0")"
cd $DOTFILESDIRREL/..
DOTFILESDIR="$(pwd -P)"

ln -sf "$DOTFILESDIR" "$HOME/.dotfiles"
cat "$DOTFILESDIR/.zprofile " >> "$HOME/.zprofile "
