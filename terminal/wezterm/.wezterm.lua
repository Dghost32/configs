local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- [[ Theme — matches nvim + Zed ]]
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.6

-- [[ Rendering ]]
config.front_end = 'WebGpu'
config.enable_wayland = false

-- [[ Tab bar ]]
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- [[ Font — JetBrains Mono with ligatures ]]
-- => === !== <= <== >= ==> != ++ -- -> => <=>
config.font = wezterm.font {
  family = 'JetBrains Mono',
  harfbuzz_features = { 'calt=2', 'clig=1', 'liga=1' },
}
config.font_size = 11.5
config.warn_about_missing_glyphs = false

-- [[ Window ]]
config.window_padding = {
  left = 1,
  right = 1,
  top = 1,
  bottom = 1,
}

config.inactive_pane_hsb = {
  brightness = 0.5,
}

-- [[ Keys ]]
config.disable_default_key_bindings = true
local act = wezterm.action
config.leader = { key = 's', mods = 'CTRL' }

config.keys = {
  -- Clipboard
  { key = 'V', mods = 'CTRL|SHIFT', action = act { PasteFrom = 'Clipboard' } },
  { key = 'C', mods = 'CTRL|SHIFT', action = act { CopyTo = 'Clipboard' } },

  -- [[ PANE MANAGEMENT ]]
  -- Splitting
  { key = '-', mods = 'LEADER',       action = act { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = '_', mods = 'LEADER|SHIFT', action = act { SplitVertical = { domain = "CurrentPaneDomain" } } },
  -- Navigation
  { key = 'h', mods = 'LEADER', action = act { ActivatePaneDirection = 'Left' } },
  { key = 'j', mods = 'LEADER', action = act { ActivatePaneDirection = 'Down' } },
  { key = 'k', mods = 'LEADER', action = act { ActivatePaneDirection = 'Up' } },
  { key = 'l', mods = 'LEADER', action = act { ActivatePaneDirection = 'Right' } },
  -- Resizing
  { key = 'H', mods = 'ALT', action = act.AdjustPaneSize { 'Left', 2 } },
  { key = 'J', mods = 'ALT', action = act.AdjustPaneSize { 'Down', 2 } },
  { key = 'K', mods = 'ALT', action = act.AdjustPaneSize { 'Up', 2 } },
  { key = 'L', mods = 'ALT', action = act.AdjustPaneSize { 'Right', 2 } },
  -- Closing
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
  -- Zooming
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

  -- [[ TAB MANAGEMENT ]]
  { key = 't', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'LEADER', action = act.CloseCurrentTab { confirm = true } },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = '1', mods = 'LEADER', action = act.ActivateTab(0) },
  { key = '2', mods = 'LEADER', action = act.ActivateTab(1) },
  { key = '3', mods = 'LEADER', action = act.ActivateTab(2) },
  { key = '4', mods = 'LEADER', action = act.ActivateTab(3) },
  { key = '5', mods = 'LEADER', action = act.ActivateTab(4) },
  { key = '6', mods = 'LEADER', action = act.ActivateTab(5) },
  { key = '7', mods = 'LEADER', action = act.ActivateTab(6) },
  { key = '8', mods = 'LEADER', action = act.ActivateTab(7) },
  { key = '9', mods = 'LEADER', action = act.ActivateTab(8) },

  -- [[ SCROLLBACK SEARCH ]]
  { key = '/', mods = 'LEADER', action = act.Search 'CurrentSelectionOrEmptyString' },

  -- [[ FONT SIZE ]]
  { key = 'f', mods = 'LEADER', action = act.IncreaseFontSize },
  { key = 'd', mods = 'LEADER', action = act.DecreaseFontSize },

  -- [[ WORKSPACES ]]
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
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
            act.SwitchToWorkspace { name = line },
            pane
          )
        end
      end),
    },
  },
}

-- [[ Status bar — show workspace name ]]
wezterm.on('update-right-status', function(window)
  window:set_right_status(wezterm.format {
    { Foreground = { Color = '#cba6f7' } },
    { Text = ' ' .. window:active_workspace() .. ' ' },
  })
end)

config.automatically_reload_config = true

return config
