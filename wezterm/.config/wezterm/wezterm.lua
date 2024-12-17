local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Appearance
-- config.color_scheme = 'Black Metal (Bathory) (base16)'
-- config.color_scheme = 'SeaShells'
config.color_scheme = 'Rosé Pine (Gogh)'
-- config.color_scheme = 'melange'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = 'Oxocarbon Dark (Gogh)'
-- config.color_scheme = 'Tender (Gogh)'
config.font = wezterm.font 'BerkeleyMono Nerd Font'
config.font_size = 14.0
config.line_height = 1.3

-- UI
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
  -- Send escape strings with CMD
  {
    key = 'e',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1be',
  },
  {
    key = 'o',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1bo',
  },
  {
    key = 't',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1bt',
  },
  {
    key = '.',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1b.',
  },
  {
    key = 'f',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1bf',
  },
  {
    key = 's',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1bs',
  },
  {
    key = 'g',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1bg',
  },
  {
    key = 'r',
    mods = 'CMD',
    action = wezterm.action.SendString '\x1br',
  },
}

return config
