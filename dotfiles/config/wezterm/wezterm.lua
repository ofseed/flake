local wezterm = require "wezterm"

local config = {
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font "CaskaydiaCove Nerd Font",
  initial_cols = 100,
  initial_rows = 45,
  window_background_opacity = 0.7,
  window_padding = {
    left = "0cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell",
  },
}

local windows_config = {
  default_domain = "WSL:NixOS",
  win32_system_backdrop = "Acrylic",
}

if wezterm.target_triple:find "windows" then
  for k, v in pairs(windows_config) do
    config[k] = v
  end
end

return config
