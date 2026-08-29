{ videoDrivers, passivate, gitfourchette }:
{ pkgs, ... }:
{
  imports = [
    # move to common
    ./../features/locale.nix
    ./../features/audio.nix
    ./../features/firefox.nix
    ./../features/kde.nix
    ./../features/steam.nix

    # can probably disable?
    (import ./../features/xserver.nix {
      inherit videoDrivers;
    })

    # tobias
    ./../users/tobias_user.nix
    ./../features/disable_sleep.nix
    ./../features/ollama.nix
  ];

  home-manager.users.tobias = import ./../home/tobias_home.nix {
    inherit passivate gitfourchette;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
