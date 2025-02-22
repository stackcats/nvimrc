local M = {}

M.on_init = function(client)
  vim.notify("Language Server Protocol started! [" .. client.name .. "]", vim.log.levels.INFO)
end

M.capabilities = function()
  local cmp_lsp = require("cmp_nvim_lsp")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_lsp.default_capabilities(capabilities)
  return capabilities
end

M.attach = function(_client, _bufnr)
  local keymap = vim.keymap

  local lsp_cmds = {
    hover_doc = "<CMD>Lspsaga hover_doc ++keep<CR>",
    code_action = "<CMD>Lspsaga code_action<CR>",
    goto_definition = "<CMD>Lspsaga goto_definition<CR>",
    diagnostic_jump_prev = "<CMD>Lspsaga diagnostic_jump_prev<CR>",
    diagnostic_jump_next = "<CMD>Lspsaga diagnostic_jump_next<CR>",
    rename = "<CMD>Lspsaga rename<CR>",
  }

  keymap.set("n", "K", lsp_cmds.hover_doc, { buffer = true, desc = "LSP: Show documentation" })
  keymap.set("n", "ga", lsp_cmds.code_action, { buffer = true, desc = "LSP: List LSP actions" })
  keymap.set("n", "gn", lsp_cmds.diagnostic_jump_next, { buffer = true, desc = "LSP: Jump next error" })
  keymap.set("n", "gp", lsp_cmds.diagnostic_jump_prev, { buffer = true, desc = "LSP: Jump prev error" })
  keymap.set("i", "<M-.>", lsp_cmds.goto_definition, { buffer = true, desc = "LSP: Goto definition" })
  keymap.set("i", "<M-,>", "<C-o><C-o>", { buffer = true, desc = "LSP: Goto definition" })
  keymap.set("n", "gR", lsp_cmds.rename, { buffer = true, desc = "LSP: Rename references" })
end

return M
