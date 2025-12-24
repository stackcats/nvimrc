return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      log_level = vim.log.levels.INFO,
    })

    require("mason-lspconfig").setup({
      automatic_enable = false,
      ensure_installed = {
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "gopls",
        "elixirls",
        "clojure_lsp",
        "clangd",
        "zls",
        "ruff",
        "typos_lsp",
        "ocamllsp",
        "kotlin_lsp",
      },
    })

    local ensure_installed = {
      -- formatters
      "zprint",
      "clang-format",
      "goimports",
      "gofumpt",
      "stylua",
      "ocamlformat",
      "isort",
      "black",
      "ktfmt",

      -- linters
      "staticcheck",
      "mypy",
      {
        "selene",
        condition = function()
          -- for macos (intel)
          -- cargo install selene
          -- ln -fsv $(which selene) $HOME/.local/share/nvim/mason/bin
          return not (jit.os == "OSX" and jit.arch == "x64")
        end,
      },
      "ktlint",
    }

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
    })
  end,
}
