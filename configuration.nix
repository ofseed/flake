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
    startMenuLaunchers = true;
    useWindowsDriver = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  users.users.ofseed = {
    isNormalUser = true;
    description = "Yi Ming";
    extraGroups = [
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  time.timeZone = "Asia/Shanghai";

  i18n = {
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LANGUAGE = "zh_CN:zh:en_US:en";
    };
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-rime
        ];
      };
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

  virtualisation.docker = {
    enable = true;
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-extra
      cascadia-code
      (nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
        ];
      })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif CJK SC" ];
        sansSerif = [ "Noto Sans CJK SC" ];
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Cascadia Code"
          "Symbols Nerd Font Mono"
        ];
      };
    };
  };

  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = [
        "/run/opengl-driver/lib"
      ];
    };
    systemPackages = with pkgs; [
      # Toolchains
      luajit
      luajitPackages.luarocks
      nodejs
      corepack
      python3
      gcc
      llvmPackages.clang-tools
      rustup
      zig
      go

      # CLI
      xdg-utils
      git
      unzip
      wget
      wl-clipboard

      # GUI
      weston
      dconf-editor
      adwaita-icon-theme
      kitty
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
    fish = {
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
