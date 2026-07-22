#!/usr/bin/env zsh

export ENHANCE_THEME=medallion
export TERMINAL_FONT_FAMILY="IosevkaTerm Nerd Font Mono"
export TERMINAL_FONT_SIZE=15

if [[ "$(whoami)" == "jonathan.foster" ]]; then
	# work computer
	export GHOSTTY_THEME="light:south,dark:carvion"
	export DEFAULT_AGENT="codex"
else
	# personal computer
	export GHOSTTY_THEME="light:olive-crt,dark:carvion"
	export DEFAULT_AGENT="pi"
fi
