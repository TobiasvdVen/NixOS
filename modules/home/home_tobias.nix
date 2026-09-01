{
  passivate,
  gitfourchette,
  nvf,
}:
{ pkgs, ... }:
let
  neovim = (
    import ./../features/neovim.nix {
      inherit pkgs nvf;
    }
  );
in
{
  home.stateVersion = "25.11";

  home.username = "tobias";
  home.homeDirectory = "/home/tobias";
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
  };

  home.packages = [
    pkgs.zed-editor
    pkgs.discord
    pkgs.signal-desktop
    pkgs.obsidian
    pkgs.keymapp
    pkgs.wezterm
    pkgs.qalculate-qt

    # Linux-compatible way to launch battle.net
    pkgs.faugus-launcher

    passivate
    gitfourchette
    neovim
  ];
}
