return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      preset = "modern",
    },
  },
  {
    "numToStr/Comment.nvim",
    config = true,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    config = function()
      require("oil").setup({})

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
  {
    "t9md/vim-choosewin",
    config = function()
      vim.g.choosewin_overlay_enable = 1
      vim.keymap.set("n", "<C-w>w", ":ChooseWin<CR>")
    end,
  },
}
