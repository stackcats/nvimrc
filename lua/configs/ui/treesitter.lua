local opt = {
    ensure_installed = {
        "dart",
        "lua",
        "markdown",
        "markdown_inline",
        "rust",
        "python",
    },
    highlight = {
        enable = true,
        use_languagetree = true,
    },
    indent = {
        enable = true,
        disable = { "python" },
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
