#!/usr/bin/env zsh

export ENHANCE_THEME=medallion

if [[ "$(whoami)" == "jonathan.foster" ]]; then
	# work computer
	export TERMINAL_FONT_FAMILY="BlexMono Nerd Font Mono"
	export TERMINAL_FONT_SIZE=14
	export GHOSTTY_THEME="Melange Dark"
	export DEFAULT_AGENT="claude"
else
	# personal computer
	export TERMINAL_FONT_FAMILY="BerkeleyMono Nerd Font"
	export TERMINAL_FONT_SIZE=14
	export GHOSTTY_THEME="light:paper,dark:eyes-dark"
	export DEFAULT_AGENT="amp"
fi
