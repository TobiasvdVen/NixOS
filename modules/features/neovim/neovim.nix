{inputs, ...}: {
  perSystem = {
    self,
    pkgs,
    ...
  }: {
    packages.neovim =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          (
            {pkgs, ...}: {
              config.vim = {
                theme = {
                  enable = true;
                  name = "tokyonight";
                  style = "moon";
                };

                globals.mapleader = " ";

                options = {
                  exrc = true;
                  secure = true;
                };

                additionalRuntimePaths = [
                  ./nvim
                ];

                extraPlugins = {
                  overseer-nvim = {
                    package = pkgs.vimPlugins.overseer-nvim;
                    setup = ''
                      require('overseer').setup({
                        task_list = {
                                keymaps = {
                                        ["<Esc>"] = {
                                                "<CMD>close<CR>"
                                        },
                                },
                                min_height = 32,
                                max_height = 16384,
                        }
                      })
                    '';
                  };
                };

                keymaps = [
                  # Open file explorer
                  {
                    key = "<leader>e";
                    mode = "n";
                    action = "<cmd>lua MiniFiles.open()<cr>";
                    desc = "Files...";
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

                  # Log
                  # LSP
                  {
                    key = "<leader>lsp";
                    mode = "n";
                    action = "<cmd>lua vim.cmd('tabnew ' .. vim.lsp.log.get_filename())<CR>";
                    desc = "Show LSP log";
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

                visuals = {
                  fidget-nvim.enable = true;
                };
              };
            }
          )
        ];
      }).neovim;
  };
}
