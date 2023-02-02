#!/usr/bin/env sh


if [ "$DISPLAY" != ":0" ]; then
    export DISPLAY=:0
fi

xset s off
xset s noexpose
xset s noblank
xset s 0 0

xset dpms force off
