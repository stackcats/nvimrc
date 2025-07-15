return {
  "nvimdev/lspsaga.nvim",
  --    commit = '4b0f0e2',
  config = function()
    require("lspsaga").setup({
      lightbulb = {
        enable = false,
      },
      outline = {
        left_width = 0.5,
        layout = "float",
      },
      symbol_in_winbar = {
        enable = true,
        folder_level = 0,
        color_mode = true,
        separator = " ❱ ",
      },
    })
  end,
}
