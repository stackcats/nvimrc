vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8"
vim.opt.fileformat = "unix"
vim.opt.showtabline = 0
vim.opt.signcolumn = "yes:1"
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
-- line number
vim.wo.number = true

vim.diagnostic.config({
    virtual_text = {
        source = "always",
        format = function(diagnostic)
            local lines = vim.split(diagnostic.message, "\n")
            return lines[1]
        end,
        virt_text_pos = "right_align",
    },
    severity_sort = true,
    update_in_insert = true,
    underline = true,
    signs = false,
})

if jit.os == "OSX" then
    vim.opt.clipboard = "unnamed"
else
    vim.opt.clipboard = "unnamedplus"
end

if vim.g.neovide then
    vim.o.guifont = "Hack Nerd Font Mono:h18"
    vim.g.neovide_input_macos_alt_is_meta = true
end

vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
