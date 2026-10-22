{pkgs, ...}: {
  config.vim = {
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
  };
}
