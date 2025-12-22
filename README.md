#README

To rebuild NixOS:
- Ensure 'rebuild.sh' is executable (chmod +x rebuild.sh if needed)
- sudo ./rebuild.sh

To deploy homelab:
- sudo nixos-rebuild switch --build-host deploy@192.168.178.30 --target-host deploy@192.168.178.30 --flake path:.#homelab --sudo --ask-sudo-password

nixos-rebuild will ask for a password multiple times:

[sudo] password for tobias@192.168.178.30:
building the system configuration...
(tobias@192.168.178.30) Password:
(tobias@192.168.178.30) Password:
(tobias@192.168.178.30) Password:
tobias@192.168.178.30's password:

The first is the user's (in this case 'tobias') password, as if running sudo on the target machine as that user.
The next 3 are the SSH key password (which may be empty, depending on the key).
The final password is again the user's password, as if running sudo on the target machine as that user.
