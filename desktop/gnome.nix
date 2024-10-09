{ config, pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # GNOME will respect the PrefersNonDefaultGPU property in the desktop entry.
  services.switcherooControl.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    evince # Replace with papers
    gnome-console # Better off without it
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    with pkgs;
    [
      papers # Next generation of GNOME's default document viewer
      nautilus-python
    ]
    ++ (with pkgs.gnomeExtensions; [
      # The must-have extension
      appindicator

      # For better UI experience
      no-overview
      blur-my-shell

      # For match the workspace behavior of PapeWM
      vertical-workspaces
      paperwm
    ]);

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
