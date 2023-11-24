require("configs.lsp.custom")

require("flutter-tools").setup({
    lsp = {
        color = {
            enabled = true,
            background = true,
            virtual_text = false,
        },
        on_init = on_init,
        on_attach = function()
            custom_attach()
            vim.keymap.set(
                "n",
                "<Leader>r",
                require("telescope").extensions.flutter.commands,
                { desc = "Telescope: Flutter Commands" }
            )
        end,
        capabilities = custom_capabilities(),
    },
})
