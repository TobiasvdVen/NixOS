{
  description = "Root NixOS flake, which can compose the following distinct configurations: 'personal', ...";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    passivate-git = {
      url = "git+https://github.com/TobiasvdVenOrg/Passivate?ref=main&submodules=1";
    };
    gitfourchette-git = {
      url = "github:TobiasvdVen/gitfourchette-nix?ref=main";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-tools-path.url = "path:./nixos_tools";
    nil-git.url = "github:oxalica/nil";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      passivate-git,
      gitfourchette-git,
      nixos-tools-path,
      nil-git,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      passivate = passivate-git.packages.${system}.default;
      gitfourchette = gitfourchette-git.packages.${system}.default;
      nixos-tools = nixos-tools-path.packages.${system}.default;
      nil = nil-git.packages.${system}.default;

      home_tobias = {
        home-manager.extraSpecialArgs = {
          inherit passivate;
          inherit gitfourchette;
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

      devShells."${system}".default = pkgs.mkShell {
        buildInputs = [
          pkgs.package-version-server
          nixos-tools
          nil
        ];
      };
    };
}
