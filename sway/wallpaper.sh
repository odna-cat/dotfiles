#!/bin/bash

# WALLPAPER DIRECTORY
walldir = '$HOME/.config/sway/wallpaper'

# Get a list of all image files in the wallpapers directory
wallpapers=("$walldir"/*)

# Start an infinite loop
while true; do
  # Check if the wallpapers array is empty
  if [ ${#wallpapers[@]} -eq 0 ]; then
    # If the array is empty, refill it with the image files
    wallpapers=("$walldir"/*)
  fi

  # Select a random wallpaper from the array
  wallpaperIndex=$((RANDOM % ${#wallpapers[@]}))
  selectedWallpaper="${wallpapers[$wallpaperIndex]}"

  # Update the wallpaper using the swww img command
  swww img "$selectedWallpaper"

  # Remove the selected wallpaper from the array
  unset "wallpapers[$wallpaperIndex]"

  # Delay for 2 hours before selecting the next wallpaper
  sleep 1h
done

