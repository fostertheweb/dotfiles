local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Appearance
-- config.color_scheme = 'Mikado (terminal.sexy)'
config.font = wezterm.font 'BerkeleyMono Nerd Font'
config.font_size = 14.0
config.line_height = 1.2

-- UI
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

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

config.colors = {
  cursor_bg = '#eeeeee',
  cursor_fg = '#282828',
  cursor_border = '#eeeeee',
  foreground = '#eeeeee',
  background = '#282828',
  ansi = {
    '#282828',
    '#f43753',
    '#c9d05c',
    '#ffc24b',
    '#b3deef',
    '#d3b987',
    '#73cef4',
    '#eeeeee',
  },
  brights = {
    '#4c4c4c',
    '#f43753',
    '#c9d05c',
    '#ffc24b',
    '#b3deef',
    '#d3b987',
    '#73cef4',
    '#feffff',
  },
}

return config
