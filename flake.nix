{
  description = "Development flake for NixOS configuration work, includes a dev shell that installs a nix lsp (nil) and custom NixOS tools (nt)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    nvf.url = "github:notashelf/nvf";
    nixos-tools-path.url = "path:./nixos_tools";
    nil-git.url = "github:oxalica/nil";

    passivate-git.url = "git+https://github.com/TobiasvdVenOrg/Passivate?ref=main&submodules=1";
    gitfourchette-git.url = "github:TobiasvdVen/gitfourchette-nix?ref=main";
  };

  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;
    inherit (lib.fileset) toList fileFilter;

    isNixModule = file:
      file.hasExt "nix" && file.name != "flake.nix";

    importTree = path: toList (fileFilter isNixModule path);

    mkFlake = inputs.flake-parts.lib.mkFlake {inherit inputs;};
  in
    mkFlake {imports = importTree ./.;};
}
