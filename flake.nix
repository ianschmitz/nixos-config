{
  description = "Ian's cross-os config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Manages configs. Links config files into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ home-manager, darwin, nixpkgs, ... }: {
    darwinConfigurations = {
      ian-macbook-work = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./systems/darwin
          home-manager.darwinModules.home-manager
          {
            users.users.ian.home = "/Users/ian";
            home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { repoPath = "/Users/ian/Code/nix"; };
                users.ian = import ./modules/home-manager;
            };
          }
        ];
      };
    };

    nixosConfigurations = {
      ian-desktop-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./systems/nixos
          ./hosts/nixos/ian-desktop-nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            users.users.ian.home = "/home/ian";
            home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { repoPath = "/home/ian/Code/nix"; };
                users.ian = import ./modules/home-manager;
            };
          }
        ];
      };
    };
  };
}
