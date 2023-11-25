require("kanagawa").setup({
    -- transparent = true,
    overrides = function(colors)
        return {
            NoiceCmdlinePopupBorder = { link = "TelescopePromptBorder" },
            NoiceCmdlinePopupTitle = { link = "TelescopePromptBorder" },
            NoiceCmdlineIcon = { link = "TelescopePromptBorder" },
            LineNr = { bg = "none" },
            SignColumn = { bg = "none" },
        }
    end,
})

vim.cmd("colorscheme kanagawa")
