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
-- line number
vim.wo.number = true

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    signs = false,
})

if jit.os == "OSX" then
    vim.opt.clipboard = "unnamed"
else
    vim.opt.clipboard = "unnamedplus"
end
