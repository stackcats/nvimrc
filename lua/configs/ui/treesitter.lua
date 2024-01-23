local opt = {
    ensure_installed = {
        "bash",
        "clojure",
        "cpp",
        "dart",
        "lua",
        "markdown",
        "markdown_inline",
        "nim",
        "regex",
        "rust",
        "python",
        "vim",
        "go",
        "elixir",
        "heex",
        "eex",
    },
    highlight = {
        enable = true,
        use_languagetree = true,
    },
    indent = {
        enable = true,
        disable = { "python", "dart" },
    },
    autopairs = {
        enable = true,
    },
    playground = {
        enable = true,
        updatetime = 25,
        persist_queries = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
}

require("nvim-treesitter.configs").setup(opt)
vim.api.nvim_command("set foldmethod=expr")
vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
vim.api.nvim_command("set nofoldenable")
