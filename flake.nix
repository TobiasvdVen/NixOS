{
  description = "Development flake for NixOS configuration work, includes a dev shell that installs a nix lsp (nil) and custom NixOS tools (nt)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-tools-path.url = "path:./nixos_tools";
    nil-git.url = "github:oxalica/nil";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tobias-pc.url = "path:./hosts/tobias-pc";
    homelab.url = "path:./hosts/homelab";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        imports = [

        ];

        flake =
          let
            prepareNixosSystem =
              system:
              inputs.nixpkgs.lib.nixosSystem {
                modules = system.modules ++ [
                  ./hardware-configuration.nix
                  inputs.home-manager.nixosModules.home-manager
                  {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                  }
                  {
                    nixpkgs.config.allowUnfree = true;
                    nix.settings.experimental-features = [
                      "nix-command"
                      "flakes"
                    ];
                  }
                ];
              };
          in
          {
            nixosConfigurations.tobias-pc = prepareNixosSystem inputs.tobias-pc;
            nixosConfigurations.homelab = prepareNixosSystem inputs.homelab;
          };

        systems = [
          "x86_64-linux"
        ];

        perSystem =
          {
            config,
            pkgs,
            inputs',
            ...
          }:
          {
            devShells.default = pkgs.mkShell {
              buildInputs = [
                pkgs.package-version-server
                inputs'.nixos-tools-path.packages.nt
                inputs'.nixos-tools-path.packages.nixos_tools
                inputs'.nil-git.packages.nil
              ];
            };
          };
      }
    );
}
