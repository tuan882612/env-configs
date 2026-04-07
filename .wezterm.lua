local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Additional
config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"

-- Window
config.initial_cols = 120
config.initial_rows = 40
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
config.window_background_opacity = 0.9 -- 0.0 (transparent) to 1.0 (opaque)

-- Theme
-- config.color_scheme = 'Black Metal (Dark Funeral) (base16)' -- tons of built-in themes
local dark_scheme = "Black Metal (Dark Funeral) (base16)"
local light_scheme = "Ef-Frost"

config.color_scheme = dark_scheme

wezterm.on("toggle-theme", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if overrides.color_scheme == light_scheme then
    overrides.color_scheme = dark_scheme
  else
    overrides.color_scheme = light_scheme
  end
  window:set_config_overrides(overrides)
end)

-- Font (matching your screenshot: Normal weight, 21px, 1.2 line height)
config.font = wezterm.font("CaskaydiaMono Nerd Font Mono", { weight = "Regular" })
config.font_size = 21
config.line_height = 1.2

-- Default shell: WSL Ubuntu
config.default_prog = { "wsl", "-d", "Ubuntu", "--cd", "~" }

-- Tabs
config.enable_tab_bar = true
config.use_fancy_tab_bar = true

-- Keybindings
config.keys = {
  {
    key = "1",
    mods = "ALT",
    action = wezterm.action.SpawnCommandInNewTab({
      args = { "wsl", "-d", "Ubuntu", "--cd", "~" },
    }),
  },
  {
    key = "2",
    mods = "ALT",
    action = wezterm.action.SpawnCommandInNewTab({
      args = { "pwsh.exe" },
    }),
  },
  {
    key = "n",
    mods = "ALT",
    action = wezterm.action.SpawnWindow,
  },
  {
    key = "q",
    mods = "CTRL",
    action = wezterm.action.QuitApplication,
  },
  {
    key = "t",
    mods = "ALT",
    action = wezterm.action.EmitEvent("toggle-theme"),
  },              
}

return config