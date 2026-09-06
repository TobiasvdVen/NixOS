{self, ...}: {
  flake.nixosModules.config-personal-tobias = {...}: {
    imports = [
      self.nixosModules.core-personal

      # Ensure apps like keymapp have access to ZSA devices
      self.nixosModules.zsa

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
