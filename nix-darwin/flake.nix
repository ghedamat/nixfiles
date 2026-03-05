{
  description = "Ghedamat's nix-darwin system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }: {
    darwinConfigurations."thaair" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./darwin-configuration.nix
        home-manager.darwinModules.home-manager
        {
          nixpkgs.config.allowUnfree = true;

          users.users.ghedamat = {
            name = "ghedamat";
            home = "/Users/ghedamat";
          };

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.ghedamat = import ./../nixpkgs/home.nix;
          };
        }
      ];
    };
  };
}
