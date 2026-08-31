{
  videoDrivers,
  passivate,
  gitfourchette,
  nixos_tools,
}:
{ pkgs, ... }:
{
  imports = [
    (import ./../cores/core_personal.nix {
      inherit nixos_tools;
    })

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

  home-manager.users = {
    tobias = import ./../home/home_tobias.nix {
      inherit passivate gitfourchette;
    };
  };
}
