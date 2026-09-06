{...}: {
  flake.nixosModules.zsa = {
    services.udev.extraRules = ''
      ATTRS{idVendor}=="3297", TAG+="uaccess"
    '';
  };
}
