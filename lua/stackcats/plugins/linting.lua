return {
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufWritePost",
      "BufReadPost",
      "InsertLeave",
    },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        elixir = { "credo" },
        go = { "staticcheck" },
        lua = { "selene" },
        ocaml = { "ocamlformat" },
        python = { "mypy" },
        kotlin = { "ktlint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      local util = require("lspconfig/util")

      local cb = function()
        local root_dir = util.root_pattern(".git")
        lint.try_lint(nil, { cwd = root_dir })
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = lint_augroup,
        callback = cb,
      })

      vim.keymap.set("n", "<leader>l", cb, { desc = "Trigger linting for current file" })

      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        -- update_in_insert = true,
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
          numhl = {
            [vim.diagnostic.severity.WARN] = "WarningMsg",
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.INFO] = "InfoMsg",
            [vim.diagnostic.severity.HINT] = "LspDiagnosticsDefaultHint",
          },
        },
      })
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        presets = "classic",
        options = {
          show_source = true,
          multilines = {
            enabled = false,
            always_show = false,
          },
        },
      })
    end,
  },
}
