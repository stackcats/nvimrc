require("configs.lsp.custom")

local rt = require("rust-tools")

rt.setup({
    server = {
        on_init = on_init,
        on_attach = custom_attach,
        capabilities = custom_capabilities(),
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})
