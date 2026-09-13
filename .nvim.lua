vim.print("LOADED .nvim.lua")

local project_actions = require("project_actions")

local some_task = {
        name = "Some Task",
        builder = function(params)
                return {
                        cmd = { "echo", "hello", "world" },
                        name = "Greet",
                        components = { "default" },
                }
        end,
        desc = "Optional description of task",
        condition = {
                filetype = { "nix" },
        },
}

local some_task_2 = {
        name = "Some Task 2",
        builder = function(params)
                return {
                        cmd = { "echo", "hello", "world" },
                        name = "Greet2",
                        components = { "default" },
                }
        end,
        desc = "Optional description of task",
        condition = {
                filetype = { "nix" },
        },
}

local action_leader = "<leader>b"

local actions = {
        some_task,
        some_task_2,
}

project_actions.register(action_leader, actions)
