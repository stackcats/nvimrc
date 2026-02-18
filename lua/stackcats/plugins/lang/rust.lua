return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  config = function()
    local custom = require("stackcats.plugins.utils.lsp")

    vim.g.rustaceanvim = {
      server = {
        on_init = custom.on_init,
        on_attach = function(client, bufnr)
          custom.attach(client, bufnr)
          local format_sync_grp = vim.api.nvim_create_augroup("RustaceanFormat", {})

          -- format file
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
            group = format_sync_grp,
          })
        end,
        capabilities = custom.capabilities(),
        settings = {
          ["rust-analyzer"] = {
            notifications = {
              cargoTomlNotFound = false,
            },
          },
        },
      },
    }
  end,
}
