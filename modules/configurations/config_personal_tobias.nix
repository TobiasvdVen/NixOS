{self, ...}: {
  flake.nixosModules.config-personal-tobias = {...}: {
    imports = [
      (builtins.trace "core_personal:" self.nixosModules.core-personal)

      # can probably disable?
      self.nixosModules.xserver
      self.nixosModules.kde
      self.nixosModules.disable-sleep
      self.nixosModules.ollama
    ];

    users.users = builtins.trace "users.tobias: " {
      tobias = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
    };

    home-manager.users.tobias = builtins.trace "home tobias: " self.homeModules.home-tobias;
  };
}
