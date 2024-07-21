local nulls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nulls.setup({
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end
    end,
    sources = {
        -- clojure
        nulls.builtins.formatting.zprint,
        -- cpp
        nulls.builtins.formatting.clang_format,
        -- elixir
        nulls.builtins.formatting.mix,
        nulls.builtins.diagnostics.credo,
        -- golang
        nulls.builtins.formatting.goimports,
        nulls.builtins.formatting.gofmt,
        nulls.builtins.diagnostics.staticcheck,
        -- lua
        nulls.builtins.formatting.stylua,
        nulls.builtins.diagnostics.selene,
        -- nim
        nulls.builtins.formatting.nimpretty,
        -- ocaml
        nulls.builtins.formatting.ocamlformat,
        -- python
        nulls.builtins.formatting.black,
        nulls.builtins.diagnostics.mypy,
    },
})

require("mason-null-ls").setup({
    ensure_installed = {
        "typos",
        "zprint",
        "clang_format",
        "mix",
        "credo",
        "goimports",
        "gofmt",
        "staticcheck",
        "stylua",
        "selene",
        "black",
        "ruff",
        "mypy",
        "ocamlformat",
    },
    automatic_installation = true,
})

local function format()
    vim.lsp.buf.format({ async = true })
end

-- keymap
vim.keymap.set("n", "<leader>x", format, { desc = "LSP: Formats the current buffer" })
