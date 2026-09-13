print("LOADED .nvim.lua")

local project_actions = require("project_actions")

print("LOADED project_actions")

local some_task = {
        name = "SomeTask",
        builder = function(params)
                return {
                        cmd = { "echo", "hello", "world" },
                        name = "SomeTask",
                        components = { "default" },
                }
        end,
        desc = "Optional description of task",
        condition = {
                filetype = { "nix" },
        },
}

local some_task_2 = {
        name = "SomeTask2",
        builder = function(params)
                return {
                        cmd = { "echo", "hello", "world" },
                        name = "SomeTask2",
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
        { key = "a", task = some_task },
        { key = "b", task = some_task_2 },
}

print("REGISTERING project_actions")

project_actions.register(action_leader, actions)

print("REGISTERED project_actions")
