{ config, pkgs, ... }:

{
  home.username = "tobias";
  home.homeDirectory = "/home/tobias";

  home.packages = with pkgs; [
    zed-editor
  ];

  home.stateVersion = "25.11";
}
