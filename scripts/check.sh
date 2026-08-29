set -e

rm -f ./hardware-configuration.nix
cp /etc/nixos/hardware-configuration.nix ./
git add -f hardware-configuration.nix
nix flake check || true
git rm -f hardware-configuration.nix
