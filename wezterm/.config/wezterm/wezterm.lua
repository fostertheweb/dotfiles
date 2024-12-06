local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Appearance
-- config.color_scheme = 'Black Metal (Bathory) (base16)'
-- config.color_scheme = 'SeaShells'
-- config.color_scheme = 'Rosé Pine (Gogh)'
config.color_scheme = 'melange'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = 'Oxocarbon Dark (Gogh)'
-- config.color_scheme = 'Tender (Gogh)'
config.font = wezterm.font 'BerkeleyMono Nerd Font'
config.font_size = 14.0
config.line_height = 1.2

-- UI
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

return config
