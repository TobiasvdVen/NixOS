local M = {}

--@class ProjectAction
--@field key string
--@field action overseer.TaskDefinition

--@param action_leader string
--@param actions ProjectAction[]
function M.register(action_leader, actions)
        local overseer = require("overseer")

        for action in actions do
                vim.keymap.set("n", action_leader .. action.key, function()
                        overseer.new_task(action):start()
                end, {
                        desc = "What is this?",
                })
        end
end

return M
