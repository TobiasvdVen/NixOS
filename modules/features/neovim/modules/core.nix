{...}: {
  config.vim = {
    globals.mapleader = " ";

    options = {
      exrc = true;
      secure = true;
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

    git.neogit = {
      enable = true;
    };

    visuals = {
      fidget-nvim.enable = true;
    };
  };
}
