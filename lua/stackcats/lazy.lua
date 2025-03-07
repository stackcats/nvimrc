local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  { import = "stackcats.plugins" },
  { import = "stackcats.plugins.lsp" },
  { import = "stackcats.plugins.lang" },
}

local opts = {
  ui = {
    border = "single",
  },
}

require("lazy").setup(plugins, opts)
