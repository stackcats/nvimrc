local telescope = require("telescope")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local keymap = vim.keymap

local options = {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        results_title = "",
        entry_prefix = "   ",
        multi_icon = " ❱ ",
        prompt_prefix = "❱❱ ",
        selection_caret = " ❱ ",
        initial_mode = "insert",
        selection_strategy = "reset",
        file_ignore_patterns = { "^node_modules/" },
        file_sorter = sorters.get_fzy_sorter,
        generic_sorter = sorters.get_generic_fzy_sorter,
        path_display = { "absolute" },
        winblend = 0,
        color_devicons = true,
        use_less = false,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        -- custom theme
        sorting_strategy = "descending",
        layout_config = {
            preview_cutoff = 1,
            height = 0.6,
        },
        wrap_results = true,
    },
    pickers = {
        diagnostics = {
            previewers = false,
            line_width = 0.7,
            no_unlisted = true,
            path_display = {
                "hidden",
            },
            layout_strategy = "vertical",
            layout_config = {
                width = 0.7,
            },
        },
        find_files = {
            previewer = true,
        },
        oldfiles = {
            previewer = false,
            file_ignore_patterns = {
                "/usr/share/nvim/runtime/*",
                vim.fn.stdpath("data"),
                vim.fn.stdpath("cache"),
                vim.fn.stdpath("log"),
            },
        },
        builtin = {
            previewer = false,
        },
        current_buffer_fuzzy_find = {
            previewer = false,
        },
        autocommands = {
            previewer = false,
        },
        lsp_document_symbols = {
            previewer = false,
            symbol_width = 0.7,
        },
        lsp_workspace_symbols = {
            previewer = false,
            symbol_width = 0.7,
        },
        buffers = {
            previewer = false,
            ignore_current_buffer = true,
            sort_lastused = true,
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        },
        project = {
            base_dirs = {
                "~/.config/nvim/",
                { "~/project", max_depth = 4 },
            },
        },
    },
}

telescope.setup(options)
telescope.load_extension("ui-select")
telescope.load_extension("fzy_native")
telescope.load_extension("project")

keymap.set("n", "<Leader>p", require("telescope").extensions.project.project, { desc = "Telescope: Projects" })
keymap.set("n", "<Leader>0", require("telescope.builtin").oldfiles, { desc = "Telescope: Lists previously open files" })
keymap.set(
    "n",
    "<Leader>b",
    require("telescope.builtin").buffers,
    { desc = "Telescope: Lists open buffers in current neovim instance" }
)
keymap.set("n", "<Leader>f", require("telescope.builtin").find_files, { desc = "Telescope: Open files" })
keymap.set("n", "<Leader>t", require("telescope.builtin").treesitter, { desc = "Telescope: Treesitter Picker" })
keymap.set("n", "<Leader>m", require("telescope.builtin").marks, { desc = "Telescope: Lists vim marks" })
keymap.set("n", "<Leader><Leader>", require("telescope.builtin").builtin, { desc = "Telescope: Open builtin function" })
keymap.set(
    "n",
    "<Leader>k",
    require("telescope.builtin").keymaps,
    { desc = "Telescope: Lists normal mode keymappings" }
)
keymap.set("n", "<Leader>c", require("telescope.builtin").commands, { desc = "Telescope: Lists vim autocommands" })
keymap.set("n", "<Leader>d", require("telescope.builtin").diagnostics, { desc = "Telescope: Lists diagnostics" })
keymap.set("n", "<Leader>sp", require("telescope.builtin").live_grep, { desc = "Telescope: Search Project" })
