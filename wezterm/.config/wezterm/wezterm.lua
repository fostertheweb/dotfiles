local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = 'Medallion (Gogh)'
config.font = wezterm.font 'BerkeleyMono Nerd Font'
config.font_size = 14.0
config.line_height = 1.2

-- UI
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- Keybindings
config.keys = {
  {
    key = 'h',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'ALT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
}

return config
