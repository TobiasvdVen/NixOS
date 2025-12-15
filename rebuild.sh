set -e

cp /etc/nixos/hardware-configuration.nix .
nixos-rebuild --flake path:.#personal switch
