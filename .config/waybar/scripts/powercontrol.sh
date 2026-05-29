#!/bin/bash

# Simple list for Wofi
entries="Lock\nLogout\nSuspend\nReboot\nShutdown"

# Use wofi to select - I increased height to 270 to fit the 5th "Lock" button
selected=$(echo -e "$entries" | wofi --dmenu --width 200 --height 180  --cache-file /dev/null)

case $selected in
  *Lock*)
    hyprlock ;;
  *Logout*)
    hyprctl dispatch exit ;;
  *Suspend*)
    systemctl suspend ;;
  *Reboot*)
    systemctl reboot ;;
  *Shutdown*)
    systemctl poweroff ;;
esac
