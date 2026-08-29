set -e

rm -f ./hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix ./
nixos-rebuild --flake path:.#tobias-pc dry-activate
