#!/usr/bin/env bash
export DISPLAY=:0
sleep 30

xset s off
xset s noexpose
xset s noblank
xset -dpms
xset dpms 0 0 0
xset s 0 0

xrandr --output HDMI-1 --rotate left
xrandr --output HDMI-2 --rotate left
TARGET_DIR="/home/user/missions-display/resources/resized_images"
CURRENT_DIR=$PWD

if [[ "$CURRENT_DIR" != "$TARGET_DIR" ]]; then
        cd $TARGET_DIR 
        feh -YFN -D 90 -S name --zoom fill
else
	echo "Wrong Directory"
fi
