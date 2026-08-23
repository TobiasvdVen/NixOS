set -e

rm ./hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix .
nixos-rebuild --flake path:.#personal dry-activate
