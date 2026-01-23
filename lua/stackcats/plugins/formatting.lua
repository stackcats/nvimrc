return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    local formatters_by_ft = {
      clojure = { "zprint" },
      cpp = { "clang-format" },
      elixir = { "mix" },
      go = { "goimports", "gofmt" },
      lua = { "stylua" },
      ocaml = { "ocamlformat" },
      python = { "isort", "black" },
      kotlin = { "ktfmt" },
    }

    local formatters = {
      rustfmt = {
        options = {
          default_edition = "2021",
        },
      },
      ktfmt = {
        prepend_args = { "--kotlinlang-style" },
      },
    }

    conform.setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 2500,
      },
      formatters == formatters,
    })

    vim.keymap.set({ "n", "v" }, "<leader>x", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
