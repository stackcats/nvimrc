require("kanagawa").setup({
    colors = {
        theme = {
            all = {
                ui = {
                    bg_gutter = "none",
                },
            },
        },
    },
    -- transparent = true,
})

vim.cmd("colorscheme kanagawa")
