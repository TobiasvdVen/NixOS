{
  description = "NixOS system configuration for tobias-pc";

  inputs = {
    modules = {
      url = ../modules;
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    passivate-git.url = "git+https://github.com/TobiasvdVenOrg/Passivate?ref=main&submodules=1";
    gitfourchette-git.url = "github:TobiasvdVen/gitfourchette-nix?ref=main";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil-git.url = "github:oxalica/nil";
  };

  outputs =
    {
      modules,
      nixpkgs,
      home-manager,
      passivate-git,
      gitfourchette-git,
      nil-git,
      ...
    }:

    let
      system = "x86_64-linux";
      passivate = passivate-git.packages.${system}.default;
      gitfourchette = gitfourchette-git.packages.${system}.default;
      nil = nil-git.packages.${system}.default;

      home_tobias = {
        home-manager.extraSpecialArgs = {
          inherit passivate;
          inherit gitfourchette;
          inherit nil;
        };

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users.tobias = import ./home_tobias.nix;
      };

        bla = [
                "${modules}/hosts/tobias_pc.nix"
                home-manager.nixosModules.home-manager
                home_tobias
              ];
    in
    {
      inherit bla;
    };
}
