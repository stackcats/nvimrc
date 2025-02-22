return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        -- transparent = true,
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        custom_highlights = function(colors)
          return {
            -- for snacks picker
            NormalFloat = { bg = colors.base, fg = colors.text },
          }
        end,
      })
    end,
  },
  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
}
