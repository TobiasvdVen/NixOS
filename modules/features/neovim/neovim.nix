{inputs, ...}: {
  perSystem = {
    self,
    pkgs,
    ...
  }: let
    unstable = import inputs.unstable {
      system = pkgs.system;
    };

    neovim_configuration = inputs.nvf-fork.lib.neovimConfiguration {
      pkgs = unstable;
      modules = [
        ./../../../neovim_modules/keymaps.nix
      ];
    };
  in {
    packages.neovim = neovim_configuration.neovim;
  };
}
