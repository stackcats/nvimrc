return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
  },
  config = function()
    local util = require("lspconfig/util")

    local merge = function(args, defaults)
      args = args or {}
      defaults = defaults or {}
      return vim.tbl_deep_extend("force", {}, defaults, args)
    end

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            diagnostics = {
              enable = true,
              globals = { "vim", "Snacks" },
            },
          },
        },
      },
      elixirls = {
        cmd = { "elixir-ls" },
      },
      clangd = {
        cmd = { "clangd", "--offset-encoding=utf-16" },
      },
      zls = {
        cmd = { "zls" },
        filetypes = { "zig", "zirc" },
        root_dir = util.root_pattern("build.zig", "build.zir", "zls.json", ".git"),
        single_file_support = true,
      },
      ocamllsp = {
        {
          settings = {
            codelens = { enable = true },
          },
        },
      },
      pyright = {},
      gopls = {},
      ruff = {},
      typos_lsp = {},
    }

    local custom = require("stackcats.plugins.utils.lsp")

    local lspconfig = require("lspconfig")

    for svr, opt in pairs(servers) do
      lspconfig[svr].setup(merge(opt, {
        on_attach = custom.attach,
        capabilities = custom.capabilities(),
        on_init = custom.on_init,
      }))
    end
  end,
}
