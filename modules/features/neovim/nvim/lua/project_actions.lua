local M = {}

--@class ProjectAction
--@field key string
--@field task overseer.TemplateFileDefinition

--@param action_leader string
--@param actions ProjectAction[]
function M.register(action_leader, actions)
        print("IN register project_actions")

        local overseer = require("overseer")

        print("GOT overseer project_actions")

        for _, action in ipairs(actions) do
                print("ACTION " .. action.key)

                overseer.register_template(action.task)

                vim.keymap.set("n", action_leader .. action.key, function()
                        vim.cmd("OverseerRun " .. action.task.name)
                end, {
                        desc = action.task.name,
                })
        end

        print("LEAVE register project_actions")
end

return M
