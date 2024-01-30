local wezterm = require "wezterm"

local config = {
  font = wezterm.font "CaskaydiaCove Nerd Font",
}

local windows_config = {
  default_domain = "WSL:NixOS",
}

if wezterm.target_triple:find "windows" then
  for k, v in pairs(windows_config) do
    config[k] = v
  end
end

return config
