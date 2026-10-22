{...}: {
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

      csharp = {
        enable = true;

        lsp = {
          enable = true;
        };

        format = {
          enable = true;
          type = ["csharpier"];
        };
      };

      lua.enable = true;
    };

    autocomplete = {
      blink-cmp.enable = true;
    };
  };
}
