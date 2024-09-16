{ config, pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.kimpanel
    gnomeExtensions.blur-my-shell
    gnomeExtensions.paperwm
  ];

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
  };

  programs = {
    kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
  };
}
