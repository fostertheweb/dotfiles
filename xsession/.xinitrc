#!/usr/bin/env bash

# start pulseaudio
start-pulseaudio-x11

# caps lock becomes ctrl
setxkbmap -option ctrl:nocaps

# natural scrolling on X1C trackpad
xinput set-button-map 12 1 25 3 5 4

# load config
xrdb .Xresources

# start i3wm
exec i3
