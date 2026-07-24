{
  description = "Root NixOS flake, which can compose the following distinct configurations: 'personal', ...";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    passivate-git = {
      url = "git+https://github.com/TobiasvdVenOrg/Passivate?ref=main&submodules=1";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, passivate-git, ... }:
    let
      system = "x86_64-linux";
      passivate = passivate-git.packages.${system}.default;

      home_tobias = {
        home-manager.extraSpecialArgs = {
          inherit passivate;
        };

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users.tobias = import ./personal/home_tobias.nix;
      };
    in
    {
      nixosConfigurations.personal = nixpkgs.lib.nixosSystem {
        modules = [
          ./personal.nix
          home-manager.nixosModules.home-manager
          home_tobias
        ];
      };

      nixosConfigurations.homelab = nixpkgs.lib.nixosSystem {
        modules = [
          ./homelab.nix
        ];
      };
    };
}
