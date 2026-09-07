{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];

    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };

    programs.noctalia-greeter = {
      enable = true;

      settings = {
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 24;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
        keyboard = {
          layout = "us";
        };
      };
    };
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.noctalia)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us";

        layout.gaps = 4;

        binds = {
          "Mod+N".spawn-sh = lib.getExe pkgs.ghostty;
          "Mod+Esc".close-window = _: {};
          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call launcher toggle";
          "Mod+H".focus-column-left = {};
          "Mod+L".focus-column-right = {};
          "Mod+J".focus-workspace-down = {};
          "Mod+K".focus-workspace-up = {};
        };

        window-rule = {
          open-maximized = true;
        };
      };
    };
  };
}
