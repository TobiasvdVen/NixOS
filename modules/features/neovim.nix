{
  flake.nixosModules.features.neovim = {
    self,
    inputs,
    pkgs,
    ...
  }: let
    neovim-config = inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [
        (
          {pkgs, ...}: {
            config.vim = {
              globals.mapleader = " ";

              keymaps = [
                {
                  key = "<leader>e";
                  mode = "n";
                  action = "<cmd>lua MiniFiles.open()<cr>";
                  desc = "Files...";
                }
                {
                  key = "<leader>s";
                  mode = "n";
                  action = ":update<cr>";
                  desc = "Save file";
                }
              ];

              lsp = {
                enable = true;

                formatOnSave = true;
              };

              binds = {
                whichKey = {
                  enable = true;
                  setupOpts = {
                    notify = true;
                  };
                };
              };

              languages = {
                enableFormat = true;
                enableTreesitter = true;
                enableExtraDiagnostics = true;

                nix.enable = true;
                markdown.enable = true;
                rust = {
                  enable = true;
                  extensions.crates-nvim.enable = true;
                };
                toml.enable = true;
                csharp.enable = true;
                lua.enable = true;
              };

              autocomplete = {
                blink-cmp.enable = true;
              };

              telescope.enable = true;
              mini.files = {
                enable = true;
                setupOpts = {
                  mappings = {
                    close = "<Esc>";
                  };
                };
              };
            };
          }
        )
      ];
    };
  in
    neovim-config.neovim;
}
