#!/bin/bash
export DISPLAY=:0

xset s off
xset s noexpose
xset s noblank
xset -dpms
xset dpms 0 0 0
xset s 0 0 

xrandr --output HDMI-1 --rotate left
xrandr --output HDMI-2 --rotate left

python3 renderPdf.py
