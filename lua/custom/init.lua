-- vim configurations
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set clipboard+=unnamedplus")

vim.opt.colorcolumn = "145"

vim.opt.termguicolors = true
--vim.g.python3_host_prog="/usr/bin/python3"
--vim.g.python3_host_prog=vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
-- vim.g.loaded_remote_plugins = "/home/nirban/.local/share/nvim"


-- Clipboard
-- vim.opt.clipboard = ""
-- local termfeatures = vim.g.termfeatures or {}:q
--
-- termfeatures.osc52 = false
-- vim.g.termfeatures = termfeatures
--
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--   },
-- }
--
vim.g.clipboard = {
    name = "xsel",
    copy = {
        ["+"] = "xsel -ib",
        ["*"] = "xsel -ib"
    },
    paste = {
        ["+"] = "xsel -o",
        ["*"] = "xsel -o"
    },
    cache_enabled = true
}
-- vim.api.nvim_set_option("clipboard", "unnamedplus")

local enable_providers = {
      "python3_provider",
      "node_provider",
      -- and so on
    }
    
    for _, plugin in pairs(enable_providers) do
      vim.g["loaded_" .. plugin] = nil
      vim.cmd("runtime " .. plugin)
    end
