local km = vim.keymap

-- Use Space as leader key
km.set({ "n", "v" }, "<Space>", "<Nop>")

km.set({ "i" }, "<C-a>", "<Home>")
km.set({ "i" }, "<C-e>", "<End>")

km.set({ "i" }, "<C-b>", "<C-o>h")
km.set({ "i" }, "<C-n>", "<C-o>j")
km.set({ "i" }, "<C-p>", "<C-o>k")
km.set({ "i" }, "<C-f>", "<C-o>l")
