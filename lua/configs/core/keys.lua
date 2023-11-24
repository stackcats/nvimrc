-- Use Space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

-- Save file in insert mode, same as Emacs
vim.keymap.set({ "i" }, "<C-x><C-s>", "<C-\\><C-o>:w<CR>")

vim.keymap.set({ "i" }, "<C-a>", "<Home>")
vim.keymap.set({ "i" }, "<C-e>", "<End>")

vim.keymap.set({ "i" }, "<C-b>", "<C-o>h")
vim.keymap.set({ "i" }, "<C-n>", "<C-o>j")
vim.keymap.set({ "i" }, "<C-p>", "<C-o>k")
vim.keymap.set({ "i" }, "<C-f>", "<C-o>l")
