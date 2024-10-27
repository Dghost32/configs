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
  harfbuzz_features = { 'calt=2', 'clig=1', 'liga=1' },
}

config.font_size = 11.5

config.window_padding = {
  left = 1,
  right = 1,
  top = 1,
  bottom = 1,
}

config.inactive_pane_hsb = {
  brightness = 0.5,
}

-- Keys
config.disable_default_key_bindings = true
local act = wezterm.action
config.leader = { key = 's', mods = 'CTRL' }

config.keys = {
  { key = 'V', mods = 'CTRL|SHIFT',       action = act { PasteFrom = 'Clipboard' } },
  { key = 'C', mods = 'CTRL|SHIFT',       action = act { CopyTo = 'Clipboard' } },
  -- [[PANE MANAGEMENT]]
  -- Splitting
  { key = '-', mods = 'LEADER',       action = act { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = '_', mods = 'LEADER|SHIFT', action = act { SplitVertical = { domain = "CurrentPaneDomain" } } },
  -- Navigation
  { key = 'h', mods = 'LEADER',       action = act { ActivatePaneDirection = 'Left' } },
  { key = 'j', mods = 'LEADER',       action = act { ActivatePaneDirection = 'Down' } },
  { key = 'k', mods = 'LEADER',       action = act { ActivatePaneDirection = 'Up' } },
  { key = 'l', mods = 'LEADER',       action = act { ActivatePaneDirection = 'Right' } },
  -- Resizing { key = 'H', mods = 'ALT',          action = act.AdjustPaneSize { 'Left', 2 } },
  { key = 'J', mods = 'ALT',          action = act.AdjustPaneSize { 'Down', 2 } },
  { key = 'K', mods = 'ALT',          action = act.AdjustPaneSize { 'Up', 2 } },
  { key = 'L', mods = 'ALT',          action = act.AdjustPaneSize { 'Right', 2 } },
  -- Closing
  { key = 'x', mods = 'LEADER',       action = act.CloseCurrentPane { confirm = true } },
  -- Zooming
  { key = 'z', mods = 'LEADER',       action = act.TogglePaneZoomState },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
  -- create workspace
  {
    key = 'c',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
}

config.automatically_reload_config = true

-- and finally, return the configuration to wezterm
return config
