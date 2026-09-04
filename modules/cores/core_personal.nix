{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.cores.core-personal = {pkgs, ...}: {
    imports = [
      self.nixosModules.cores.core-system
      self.nixosModules.cores.home-manager
      self.nixosModules.features.audio
    ];

    programs.steam = {
      enable = true;
    };
    programs.gamemode.enable = true;

    programs.firefox.enable = true;

    environment.systemPackages = [
      pkgs.proton-vpn

      # For managing specific Proton versions for gaming with Steam
      pkgs.protonup-ng

      inputs.nixos_tools
    ];
  };
}
