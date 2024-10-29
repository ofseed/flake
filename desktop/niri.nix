{ config, pkgs, ... }:
{
  programs.niri.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
  };

  programs.waybar.enable = true;
}
