
local plugins = {
    {
        "vim-crystal/vim-crystal",
        ft = "crystal",
        config = function ()
            vim.g.crystal_auto_format = 1
        end
    },

    {
        "neovim/nvim-lspconfig",
        config = function ()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
            
        end
    },

    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                    sources = {
                        null_ls.builtins.formatting.stylua,
                        null_ls.builtins.formatting.prettier,
                        null_ls.builtins.diagnostics.erb_lint,
                        null_ls.builtins.diagnostics.rubocop,
                        null_ls.builtins.formatting.rubocop,
                    },
            })
            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
        end,
    },

    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    {
        "williamboman/mason.nvim",
        opts  = {
            ensure_installed = {
                "clangd", 
                "python-lsp-server", 
                "clang-format", 
                "cpptools", 
                "python-lsp-server", 
                "asm-lsp",
                "html-lsp",
                "java",
            }
        },
        config = function()
            require("mason").setup()
        end
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { 
                    "lua_ls", 
                    "tsserver", 
                    "clangd", 
                    "python-lsp-server", 
                    "asm-lsp",
                    "java"
                }
            })
        end
    },

    -- Debugger
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap"
        },
        opts = {
            handlers = {},
            ensure_installed = {
                "cpptools"
            }
        }
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap"
        },
        config = function ()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function ()
                dapui.open()
            end

            dap.listeners.before.event_terminated["dapui_config"] = function ()
                dapui.close()
            end

            dap.listeners.before.event_exited["dapui_config"] = function ()
                dapui.close()
            end


        end
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            require("core.utils").load_mappings("dap")
        end
    },

    -- Transparent NVIM
    {
        "xiyaowong/nvim-transparent",
        config = function ()
            require("transparent").setup({ -- Optional, you don't have to run setup.
                groups = { -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                    'EndOfBuffer',
                },
                extra_groups = {}, -- table: additional groups that should be cleared
                exclude_groups = {}, -- table: groups you don't want to clear
            })
        end
    },

    -- Open AI Chat GPT
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },

    -- Neovim Notify
    {
        "rcarriga/nvim-notify"
    },

    -- Noice Command Pallete
    -- lazy.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
}

return plugins
