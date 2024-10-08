function on_init()
    vim.notify("Language Server Protocol started!", vim.log.levels.INFO)
end

function custom_capabilities()
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_lsp.default_capabilities(capabilities)
    return capabilities
end

function custom_attach()
    local keymap = vim.keymap

    local lsp_cmds = {
        hover_doc = "<CMD>Lspsaga hover_doc ++keep<CR>",
        lsp_document_symbols = require("telescope.builtin").lsp_document_symbols,
        code_action = "<CMD>Lspsaga code_action<CR>",
        goto_definition = "<CMD>Lspsaga goto_definition<CR>",
        diagnostic_jump_prev = "<CMD>Lspsaga diagnostic_jump_prev<CR>",
        diagnostic_jump_next = "<CMD>Lspsaga diagnostic_jump_next<CR>",
        rename = "<CMD>Lspsaga rename<CR>",
        trouble_toggle_doc = "<CMD>TroubleToggle document_diagnostics<CR>",
        trouble_toggle_workspace = "<CMD>TroubleToggle workspace_diagnostics<CR>",
    }

    keymap.set("n", "K", lsp_cmds.hover_doc, { buffer = true, desc = "LSP: Show documentation" })
    keymap.set("n", "<Leader>a", lsp_cmds.lsp_document_symbols, { desc = "LSP: List LSP document symbols" })
    keymap.set("n", "ga", lsp_cmds.code_action, { buffer = true, desc = "LSP: List LSP actions" })
    keymap.set("n", "gd", lsp_cmds.goto_definition, { buffer = true, desc = "LSP: Goto definition" })
    keymap.set("n", "gn", lsp_cmds.diagnostic_jump_next, { buffer = true, desc = "LSP: Jump next error" })
    keymap.set("n", "gp", lsp_cmds.diagnostic_jump_prev, { buffer = true, desc = "LSP: Jump prev error" })
    keymap.set("i", "<M-.>", lsp_cmds.goto_definition, { buffer = true, desc = "LSP: Goto definition" })
    keymap.set("i", "<M-,>", "<C-o><C-o>", { buffer = true, desc = "LSP: Goto definition" })
    keymap.set("n", "gR", lsp_cmds.rename, { buffer = true, desc = "LSP: Rename references" })
end
