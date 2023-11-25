local util = require("lspconfig/util")

require("configs.lsp.custom")

require("mason").setup({
    log_level = vim.log.levels.INFO,
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "rust_analyzer",
    },
})

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
    on_attach = custom_attach,
    capabilities = custom_capabilities(),
    on_init = on_init,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            diagnostics = {
                enable = true,
                globals = { "vim" },
            },
        },
    },
})

local default_servers = {
    "pyright",
}

for _, svr in ipairs(default_servers) do
    lspconfig[svr].setup({
        on_attach = custom_attach,
        capabilities = custom_capabilities(),
        on_init = on_init,
    })
end
