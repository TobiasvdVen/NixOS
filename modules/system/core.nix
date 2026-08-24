{ ... }:
{
  # Expect hardware-configuration.nix to exist in the root of the repo
  # This is currently done by 'rebuild.sh', which copies the /etc/nixos version to its working directory
  imports = [
    ./hardware-configuration.nix
  ];
}
