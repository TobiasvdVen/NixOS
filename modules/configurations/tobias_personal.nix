{ pkgs, ... }:
{
  imports = [
    ./../features/locale.nix
    ./../features/audio.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;


  security.rtkit.enable = true;

  services = {
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    xserver = {
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };

      videoDrivers = [ "amdgpu" ];
    };

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      loadModels = [ "qwen3:14b" ];
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      settings.General.Experimental = false;
    };
  };

  users.users.tobias = {
    isNormalUser = true;
    description = "Tobias";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
  };
  programs.gamemode.enable = true;
  #programs.steam.gamescopeSession.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
    git
    util-linux
    htop
    mangohud
    protonup-ng
    nixd
    protonvpn-gui
    wireguard-tools
    obsidian
    keymapp
    wezterm
  ];

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
