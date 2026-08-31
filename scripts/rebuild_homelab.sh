set -e

rm -f ./hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix ./
git add -f hardware-configuration.nix
nixos-rebuild --flake path:.#homelab dry-activate || true
git rm -f hardware-configuration.nix
