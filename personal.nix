{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "personal";
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

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

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      extraConfig = {
        pipewire = {
          rtconfig = {
            "context.modules" = [
              {
                name = "libpipewire-module-rt";
                args = {
                  # Real-time priority (1-99, higher = more priority)
                  "rt.prio" = 88;

                  # Nice level for non-RT threads (-20 to 19, lower = higher priority)
                  "nice.level" = -11;

                  # RT time limits as fraction of period (alternative to above)
                  "rt.time.soft" = -1; # Unlimited
                  "rt.time.hard" = -1; # Unlimited

                  # Use rtkit for acquiring RT privileges
                  "uclamp.min" = 0;
                  "uclamp.max" = 1024;
                };
                flags = [
                  "ifexists"
                  "nofail"
                ];
              }
            ];
          };
        };

        pipewire-pulse = {
          rtconfig = {
            "context.modules" = [
              {
                name = "libpipewire-module-rt";
                args = {
                  # Real-time priority (1-99, higher = more priority)
                  "rt.prio" = 88;

                  # Nice level for non-RT threads (-20 to 19, lower = higher priority)
                  "nice.level" = -11;

                  # RT time limits as fraction of period (alternative to above)
                  "rt.time.soft" = -1; # Unlimited
                  "rt.time.hard" = -1; # Unlimited

                  # Use rtkit for acquiring RT privileges
                  "uclamp.min" = 0;
                  "uclamp.max" = 1024;
                };
                flags = [
                  "ifexists"
                  "nofail"
                ];
              }
            ];
          };
        };
      };

      wireplumber = {
        enable = true;

        extraConfig.bluetoothEnhancements = {
          "monitor.bluez.properties" = {
              "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "ldac" ];
              "bluez5.codecs" = [ "ldac" ];
              "bluez5.a2dp.ldac.quality" = "mq";
          };
        };
      };
    };

    blueman.enable = false;

    ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      loadModels = [ "qwen3:14b" ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
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
    extraGroups = [ "networkmanager" "wheel" ];
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
