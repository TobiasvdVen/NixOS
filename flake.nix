{
  description = "Development flake for NixOS configuration work, includes a dev shell that installs a nix lsp (nil) and custom NixOS tools (nt)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    nvf.url = "github:notashelf/nvf";
    nvf-fork.url = "github:TobiasvdVen/nvf?ref=presenterm";

    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";
    nixos-tools.url = "path:./nixos_tools";
    nil.url = "github:oxalica/nil";

    passivate.url = "git+https://github.com/TobiasvdVenOrg/Passivate?ref=main&submodules=1";
    gitfourchette.url = "github:TobiasvdVen/gitfourchette-nix?ref=main";
  };

  outputs = inputs: let
    modules = [
      ./modules/configurations/config_homelab.nix
      ./modules/configurations/config_personal_monique.nix
      ./modules/configurations/config_personal_tobias.nix

      ./modules/cores/core_home_manager.nix
      ./modules/cores/core_personal.nix
      ./modules/cores/core_system.nix

      ./modules/home/home_monique.nix
      ./modules/home/home_tobias.nix

      ./modules/hosts/tobias-pc.nix

      ./modules/features/audio.nix
      ./modules/features/disable_sleep.nix
      ./modules/features/kde.nix
      ./modules/features/niri.nix
      ./modules/features/noctalia.nix
      ./modules/features/ollama.nix
      ./modules/features/xserver.nix
      ./modules/features/zsa.nix
      ./modules/features/neovim/neovim.nix
    ];

    output = inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = modules;
    };
  in
    output;
}
