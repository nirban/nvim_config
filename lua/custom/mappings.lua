
local M = {}

M.dap = {
    plugin = true,
    n = {
        ["<leader>db"] = {
            "<cmd> DapToggleBreakpoint <CR>",
            "Add breakpoint at Line",
        },
            
        ["<leader>dr"] = {
            "<cmd> DapContinue <CR>",
            "Start or Continue the Debugger"
        },

        -- ["F1"] = {},
        -- ["F2"] = {},
        -- ["F3"] = {},
        -- ["F4"] = {},
        -- ["F5"] = {},
        -- ["F8"] = {},
    }
}

return M
