{ ... }:
{
  networking.hostName = "tobias-pc";
  imports = [
    ./../configurations/tobias_personal.nix
  ];
}
