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
        ./modules/core.nix

        ./modules/keymaps.nix
        ./modules/overseer.nix
        ./modules/theme.nix
        ./modules/assistant.nix
        ./modules/lsp.nix
        ./modules/presenterm.nix
      ];
    };
  in {
    packages.neovim = neovim_configuration.neovim;
  };
}
