# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ghostty,
  ...
}:

{
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ofseed = {
    isNormalUser = true;
    description = "Yi Ming";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LANGUAGE = "zh_CN:zh:en_US:en";
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };
    inputMethod = {
      ibus = {
        engines = with pkgs.ibus-engines; [
          rime
        ];
      };
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-rime
        ];
      };
    };
  };

  xdg = {
    terminal-exec = {
      enable = true;
      settings = {
        default = [ "kitty.desktop" ];
        GNOME = [ "com.mitchellh.ghostty.desktop" ];
      };
    };
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
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
      dconf-editor
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
