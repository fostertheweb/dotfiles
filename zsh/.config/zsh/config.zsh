#!/usr/bin/env zsh

export ENHANCE_THEME=medallion

if [[ "$(whoami)" == "jonathan.foster" ]]; then
	# work computer
	export BORDERS_COLOR=0xffcf9dff
	export TERMINAL_FONT_FAMILY="BlexMono Nerd Font Mono"
	export TERMINAL_FONT_SIZE=14
	export GHOSTTY_THEME="Melange Dark"
	export DEFAULT_MODEL="github-copilot/claude-sonnet-4.5"
	export DEFAULT_AGENT="claude"
else
	# personal computer
	export BORDERS_COLOR=0xffFEE3E3
	export TERMINAL_FONT_FAMILY="BerkeleyMono Nerd Font"
	export TERMINAL_FONT_SIZE=14
	export GHOSTTY_THEME="light:paper,dark:eyes-dark"
	export DEFAULT_MODEL="google/gemini-3.1-pro-preview"
	export DEFAULT_AGENT="amp"
fi
