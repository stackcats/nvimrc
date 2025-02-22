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

      -- linters
      "staticcheck",
      "mypy",
    }

    if not (jit.os == "OSX" and jit.arch == "x64") then
      -- for macos (intel)
      -- cargo install selene
      -- ln -fsv $(which selene) $HOME/.local/share/nvim/mason/bin
      table.insert(ensure_installed, "selene")
    end

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
    })
  end,
}
