{ pkgs, passivate, gitfourchette, ... }:

{
  home.username = "tobias";
  home.homeDirectory = "/home/tobias";

  home.packages = with pkgs; [
    zed-editor
    discord
    nmap
    net-tools
    gittyup
    signal-desktop
    faugus-launcher
    passivate
    gitfourchette
  ];

  home.stateVersion = "25.11";
}
