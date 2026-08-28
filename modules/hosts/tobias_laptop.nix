{ ... }:
{
  networking.hostName = "tobias-laptop";
  imports = [
    ./../configurations/tobias_personal.nix
  ];
}
