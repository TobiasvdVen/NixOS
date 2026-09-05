{self, ...}: {
  flake.nixosModules.config-personal-monique = {...}: {
    imports = [
      (builtins.trace "core-personal:" self.nixosModules.cores.core-personal)

      # can probably disable?
      self.nixosModules.features.xserver
      self.nixosModules.features.kde
    ];

    users.users = {
      monique = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
        ];
      };
    };

    home-manager.users.monique = self.homeModules.home.home-monique;
  };
}
