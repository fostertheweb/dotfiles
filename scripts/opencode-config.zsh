#!/usr/bin/env zsh

OPENCODE_DIR="${DOTFILES_PREFIX}/opencode/.config/opencode"
TEMPLATE_FILE="${OPENCODE_DIR}/config.json.template"
OUTPUT_FILE="${OPENCODE_DIR}/config.json"

: ${DEFAULT_MODEL:="google/gemini-3.1-pro-preview"}

if [[ ! -f "$TEMPLATE_FILE" ]]; then
	echo "Error: Template file not found at $TEMPLATE_FILE"
	exit 1
fi

echo "Building OpenCode config with:"
echo "  Default model: $DEFAULT_MODEL"
echo ""

# Read template and perform substitutions
config_content=$(<"$TEMPLATE_FILE")
config_content="${config_content//\{\{DEFAULT_MODEL\}\}/$DEFAULT_MODEL}"

# Write the output file
echo "$config_content" >"$OUTPUT_FILE"

echo "✓ Config file generated at: $OUTPUT_FILE"
