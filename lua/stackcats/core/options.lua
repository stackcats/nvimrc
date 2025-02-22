local opt = vim.opt

opt.autoindent = true
opt.cursorline = true
opt.encoding = "utf-8"
opt.fileencodings = "utf-8"
opt.fileformat = "unix"
opt.showtabline = 0
opt.signcolumn = "yes:1"
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = true
-- opt.cmdheight = 0

if jit.os == "OSX" then
  opt.clipboard = "unnamed"
else
  opt.clipboard = "unnamedplus"
end

if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font:h16"
end

vim.wo.number = true
