return {
  "akinsho/flutter-tools.nvim",
  dependencies = {
    "stevearc/dressing.nvim",
    {
      "dart-lang/dart-vim-plugin",
      init = function()
        vim.g.dart_style_guide = 2
        vim.g.dart_html_in_string = true
        vim.g.dart_trailing_comma_indent = true
        vim.g.dartfmt_options = { "--fix" }
        vim.g.dart_format_on_save = 1
      end,
    },
    "Nash0x7E2/awesome-flutter-snippets",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local custom = require("stackcats.plugins.utils.lsp")

    require("flutter-tools").setup({
      lsp = {
        color = {
          enabled = true,
          background = true,
          virtual_text = false,
        },
        on_init = custom.on_init,
        on_attach = function()
          custom.attach()
          vim.keymap.set(
            "n",
            "<Leader>sf",
            require("telescope").extensions.flutter.commands,
            { desc = "Telescope: Flutter Commands" }
          )
        end,
        capabilities = custom.capabilities(),
      },
      decorations = {
        statusline = {
          app_version = true,
        },
      },
    })
  end,
}
