{
  flake.nixosModules.xserver = {videoDrivers, ...}: {
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

        inherit videoDrivers;
      };
    };
  };
}
