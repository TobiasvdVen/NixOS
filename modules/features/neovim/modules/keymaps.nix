{...}: {
  config.vim = {
    binds = {
      whichKey = {
        enable = true;
        setupOpts = {
          notify = true;
          triggers = {
          };
        };
      };
    };

    keymaps = [
      # Plugins
      # Open file explorer
      {
        key = "<leader>e";
        mode = "n";
        action = "<cmd>lua MiniFiles.open()<cr>";
        desc = "Files...";
      }
      # Presenterm preview
      {
        key = "<leader>vp";
        mode = "n";
        action = "<cmd>Presenterm preview<cr>";
        desc = "Presenter preview";
      }

      # Save file
      {
        key = "<leader>s";
        mode = "n";
        action = ":update<cr>";
        desc = "Save file";
      }

      # Jump to ...
      # Definition
      {
        key = "<leader>jd";
        mode = "n";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        desc = "Go to definition";
      }

      # References
      {
        key = "<leader>jr";
        mode = "n";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        desc = "Find references";
      }

      # Diagnostics ...
      {
        key = "<leader>dj";
        mode = "n";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        desc = "Show diagnostic error";
      }

      # Log
      # LSP
      {
        key = "<leader>lsp";
        mode = "n";
        action = "<cmd>lua vim.cmd('tabnew ' .. vim.lsp.log.get_filename())<CR>";
        desc = "Show LSP log";
      }
    ];
  };
}
