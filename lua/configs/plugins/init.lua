-- install lazy.vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- deps
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "nvim-lua/plenary.nvim",       lazy = true },
    -- colorscheme
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            require("configs.ui.colorscheme")
        end,
    },
    { "catppuccin/nvim",       name = "catppuccin", priority = 1000 },
    -- completions
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            {
                "hrsh7th/cmp-vsnip",
                dependencies = {
                    "hrsh7th/vim-vsnip",
                    "rafamadriz/friendly-snippets",
                },
            },
            {
                "windwp/nvim-autopairs",
                event = "InsertEnter",
                opts = {},
            },
        },
        config = function()
            require("configs.completion.cmp")
        end,
    },
    -- lsp
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            {
                "folke/trouble.nvim",
                config = function()
                    require("configs.lsp.trouble")
                end,
            },
            {
                "nvimdev/lspsaga.nvim",
                config = function()
                    require("configs.lsp.saga")
                end,
            },
            {
                "jay-babu/mason-null-ls.nvim",
                event = { "BufReadPre", "BufNewFile" },
                dependencies = {
                    "williamboman/mason.nvim",
                    "nvimtools/none-ls.nvim",
                },
                config = function()
                    require("configs.lsp.nulls")
                end,
            },
        },
        config = function()
            require("configs.lsp.langserver")
        end,
    },
    -- AI
    {
        "Exafunction/codeium.nvim",
        config = function()
            require("codeium").setup({})
        end,
    },
    -- editor
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
            "cljoly/telescope-repo.nvim",
            "nvim-telescope/telescope-project.nvim",
        },
        config = function()
            require("configs.editor.telescope")
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },
    {
        "NeogitOrg/neogit",
        config = function()
            require("configs.editor.neogit")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("configs.editor.gitsigns")
        end,
    },
    {
        "smoka7/hop.nvim",
        version = "*",
        opts = {},
    },
    {
        "numToStr/Comment.nvim",
        config = true,
    },
    {
        "t9md/vim-choosewin",
        config = function()
            require("configs.editor.choosewin")
        end,
    },
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("configs.editor.dashboard")
        end,
    },
    { "wakatime/vim-wakatime", lazy = false },
    {
        "stevearc/oil.nvim",
        opts = {},
        config = function()
            require("configs.editor.oil")
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("configs.editor.noice")
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        version = "*",
        opts = {
            open_mapping = "<c-s>",
            direction = "float",
            float_opts = {
                border = "curved",
            },
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "folke/todo-comments.nvim",
        opts = {},
    },
    -- UI
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("configs.ui.treesitter")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("configs.ui.lualine")
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        cmd = { "ColorizerToggle" },
        config = function()
            require("configs.ui.colorizer")
        end,
    },
    {
        "echasnovski/mini.indentscope",
        version = "*",
        config = function()
            require("mini.indentscope").setup()
        end,
    },
    -- Languages
    -- Dart
    {
        "akinsho/flutter-tools.nvim",
        lazy = false,
        dependencies = {
            "stevearc/dressing.nvim",
            {
                "dart-lang/dart-vim-plugin",
                init = function()
                    vim.g.dart_style_guide = 2
                    vim.g.dart_html_in_string = true
                    vim.g.dart_trailing_comma_indent = true
                    vim.g.dartfmt_options = { "--fix" }
                    vim.g.dart_format_on_save = 1
                end,
            },
            "Nash0x7E2/awesome-flutter-snippets",
        },
        config = function()
            require("configs.languages.dart")
        end,
    },

    -- Rust
    {
        "rust-lang/rust.vim",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("configs.languages.rust")
        end,
    },
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        config = function()
            require("crates").setup({
                src = {
                    cmp = {
                        enabled = true,
                    },
                },
            })
        end,
    },
    { "rose-pine/neovim", name = "rose-pine" },
}

require("lazy").setup(plugins, {
    ui = {
        border = "single",
    },
})
