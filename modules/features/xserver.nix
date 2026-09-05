{
  flake.nixosModules.xserver = {
    config,
    lib,
    ...
  }: {
    options.xserver.videoDrivers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };

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

        videoDrivers = config.xserver.videoDrivers;
      };
    };
  };
}
