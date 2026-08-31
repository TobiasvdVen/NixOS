{
  description = "NixOS system configuration for monique-pc";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    gitfourchette-git.url = "github:TobiasvdVen/gitfourchette-nix?ref=main";
    nixos_tools-path.url = "path:./../../nixos_tools";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      gitfourchette-git,
      nixos_tools-path,
      ...
    }:

    let
      system = "x86_64-linux";
      gitfourchette = gitfourchette-git.packages.${system}.default;
      nixos_tools = nixos_tools-path.packages.${system}.nixos_tools;

      config-personal-monique = import ./../../modules/configurations/config_personal_monique.nix {
        videoDrivers = [ "nvidia" ];
        inherit gitfourchette nixos_tools;
      };

      nvidia = {
        hardware = {
          graphics.enable = true;
          nvidia.open = true;
        };
      };

      stateVersion = {
        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        system.stateVersion = "26.05"; # Did you read the comment?
      };

      modules = [
        config-personal-monique
        nvidia
        stateVersion
      ];
    in
    {
      inherit modules;
      networking.hostname = "tobias-pc";
    };
}
