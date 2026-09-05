{
  self,
  inputs,
  ...
}: {
  flake.homeModules.home-monique = {pkgs, ...}: {
    home.stateVersion = "25.11";

    home.username = "monique";
    home.homeDirectory = "/home/monique";

    programs.firefox = {
      enable = true;
      configPath = ".mozilla/firefox";
    };

    home.packages = [
      pkgs.discord
      pkgs.signal-desktop
      pkgs.obsidian

      inputs.gitfourchette
    ];
  };
}
