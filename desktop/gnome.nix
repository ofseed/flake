{ config, pkgs, ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable flatpak and automatically configure the flatpak repository
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nautilus-python

    gnomeExtensions.appindicator
    gnomeExtensions.kimpanel
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
  };

  programs = {
    kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
  };
}
