# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  nixos-wsl,
  ...
}:

{
  imports = [
    # include NixOS-WSL modules
    nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;
    defaultUser = "ofseed";
    startMenuLaunchers = true;
    useWindowsDriver = true;
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = [
        "/run/opengl-driver/lib"
      ];
    };
    systemPackages = with pkgs; [
      weston
      adwaita-icon-theme
    ];
  };
}
