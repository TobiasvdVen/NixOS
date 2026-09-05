{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.tobias-pc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.host-tobias-pc
      ./../../hardware-configuration.nix
    ];
  };

  flake.nixosModules.host-tobias-pc = {pkgs, ...}: {
    imports = [
      self.nixosModules.config-personal-tobias
    ];

    networking.hostName = "tobias-pc";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
