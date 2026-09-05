{
  flake.nixosModules.audio = {...}: {
    services = {
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
              "bluez5.roles" = [
                "a2dp_sink"
                "a2dp_source"
                "ldac"
              ];
              "bluez5.codecs" = ["ldac"];
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
  };
}
