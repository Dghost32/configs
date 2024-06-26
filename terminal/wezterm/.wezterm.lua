-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Catppuccin Mocha (Gogh)'
config.window_background_opacity = 0.875

config.enable_tab_bar = false 
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font {
  family = 'JetBrains Mono',
  -- NOTE: Font Ligatures are enabled => === !== <= <== >= ==> != ++ -- -> => <=>
  harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
}

config.font_size = 10.5

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.inactive_pane_hsb = {
  -- NOTE: these values are multipliers, applied on normal pane values
  saturation = 0.9,
  brightness = 0.8,
}

config.automatically_reload_config = true

-- and finally, return the configuration to wezterm
return config
