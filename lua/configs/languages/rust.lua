require("configs.lsp.custom")

vim.g.rustaceanvim = {
    server = {
        on_init = on_init,
        on_attach = function(client, bufnr)
            custom_attach(client, bufnr)
            local format_sync_grp = vim.api.nvim_create_augroup("RustaceanFormat", {})

            -- format file
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format()
                end,
                group = format_sync_grp,
            })
        end,
        capabilities = custom_capabilities(),
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
}
