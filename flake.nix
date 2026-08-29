{
  description = "Development flake for NixOS configuration work, includes a dev shell that installs a nix lsp (nil) and custom NixOS tools (nt)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-tools-path.url = "path:./nixos_tools";
    nil-git.url = "github:oxalica/nil";
    tobias-pc.url = "path:./tobias-pc";
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

        flake = {
            nixosConfigurations = {
              tobias-pc = inputs.nixpkgs.lib.nixosSystem {
                modules = inputs.tobias-pc.modules ++ [
                  ./hardware-configuration.nix
                ];
              };
            };

            packages = {
              nil = inputs.nil-git;
            };
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
