
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

M.dap_python = {
    plugin = true,
    n = {
        ["<leader>dpr"] = {
            function ()
                require('dap-python').test_method()
            end
        }
    }
}

M.copilot = {
  i = {
    ["<C-l>"] = {
      function()
        vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
      end,
      "Copilot Accept",
      {replace_keycodes = true, nowait=true, silent=true, expr=true, noremap=true}
    }
  }
}

M.molten = {
    n = {
        ["<leader>me"] = { "<cmd>MoltenEvaluateOperator<CR>", "Evaluate Operator"},
        ["<leader>mos"] = {"<cmd>noautocmd MoltenEnterOutput<CR>", "Open Output Window"},
        ["<leader>rr"] = {"<cmd>MoltenReevaluateCell<CR>", "Reevaluate Cell"},
        ["<leader>oh"] = {"<cmd>MoltenHideOutput<CR>", "Close output Window"},
        ["<leader>md"] = {"<cmd>MoltenDelete<CR>", "Delete Molten Cell"},
        ["<leader>mx"] = {"<cmd>MoltenOpenInBrowser<CR>", "Open in Browser"},
        ["<leader>ml"] = {"<cmd>MoltenEvaluateLine<CR>", "Evaluate Line"},
    },

    v = {
        ["leader>mvr"] = {"<cmd><C-u>MoltenEvaluateVisual<CR>gv", "Execute Visial Selection"},
    }
}
return M
