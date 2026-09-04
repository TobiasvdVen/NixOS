{self, ...}: {
  flake.nixosModules.configurations.config-personal-monique = {...}: {
    imports = [
      self.nixosModules.cores.core-personal

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

    home-manager.users.monique = self.homeModules.home-monique;
  };
}
