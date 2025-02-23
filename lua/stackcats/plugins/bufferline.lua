return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      -- :help bufferline-hover-events
      hover = {
        enabled = true,
        delay = 25,
        reveal = { "close" },
      },
    },
  },
  config = function(_, opts)
    vim.opt.mousemoveevent = true
    vim.opt.termguicolors = true

    if (vim.g.colors_name or ""):find("catppuccin") then
      opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
    end

    require("bufferline").setup(opts)
  end,
}
