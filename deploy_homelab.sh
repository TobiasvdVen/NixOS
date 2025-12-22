set -e

rm ./hardware-configuration.nix
scp "deploy@192.168.178.30:/etc/nixos/hardware-configuration.nix" .
nixos-rebuild switch --build-host deploy@192.168.178.30 --target-host deploy@192.168.178.30 --flake path:.#homelab --sudo --ask-sudo-password
