# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
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
    };

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      extraConfig = {
        pipewire = {
          "92-low-latency" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.quantum" = 8192;
              "default.clock.min-quantum" = 8192;
              "default.clock.max-quantum" = 8192;
            };
          };

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
          "92-low-latency" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.quantum" = 8192;
              "default.clock.min-quantum" = 8192;
              "default.clock.max-quantum" = 8192;
            };
          };

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
  };

  hardware = {
    bluetooth = {
      enable = true;
      settings.General.Experimental = false;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tobias = {
    isNormalUser = true;
    description = "Tobias";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pavucontrol
    git
    zed-editor
    util-linux
    linuxKernel.packages.linux_6_12.cpupower
    htop
    gitkraken
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  powerManagement.cpuFreqGovernor = "performance";

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
