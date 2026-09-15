local project_actions = require("project_actions")

local nix_flake_show = {
        name = "nix_flake_show",
        builder = function(params)
                return {
                        cmd = { "nix", "flake", "show" },
                        name = "nix_flake_show",
                }
        end,
        desc = "nix flake show",
}

local actions = {
        { key = "f", task = nix_flake_show },
}

project_actions.register(actions)
