{
  flake.nixosModules.xserver = {
    config,
    lib,
    ...
  }: {
    options.raspberry-path.xserver.videoDrivers = lib.mkOption {
      type = lib.types.nullOr (lib.types.listOf lib.types.str);
      default = null;
    };

    config.assertions = [
      {
        assertion = config.raspberry-path.xserver.videoDrivers != null;
        message = "nixosModules.xserver is evaluated, but 'xserver.videoDrivers' option is not set";
      }
    ];

    config.services = {
      # Enable the X11 windowing system.
      # You can disable this if you're only using the Wayland session.
      xserver = {
        enable = true;

        # Configure keymap in X11
        xkb = {
          layout = "us";
          variant = "";
        };

        videoDrivers = lib.mkIf (config.raspberry-path.xserver.videoDrivers != null) config.raspberry-path.xserver.videoDrivers;
      };
    };
  };
}
