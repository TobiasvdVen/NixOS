local M = {}

--@class ProjectAction
--@field key string
--@field task overseer.TemplateFileDefinition

--@param action_leader string
--@param actions ProjectAction[]
function M.register(action_leader, actions)
        local overseer = require("overseer")

        for _, action in ipairs(actions) do
                overseer.register_template(action.task)

                vim.keymap.set("n", action_leader .. action.key, function()
                        vim.cmd("OverseerRun " .. action.task.name)
                end, {
                        desc = action.task.name,
                })
        end
end

return M
