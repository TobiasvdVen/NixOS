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

    visuals = {
      fidget-nvim.enable = true;
    };
  };
}
