{self, ...}: {
  flake.nixosModules.configurations.config-personal-tobias = {...}: {
    imports = [
      self.nixosModules.cores.core_personal

      # can probably disable?
      self.nixosModules.features.xserver
      self.nixosModules.features.kde
      self.nixosModules.features.disable-sleep
      self.nixosModules.features.ollama
    ];

    users.users = {
      tobias = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
    };

    home-manager.users.tobias = self.homeModules.home-tobias;
  };
}
