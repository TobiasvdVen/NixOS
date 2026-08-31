{
  videoDrivers,
  passivate,
  gitfourchette,
}:
{ pkgs, ... }:
{
  imports = [
    # move to common
    ./../features/locale.nix
    ./../features/audio.nix
    ./../features/firefox.nix
    ./../features/kde.nix
    ./../features/steam.nix
    ./../features/bootloader.nix

    # can probably disable?
    (import ./../features/xserver.nix {
      inherit videoDrivers;
    })

    # tobias
    ./../features/disable_sleep.nix
    ./../features/ollama.nix
  ];

  users.users = {
    tobias = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };

  home-manager.users.tobias = import ./../home/tobias_home.nix {
    inherit passivate gitfourchette;
  };

  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
    git
    util-linux
    htop
    mangohud
    protonup-ng
    nixd
    wireguard-tools
    obsidian
    keymapp
    wezterm
  ];
}
