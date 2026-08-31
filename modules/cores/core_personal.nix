{ nixos_tools }:
{ pkgs, ... }:
{
  imports = [
    ./core_system.nix
    ./../features/audio.nix
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

    nixos_tools
  ];
}
