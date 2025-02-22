return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▐" },
          change = { text = "▐" },
          delete = { text = "▐" },
          topdelete = { text = "▐" },
          changedelete = { text = "▐" },
          untracked = { text = "▐" },
        },
        current_line_blame = true,
      })

      vim.cmd("hi GitSignsChange guibg=NONE")
      vim.cmd("hi GitSignsAdd guibg=NONE")
      vim.cmd("hi GitSignsDelete guibg=NONE")
    end,
  },
}
