{self, ...}: {
  flake.nixosModules.config-personal-tobias = {...}: {
    imports = [
      self.nixosModules.core-personal

      self.nixosModules.niri
      self.nixosModules.ollama
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
