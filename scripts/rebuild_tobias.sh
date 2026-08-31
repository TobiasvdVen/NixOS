set -e

rm -f ./hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix ./
git add -f hardware-configuration.nix
nixos-rebuild --flake path:.#tobias-pc dry-activate || true
git rm -f hardware-configuration.nix
