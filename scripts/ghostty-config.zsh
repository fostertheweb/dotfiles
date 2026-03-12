#!/usr/bin/env zsh

GHOSTTY_DIR="${DOTFILES_PREFIX}/ghostty/.config/ghostty"
TEMPLATE_FILE="${GHOSTTY_DIR}/config.template"
OUTPUT_FILE="${GHOSTTY_DIR}/config"

: ${TERMINAL_FONT_FAMILY:="BerkeleyMono Nerd Font"}
: ${TERMINAL_FONT_SIZE:="14"}
: ${GHOSTTY_THEME:="light:paper,dark:eyes-dark"}

if [[ ! -f "$TEMPLATE_FILE" ]]; then
    echo "Error: Template file not found at $TEMPLATE_FILE"
    exit 1
fi

echo "Building Ghostty config with:"
echo "  Font Family: $TERMINAL_FONT_FAMILY"
echo "  Font Size: $TERMINAL_FONT_SIZE"
echo "  Theme: $GHOSTTY_THEME"
echo ""

# Read template and perform substitutions
config_content=$(<"$TEMPLATE_FILE")
config_content="${config_content//\{\{TERMINAL_FONT_FAMILY\}\}/$TERMINAL_FONT_FAMILY}"
config_content="${config_content//\{\{TERMINAL_FONT_SIZE\}\}/$TERMINAL_FONT_SIZE}"
config_content="${config_content//\{\{GHOSTTY_THEME\}\}/$GHOSTTY_THEME}"

# Write the output file
echo "$config_content" > "$OUTPUT_FILE"

echo "✓ Config file generated at: $OUTPUT_FILE"
