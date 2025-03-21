local base = require("plugins.configs.lspconfig")
local config = require("plugins.configs.lspconfig")
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
    on_attach = function (client, bufnr)
        -- client.server_capabilities.signatureHelpProvider = false -- clangd supports signature help but it's not working properly
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    filetypes = {"c", "cpp"},
    --root_dir = lspconfig.util.root_pattern("Cargo.toml"),
})

lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"python"},
})

