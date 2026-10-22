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
        #package = pkgs.vimPlugins.overseer-nvim;
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

    telescope.enable = true;
    mini.files = {
      enable = true;
      setupOpts = {
        mappings = {
          close = "<Esc>";
        };
      };
    };

    presenterm = {
      enable = true;
      setupOpts = {
        preview = {
          presentation_preview_sync = true;
        };
      };
    };

    visuals = {
      fidget-nvim.enable = true;
    };

    assistant.codecompanion-nvim = {
      enable = true;

      setupOpts = {
        interactions = {
          chat = {
            adapter = {
              name = "ollama";
              model = "qwen3:14b";
            };

            tools = {
              web_search = {
                opts = {
                  adapter = "duckduckgo";
                };
              };
            };
          };

          inline.adapter = {
            name = "ollama";
            model = "qwen3:14b";
          };
        };
      };
    };
    #assistant.avante-nvim = {
    #  enable = true;
    #  setupOpts = {
    #    provider = "ollama";
    #    providers = {
    #      ollama = {
    #        endpoint = "http://127.0.0.1:11434";
    #        timeout = 8192; # milliseconds
    #      };
    #    };

    #    auto_suggestions_provider = "ollama";
    #  };
    #};
  };
}
