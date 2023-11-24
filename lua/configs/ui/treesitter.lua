local opt = {
    ensure_installed = {
        "dart",
        "lua",
        "markdown",
        "markdown_inline",
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
}

require("nvim-treesitter.configs").setup(opt)
