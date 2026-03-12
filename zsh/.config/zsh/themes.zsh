#!/usr/bin/env zsh

if [[ "$(whoami)" == "jonathan.foster" ]]; then
	# work computer
	export BORDERS_COLOR=0xffcf9dff
	export TERMINAL_FONT_FAMILY="BlexMono Nerd Font Mono"
	export TERMINAL_FONT_SIZE=14
	export GHOSTTY_THEME="Melange Dark"
else
	# personal computer
	export BORDERS_COLOR=0xffFEE3E3
	export TERMINAL_FONT_FAMILY="BerkeleyMono Nerd Font"
	export TERMINAL_FONT_SIZE=14
	export GHOSTTY_THEME="light:paper,dark:eyes-dark"
fi
