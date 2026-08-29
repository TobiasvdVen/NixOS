{ passivate, gitfourchette }:
{ pkgs, ... }:
{
  imports = [
    ./common_home.nix
  ];

  home.username = "tobias";
  home.homeDirectory = "/home/tobias";

  home.packages = [
    pkgs.zed-editor
    pkgs.discord
    pkgs.nmap
    pkgs.net-tools
    pkgs.gittyup
    pkgs.signal-desktop
    pkgs.faugus-launcher
    passivate
    gitfourchette
  ];
}
