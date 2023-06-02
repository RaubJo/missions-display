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

sleep 5

printf "# Screen On #\n  $(date)\n" | sudo tee -a "/home/user/log.txt"

# Start the slideshow after a few seconds to let the hardware catch up to the software
exec /home/user/missions-display/scripts/slideshow.sh
