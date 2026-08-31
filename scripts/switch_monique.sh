
set -e

rm -f ./hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix ./
git add -f hardware-configuration.nix
nixos-rebuild --flake path:.#monique-pc switch || true
git rm -f hardware-configuration.nix
