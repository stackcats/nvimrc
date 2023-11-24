local nulls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nulls.setup(
    {
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
                vim.api.nvim_create_autocmd(
                    "BufWritePre",
                    {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format()
                        end
                    }
                )
            end
        end,
        sources = {
            -- lua
            nulls.builtins.formatting.stylua,
            -- python
            nulls.builtins.formatting.black
        }
    }
)

require("mason-null-ls").setup(
    {
        ensure_installed = {
            "black",
            "ruff",
            "stylua",
            "selene"
        },
        automatic_installation = true
    }
)

local function format()
    vim.lsp.buf.format({async = true})
end

-- keymap
vim.keymap.set("n", "<leader>x", format, {desc = "LSP: Formats the current buffer"})
