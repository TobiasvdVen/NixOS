{
  flake.nixosModules.kde = {...}: {
    services = {
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}
