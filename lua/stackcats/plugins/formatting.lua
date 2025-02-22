return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    local formatters_by_ft = {
      clojure = { "zprint" },
      cpp = { "clang-format" },
      elixir = { "mix" },
      go = { "goimports", "gofumpt" },
      lua = { "stylua" },
      ocaml = { "ocamlformat" },
      python = { "isort", "black" },
    }

    conform.setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
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
