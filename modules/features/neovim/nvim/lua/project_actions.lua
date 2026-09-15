local M = {}

--@class ProjectAction
--@field key string
--@field task overseer.TemplateFileDefinition

--@param action_leader string
--@param actions ProjectAction[]
function M.register(actions)
        local overseer = require("overseer")

        local action_leader = "<leader>b"
        local background_action_leader = "<leader>bb"

        for _, action in ipairs(actions) do
                overseer.register_template(action.task)

                vim.keymap.set("n", action_leader .. action.key, function()
                        vim.cmd("OverseerRun " .. action.task.name)
                        vim.cmd("OverseerToggle")
                end, {
                        desc = action.task.name,
                })

                vim.keymap.set("n", background_action_leader .. action.key, function()
                        vim.cmd("OverseerRun " .. action.task.name)
                end, {
                        desc = action.task.name,
                })
        end
end

return M
