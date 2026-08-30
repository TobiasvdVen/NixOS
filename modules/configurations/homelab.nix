{ config, pkgs, ... }:
{
  imports = [
    # move to common
    ./../features/locale.nix
    ./../features/disable_sleep.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.firewall = {
    allowedTCPPorts = [
      443
      8080
      53
    ];
    allowedUDPPorts = [ 53 ];
  };

  users = {
    users = {
      deploy = {
        isNormalUser = true;
        description = "deploy";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      "deploy".openssh.authorizedKeys = {
        keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtWJ9NiZtyPKlI4leGCTy9c4ytLhoXANjW65tmV63Bn tobiasvdven@hotmail.com"
        ];

        keyFiles = [
          ./homelab/authorized_keys
        ];
      };
    };
  };

  services.openssh = {
    enable = true;
  };

  services.pihole-ftl = {
    enable = true;
    settings = {
      dns = {
        upstreams = [
          "9.9.9.9"
          "1.1.1.1"
        ];

        hosts = [
          "192.168.178.30 homelab"
          "192.168.178.30 pihole.homelab"
          "192.168.178.30 hydra.homelab"
          "192.168.178.30 gitea.homelab"
        ];
      };
    };
  };

  services.pihole-web = {
    enable = true;
    ports = [ "4040" ];
  };

  services.hydra = {
    enable = true;
    hydraURL = "http://127.0.0.1:3000";
    notificationSender = "tobiasvdven@proton.me";
    useSubstitutes = true;
  };

  services.gitea = {
    enable = true;
    database.type = "sqlite3";
    settings.server.HTTP_PORT = 5050;
  };

  services.traefik = {
    enable = true;
    staticConfigOptions = {
      entryPoints = {
        web = {
          address = ":80";
          asDefault = true;
          http.redirections.entrypoint = {
            to = "websecure";
            scheme = "https";
          };
        };

        websecure = {
          address = ":443";
          asDefault = true;
          http.tls.certResolver = "letsencrypt";
        };
      };

      log = {
        level = "INFO";
        filePath = "${config.services.traefik.dataDir}/traefik.log";
        format = "json";
      };

      certificatesResolvers.letsencrypt.acme = {
        email = "example@tvdven.xyz";
        storage = "${config.services.traefik.dataDir}/acme.json";
        httpChallenge.entryPoint = "web";
      };

      api.dashboard = true;
      # Access the Traefik dashboard on <Traefik IP>:8080 of your server
      api.insecure = true;
    };

    dynamicConfigOptions = {
      http = {
        routers = {
          pihole-web = {
            entryPoints = [ "websecure" ];
            service = "pihole-web";
            rule = "Host(`pihole.homelab`)";
            tls.certResolver = "letsencrypt";
          };

          hydra = {
            entryPoints = [ "websecure" ];
            service = "hydra";
            rule = "Host(`hydra.homelab`)";
            tls.certResolver = "letsencrypt";
          };

          gitea = {
            entryPoints = [ "websecure" ];
            service = "gitea";
            rule = "Host(`gitea.homelab`)";
            tls.certResolver = "letsencrypt";
          };
        };

        services = {
          pihole-web = {
            loadBalancer = {
              servers = [
                { url = "http://127.0.0.1:4040"; }
              ];
            };
          };

          hydra = {
            loadBalancer = {
              servers = [
                { url = "http://127.0.0.1:3000"; }
              ];
            };
          };

          gitea = {
            loadBalancer = {
              servers = [
                { url = "http://127.0.0.1:5050"; }
              ];
            };
          };
        };
      };
    };
  };

  # services.fail2ban.enable = true;

  environment.systemPackages = [
    pkgs.htop
  ];
}
