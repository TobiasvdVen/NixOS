{ config, pkgs, ... }:

{
  home.username = "tobias";
  home.homeDirectory = "/home/tobias";

  home.packages = with pkgs; [
    zed-editor
    discord
    nmap
    net-tools
    gittyup
  ];

  home.stateVersion = "25.11";
}
