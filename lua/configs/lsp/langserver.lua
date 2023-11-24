require("configs.lsp.custom")

local servers = {
    "lua_ls",
    "pyright"
}

require("mason").setup(
    {
        log_level = vim.log.levels.INFO
    }
)

require("mason-lspconfig").setup(
    {
        ensure_installed = servers
    }
)

local lspconfig = require("lspconfig")

for _, svr in ipairs(servers) do
    lspconfig[svr].setup {
        on_attach = custom_attach,
        capabilities = custom_capabilities(),
        on_init = on_init
    }
end
