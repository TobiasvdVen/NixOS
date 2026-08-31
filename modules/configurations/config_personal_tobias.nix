{
  videoDrivers,
  passivate,
  gitfourchette,
}:
{ pkgs, ... }:
{
  imports = [
    ./../cores/core_personal.nix

    # can probably disable?
    (import ./../features/xserver.nix {
      inherit videoDrivers;
    })

    ./../features/kde.nix
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
