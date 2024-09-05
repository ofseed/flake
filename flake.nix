{
  description = "Flake of ofseed";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }@attrs:
    let
      system = "x86_64-linux";
      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      homeManagerModules = [
        ./home.nix
        catppuccin.homeManagerModules.catppuccin
      ];
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.ofseed = {
              imports = homeManagerModules;
            };
          }
        ];
      };
      homeConfigurations.ofseed = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = homeManagerModules;
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
