require("lspsaga").setup({
    lightbulb = {
        sign = false,
    },
    outline = {
        left_width = 0.5,
        layout = "float",
    },
    symbol_in_winbar = {
        enable = true,
        folder_level = 0,
        color_mode = true,
        separator = " ❱ ",
    },
})

vim.keymap.set("n", "t", "<CMD>Lspsaga term_toggle<CR>", {
    buffer = true,
    desc = "Lspsaga: Toggle terminal",
})
