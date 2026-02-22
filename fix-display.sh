#!/bin/bash
# Force laptop screen ON + primary, then mirror to HDMI projector.
# If your outputs differ, run: xrandr  (and replace eDP-1 / HDMI-1 accordingly)

set -e

xrandr --output eDP-1 --auto --primary
xrandr --output HDMI-1 --auto --same-as eDP-1
