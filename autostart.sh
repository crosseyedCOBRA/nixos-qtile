#!/bin/sh

# Start picom compositor in the background
picom --backend glx & 

# Set wallpaper (Update path to your image)
if [ -f ~/Pictures/wallpaper.jpg ]; then
    feh --bg-fill ~/Pictures/wallpaper.jpg &
fi
