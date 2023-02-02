#!/usr/bin/env bash

if [ "$DISPLAY" != ":0" ]; then
    export DISPLAY=:0
fi

xrandr --output HDMI-1 --rotate left
xrandr --output HDMI-2 --rotate left

sleep 2

TARGET_DIR="$HOME/png_letters"

if [ "$PWD" != "$TARGET_DIR" ]; then
    cd "$TARGET_DIR" || return
    feh --hide-pointer --fullscreen --no-menus --slideshow-delay 90 --sort name --zoom fill
else
    echo "Wrong Directory"
fi
