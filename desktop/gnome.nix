{ config, pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # GNOME will respect the PrefersNonDefaultGPU property in the desktop entry.
  services.switcherooControl.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    evince # Replace with papers
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    papers # Next generation of GNOME's default document viewer
    nautilus-python

    gnomeExtensions.appindicator
    gnomeExtensions.no-overview
    gnomeExtensions.blur-my-shell

    # For match the workspace behavior of PapeWM
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.paperwm
  ];

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
  };

  xdg.mime.defaultApplications = {
    "inode/directory" = "org.gnome.Nautilus.desktop";
    "application/pdf" = "org.gnome.Papers.desktop";
    "application/zip" = "org.gnome.FileRoller.desktop";
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/webp" = "org.gnome.Loupe.desktop";
    "image/png" = "org.gnome.Loupe.desktop";
  };

  programs = {
    kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
  };
}
