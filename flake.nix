{
  description = "Development flake for NixOS configuration work, includes a dev shell that installs a nix lsp (nil) and custom NixOS tools (nt)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-tools-path.url = "path:./nixos_tools";
    nil-git.url = "github:oxalica/nil";
    tobias-pc.url = "path:./tobias-pc";
  };

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { inherit system; };
      nixos-tools = inputs.nixos-tools-path.packages.${system}.default;
      nil = inputs.nil-git.packages.${system}.default;
    in
    {
      nixosConfigurations.tobias-pc = inputs.tobias-pc;

      devShells."${system}".default = pkgs.mkShell {
        buildInputs = [
          pkgs.package-version-server
          nixos-tools
          nil
        ];
      };
    };
}
