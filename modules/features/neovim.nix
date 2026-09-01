{ pkgs, nvf }:
let
  neovim-config = nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [
      (
        { pkgs, ... }:
        {
          config.vim = {
            lsp = {
              enable = true;

              formatOnSave = true;
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

            mini = {
              files.enable = true;
            };
          };
        }
      )
    ];
  };
in
neovim-config.neovim
