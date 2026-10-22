{...}: {
  config.vim = {
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
