#!/bin/sh

# gnome-terminal schema file
# https://git.gnome.org/browse/gnome-terminal/tree/src/org.gnome.Terminal.gschema.xml

# disable cursor blink on gnome-terminal
gsettings set org.gnome.desktop.interface cursor-blink false

gsettings set org.gnome.shell.app-switcher current-workspace-only true

gsettings set org.gnome.desktop.background primary-color '#1d2021'
gsettings set org.gnome.desktop.background secondary-color '#1d2021'
