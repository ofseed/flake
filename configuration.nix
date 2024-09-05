# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  nixos-wsl,
  ghostty,
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
    interop.includePath = false;
    startMenuLaunchers = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  i18n = {
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LANGUAGE = "zh_CN:zh:en_US:en";
    };
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
    systemPackages = with pkgs; [
      # Toolchains
      luajit
      luajitPackages.luarocks
      nodejs
      corepack
      python3
      go
      rustup
      zig

      # CLI
      git
      unzip
      wget
      wl-clipboard

      # GUI
      dconf-editor
      adwaita-icon-theme
      ghostty.packages.x86_64-linux.default
      mpv
    ];
  };

  programs = {
    nix-ld = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };
  };
}
