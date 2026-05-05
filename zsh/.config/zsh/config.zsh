#!/usr/bin/env zsh

export ENHANCE_THEME=medallion

if [[ "$(whoami)" == "jonathan.foster" ]]; then
	# work computer
	export TERMINAL_FONT_FAMILY="BlexMono Nerd Font Mono"
	export TERMINAL_FONT_SIZE=14
	export GHOSTTY_THEME="witchesbrew-bright"
	export DEFAULT_AGENT="codex"
else
	# personal computer
	export TERMINAL_FONT_FAMILY="BerkeleyMono Nerd Font"
	export TERMINAL_FONT_SIZE=14
	export GHOSTTY_THEME="light:olive-crt,dark:carvion"
	export DEFAULT_AGENT="pi"
fi
