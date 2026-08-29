{ videoDrivers }:
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
    ./../features/disable_sleep.nix
    ./../features/ollama.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  security.rtkit.enable = true;

  users.users.tobias = {
    isNormalUser = true;
    description = "Tobias";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

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
