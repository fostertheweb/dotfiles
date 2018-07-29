#!/usr/bin/env bash

# caps lock becomes ctrl
setxkbmap -option ctrl:nocaps

# natural scrolling on X1C trackpad
xinput set-button-map 12 1 3 2 4 5

# load config
xrdb .Xresources

# start i3wm
exec i3
