return {
  { "wakatime/vim-wakatime", lazy = false },
  {
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    config = function()
      local ft = { "*" }

      local options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
      }

      require("colorizer").setup(ft, options)
    end,
  },
}
