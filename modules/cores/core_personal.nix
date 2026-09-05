{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.core-personal = {pkgs, ...}: {
    imports = [
      self.nixosModules.core-system
      self.nixosModules.core-home-manager
      self.nixosModules.audio
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

      inputs.nixos-tools.packages.${pkgs.system}.nixos_tools
    ];
  };
}
