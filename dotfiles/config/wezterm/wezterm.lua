local wezterm = require "wezterm"

local common_config = {
  color_scheme = "Catppuccin Mocha",

  font = wezterm.font {
    family = "CaskaydiaCove Nerd Font",
    harfbuzz_features = { "calt", "ss01", "ss02" },
  },

  initial_cols = 100,
  initial_rows = 45,
  window_background_opacity = 0.7,
  window_padding = {
    left = "0cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell",
  },

  default_prog = { "/home/ofseed/.nix-profile/bin/fish" },
}

local wsl_domains = wezterm.default_wsl_domains()

for _, domains in ipairs(wsl_domains) do
  domains.default_prog = common_config.default_prog
end

local windows_config = {
  wsl_domains = wsl_domains,
  default_domain = "WSL:NixOS",
  win32_system_backdrop = "Acrylic",
}

local config = wezterm.config_builder()

for k, v in pairs(common_config) do
  config[k] = v
end

if wezterm.target_triple:find "windows" then
  for k, v in pairs(windows_config) do
    config[k] = v
  end
end

return config
