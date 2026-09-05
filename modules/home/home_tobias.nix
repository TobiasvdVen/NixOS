{
  self,
  inputs,
  ...
}: {
  flake.homeModules.home-tobias = {pkgs, ...}: {
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

      inputs.passivate.packages.${pkgs.system}.default
      inputs.gitfourchette.packages.${pkgs.system}.default
      self.packages.${pkgs.system}.neovim
    ];
  };
}
