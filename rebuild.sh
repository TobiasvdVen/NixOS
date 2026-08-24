set -e

rm -f ./modules/system/hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix ./modules/system
nixos-rebuild --flake path:.#tobias-pc dry-activate
