{
  description = "NixOS system configuration for tobias-pc";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    passivate-git.url = "git+https://github.com/TobiasvdVenOrg/Passivate?ref=main&submodules=1";
    gitfourchette-git.url = "github:TobiasvdVen/gitfourchette-nix?ref=main";
    nil-git.url = "github:oxalica/nil";
  };

  outputs =
    {
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

      config-tobias_personal = import ./../../modules/configurations/config_personal_tobias.nix {
        videoDrivers = [ "amdgpu" ];
        inherit passivate gitfourchette;
      };

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
        config-tobias_personal
        stateVersion
      ];
    in
    {
      inherit modules;
      networking.hostname = "tobias-pc";
    };
}
