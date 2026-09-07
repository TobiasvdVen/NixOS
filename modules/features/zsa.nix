{...}: {
  flake.nixosModules.zsa = {
    services.udev.extraRules = ''
      # ZSA keyboards — normal mode (USB + HID)
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", MODE:="0666"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3297", MODE:="0666"
    '';
  };
}
