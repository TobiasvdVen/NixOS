{ pkgs, ... }:
{
  # Programs provided:
  #   protonvpn-app
  environment.systemPackages = [
    pkgs.protonvpn
  ];
}
