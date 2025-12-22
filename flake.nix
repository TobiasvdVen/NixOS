{
  description = "Root NixOS flake, which can compose the following distinct configurations: 'personal', ...";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.personal = nixpkgs.lib.nixosSystem {
      modules = [
        ./personal.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.tobias = import ./personal/home_tobias.nix;
        }
      ];
    };

    nixosConfigurations.homelab = nixpkgs.lib.nixosSystem {
      modules = [
        ./homelab.nix
      ];
    };
  };
}
