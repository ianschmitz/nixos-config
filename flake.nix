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

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: {
    darwinConfigurations."ian-macbook-work" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./systems/darwin
          home-manager.darwinModules.home-manager
          {
            users.users.ian.home = "/Users/ian";
            home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ian = import ./modules/home-manager;
            };

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
    };
  };
}
