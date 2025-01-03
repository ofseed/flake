{
  description = "Flake of ofseed";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-index-database,
      catppuccin,
      ...
    }@attrs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      homeManagerModules = [
        ./home.nix
        nix-index-database.hmModules.nix-index
        catppuccin.homeManagerModules.catppuccin
      ];
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs;
          modules = [
            ./os.nix
            ./configuration.nix
            (import ./overlays)
            home-manager.nixosModules.home-manager
            {
              home-manager.users.ofseed = {
                imports = homeManagerModules;
              };
            }
          ];
        };
        nixos-wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs;
          modules = [
            ./wsl.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.ofseed = {
                imports = homeManagerModules;
              };
            }
          ];
        };
      };
      homeConfigurations.ofseed = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = homeManagerModules;
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
