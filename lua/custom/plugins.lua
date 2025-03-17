
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
        --"hrsh7th/cmp-cmdline",
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
        "jose-elias-alvarez/null-ls.nvim",
        ft = {"python"},
        opts = function()
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
                ---"python-lsp-server",
                "clang-format",
                "cpptools",
                ---"python-lsp-server",
                "asm-lsp",
                "html-lsp",
                "java",
                "pyright",
                "mypy",
                "ruff",
                "black",
                "debugpy",
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

    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function(_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end,
    },

    -- Transparent NVIM
    {
        "xiyaowong/nvim-transparent",
        -- event = "VeryLazy",
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

    -- Github Copilot
    {
        "github/copilot.vim",
        lazy = false,
        config = function()
            -- Mapping tab is already used by NvChad
            vim.g.copilot_no_tab_map = true;
            vim.g.copilot_assume_mapped = true;
            vim.g.copilot_tab_fallback = "";
            -- The mapping is set to other key, see custom/lua/mappings
            -- or run <leader>ch to see copilot mapping section
        end
    },

    -- Git Hub Copilot chat 
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = "VeryLazy",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
            -- See Commands section for default commands if you want to lazy load on them
        
    },

    -- Open AI Chat GPT
    --{
    --    "jackMort/ChatGPT.nvim",
    --    event = "VeryLazy",
    --    config = function()
    --        require("chatgpt").setup()
    --    end,
    --    dependencies = {
    --        "MunifTanjim/nui.nvim",
    --        "nvim-lua/plenary.nvim",
    --        "folke/trouble.nvim",
    --        "nvim-telescope/telescope.nvim"
    --    }
    --},

    -- Neovim Notify
    {
     --   "rcarriga/nvim-notify"
    },

    -- Noice Command Pallete
    -- lazy.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
            routes = {
                {
                    filter = {
                        event = "notify",
                        find = "No information available"
                    },
                    opts = {
                        skip = true
                    },
                },
            },
            presets = {
                lsp_doc_border = true,
            },
        },

        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        --config = function()
        --    require "custom.configs.noice"
        --end,
    },

    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require "custom.configd.telescope_ui_select"
        end,
    },

    -- Render Markdown
    {
        'MeanderingProgrammer/render-markdown.nvim',
        event = "VeryLazy",
        dependencies = { 
            'nvim-treesitter/nvim-treesitter', 
            'echasnovski/mini.nvim' 
        }, 
        -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {

        },
    },

    -- Magma Python notebook style
    --{
    --   "dccsillag/magma-nvim",
    --    event = "VeryLazy",
    --},
   
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- this is an example, not a default. Please see the readme for more configuration options
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
    },

    {
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        opts = {
            backend = "kitty", -- whatever backend you would like to use
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },

    -- Multi cursor 
    --{
    --    "mg979/vim-visual-multi",
        --event = "BufRead",
        --keys = {
        --    {"n", "<C-n>", "<Plug>(VM_CreateOrToggleVisualMulti)"},
        --    {"x", "<C-n>", "<Plug>(VM_CreateOrToggleVisualMulti)"},
        --},
        --init = function()
        --    vim.g.VM_default_mappings = 0
        --    vim.g.VM_maps = {
        --        ['Find Under'] = ''
        --    }
        --    vim.g.VM_add_cursor_at_pos_no_mappings = 1
        --end,
    --},
    --
    --- Dadbod UI for mySQL
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },



}

return plugins
