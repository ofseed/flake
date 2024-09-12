{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ofseed";
  home.homeDirectory = "/home/ofseed";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Programs
    nixd
    nixfmt-rfc-style
    nvimpager
    unixtools.xxd
    tree-sitter
    lazydocker

    # Libraries
    luajitPackages.magick

    # Fonts
    cascadia-code
    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
      ];
    })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".ideavimrc".source = dotfiles/ideavimrc;
    ".terminfo".source = dotfiles/terminfo;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ofseed/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "nvimpager";
  };

  home.shellAliases = {
    hm = "home-manager";
    pn = "pnpm";
  };

  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  xdg = {
    configFile = {
      "lf/icons".source = ./xdg/config/lf/icons;
      "fish/functions/lfcd.fish".source = ./xdg/config/fish/functions/lfcd.fish;
      "ghostty/config".source = ./xdg/config/ghostty/config;
      "git/config".text = lib.mkAfter (builtins.readFile ./xdg/config/git/git-pickaxe-aliases.gitconfig);
    };
    dataFile = {
      "fonts" = {
        source = ./xdg/data/fonts;
        recursive = true;
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    nix-index-database = {
      comma = {
        enable = true;
      };
    };

    fish = {
      enable = true;
      shellInit = builtins.readFile ./xdg/config/fish/config.fish;
      interactiveShellInit = builtins.readFile ./xdg/config/fish/interactive.fish;
    };
    starship = {
      enable = true;
      catppuccin.enable = true;
      settings = builtins.fromTOML (builtins.readFile ./xdg/config/starship.toml);
    };
    atuin = {
      enable = true;
    };
    zoxide = {
      enable = true;
    };
    bat = {
      enable = true;
      catppuccin.enable = true;
    };
    lf = {
      enable = true;
      extraConfig = builtins.readFile ./xdg/config/lf/lfrc;
    };
    eza = {
      enable = true;
      icons = true;
      git = true;
    };
    btop = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        vim_keys = true;
      };
    };
    htop = {
      enable = true;
    };
    fzf = {
      enable = true;
      catppuccin.enable = true;
    };
    ripgrep = {
      enable = true;
    };
    jq = {
      enable = true;
    };

    git = {
      enable = true;
      aliases = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
      };
      userEmail = "ofseed@foxmail.com";
      userName = "Yi Ming";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        push = {
          autoSetupRemote = true;
        };
      };
      delta = {
        enable = true;
        catppuccin.enable = true;
        options = {
          syntax-theme = "catppuccin";
        };
      };
    };
    gh = {
      enable = true;
    };
    gh-dash = {
      enable = true;
      catppuccin.enable = true;
    };
    lazygit = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        gui = {
          nerdFontsVersion = "3";
          border = "rounded";
        };
        git = {
          paging = {
            colorArg = "always";
            pager = "delta --dark --paging=never";
          };
        };
        promptToReturnFromSubprocess = false;
      };
    };

    kitty = {
      package = pkgs.nix;
      catppuccin.enable = true;
      enable = true;
      font = {
        name = "Cascadia Code";
      };
      extraConfig = builtins.readFile ./xdg/config/kitty/kitty.conf;
    };
    wezterm = {
      enable = true;
      package = pkgs.nix;
      extraConfig = builtins.readFile ./xdg/config/wezterm/wezterm.lua;
    };
    alacritty = {
      enable = true;
      catppuccin.enable = true;
      package = pkgs.nix;
      settings = builtins.fromTOML (builtins.readFile ./xdg/config/alacritty/alacritty.toml);
    };
  };
}
