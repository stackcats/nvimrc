local neogit = require("neogit")
local keymap = vim.keymap

neogit.setup {}

local function run_neogit()
    vim.cmd("Neogit")
end

keymap.set("n", "<Leader>g", run_neogit, {desc = "Neogit: a magit clone"})
