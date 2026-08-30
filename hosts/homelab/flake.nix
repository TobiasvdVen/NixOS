{
  description = "NixOS system configuration for our single-machine homelab.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nil-git.url = "github:oxalica/nil";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nil-git,
      ...
    }:

    let
      system = "x86_64-linux";
      nil = nil-git.packages.${system}.default;

      homelab = import ./../../modules/configurations/homelab.nix;

      stateVersion = {
        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        system.stateVersion = "25.11"; # Did you read the comment?
      };

      modules = [
        homelab
        stateVersion
      ];
    in
    {
      inherit modules;
      networking.hostname = "homelab";
    };
}
