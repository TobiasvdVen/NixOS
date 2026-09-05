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
    import-tree.url = "github:vic/import-tree";

    nvf.url = "github:notashelf/nvf";
    nixos-tools.url = "path:./nixos_tools";
    nil.url = "github:oxalica/nil";

    passivate.url = "git+https://github.com/TobiasvdVenOrg/Passivate?ref=main&submodules=1";
    gitfourchette.url = "github:TobiasvdVen/gitfourchette-nix?ref=main";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
