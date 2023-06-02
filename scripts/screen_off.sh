#!/usr/bin/env sh


if [ "$DISPLAY" != ":0" ]; then
    export DISPLAY=:0
fi

xset s off
xset s noexpose
xset s noblank
xset s 0 0

xset dpms force off

printf "# Screen Off #\n  $(date)\n" | sudo tee -a "/home/user/log.txt"

# Feh is the program that the slideshow starts, killing it will shutdown the script
pkill "feh"
