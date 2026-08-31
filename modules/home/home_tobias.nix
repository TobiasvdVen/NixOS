{ passivate, gitfourchette }:
{ pkgs, ... }:
{
  home.stateVersion = "25.11";

  home.username = "tobias";
  home.homeDirectory = "/home/tobias";

  programs.firefox.enable = true;

  home.packages = [
    pkgs.zed-editor
    pkgs.discord
    pkgs.signal-desktop
    pkgs.obsidian
    pkgs.keymapp
    pkgs.wezterm

    # Linux-compatible way to launch battle.net
    pkgs.faugus-launcher

    passivate
    gitfourchette
  ];
}
