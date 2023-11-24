require("gitsigns").setup {
    signs = {
        add = {hl = "GitSignsAdd", text = "▐"},
        change = {hl = "GitSignsChange", text = "▐"},
        delete = {hl = "GitSignsDelete", text = "▐"},
        topdelete = {hl = "GitSignsDelete", text = "▐"},
        changedelete = {hl = "GitSignsChange", text = "▐"},
        untracked = {hl = "GitSignsAdd", text = "▐"}
    },
    current_line_blame = true
}

vim.cmd("hi GitSignsChange guibg=NONE")
vim.cmd("hi GitSignsAdd guibg=NONE")
vim.cmd("hi GitSignsDelete guibg=NONE")
