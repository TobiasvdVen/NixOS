{
  videoDrivers,
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
  ];

  users.users = {
    monique = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
    };
  };

  home-manager.users.monique = import ./../home/home_monique.nix {
    inherit gitfourchette;
  };
}
