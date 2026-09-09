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
          "Mod+Escape".close-window = _: {};
          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call launcher toggle";

          "Mod+1".toggle-overview = {};

          "Mod+H".focus-column-left = {};
          "Mod+L".focus-column-right = {};
          "Mod+J".focus-workspace-down = {};
          "Mod+K".focus-workspace-up = {};

          "Mod+Ctrl+H".focus-monitor-left = {};
          "Mod+Ctrl+L".focus-monitor-right = {};
          "Mod+Ctrl+J".focus-workspace-down = {};
          "Mod+Ctrl+K".focus-workspace-up = {};

          "Mod+Alt+H".move-column-left-or-to-monitor-left = {};
          "Mod+Alt+L".move-column-right-or-to-monitor-right = {};
          "Mod+Alt+J".move-window-down-or-to-workspace-down = {};
          "Mod+Alt+K".move-window-up-or-to-workspace-up = {};
        };

        window-rule = {
          open-maximized = true;
        };
      };
    };
  };
}
