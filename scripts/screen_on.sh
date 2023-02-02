#!/usr/bin/env sh

if [ "$DISPLAY" != ":0" ]; then
    export DISPLAY=:0
fi

xset s off
xset s noexpose
xset s noblank
xset s 0 0

xset dpms force on

sleep 7

xrandr --output HDMI-1 --rotate left
xrandr --output HDMI-2 --rotate left