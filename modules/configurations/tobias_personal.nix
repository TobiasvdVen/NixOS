{ pkgs, ... }:
{
  imports = [
    # move to common
    ./../features/locale.nix
    ./../features/audio.nix
    ./../features/firefox.nix
    ./../features/kde.nix

    # can probably disable?
    ./../features/xserver.nix

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

  programs.steam = {
    enable = true;
  };
  programs.gamemode.enable = true;
  #programs.steam.gamescopeSession.enable = true;

  nixpkgs.config.allowUnfree = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
